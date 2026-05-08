import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// Central Hive cache service.
/// All boxes are opened once at app startup and reused throughout the session.
/// Each entry is wrapped in a [CacheEntry] that stores the raw JSON string
/// alongside a `cachedAt` timestamp, enabling TTL-based invalidation and
/// change-detection (ETag-like hash comparison).
class HiveCacheService {
  HiveCacheService._();

  // ─── Box names ───────────────────────────────────────────────────────────
  static const String _vehicleTypesBox = 'vehicle_types_box';
  static const String _profileBox = 'profile_box';
  static const String _notificationsBox = 'notifications_box';
  static const String _shipmentsBox = 'shipments_box';
  static const String _governoratesBox = 'governorates_box';
  static const String _metaBox = 'meta_box'; // TTL timestamps & hashes

  // ─── Box instances (opened once) ─────────────────────────────────────────
  static late Box<String> _vehicleTypesBoxInstance;
  static late Box<String> _profileBoxInstance;
  static late Box<String> _notificationsBoxInstance;
  static late Box<String> _shipmentsBoxInstance;
  static late Box<String> _governoratesBoxInstance;
  static late Box<String> _metaBoxInstance;

  // ─── TTL durations per data type ─────────────────────────────────────────
  static const Duration _vehicleTypesTtl = Duration(days: 7);
  static const Duration _profileTtl = Duration(hours: 1);
  static const Duration _notificationsTtl = Duration(minutes: 5);
  static const Duration _shipmentsTtl = Duration(minutes: 10);
  static const Duration _governoratesTtl = Duration(days: 30);

  // ─── Init ─────────────────────────────────────────────────────────────────

  static Future<void> init() async {
    await Hive.initFlutter();

    _vehicleTypesBoxInstance = await Hive.openBox<String>(_vehicleTypesBox);
    _profileBoxInstance = await Hive.openBox<String>(_profileBox);
    _notificationsBoxInstance = await Hive.openBox<String>(_notificationsBox);
    _shipmentsBoxInstance = await Hive.openBox<String>(_shipmentsBox);
    _governoratesBoxInstance = await Hive.openBox<String>(_governoratesBox);
    _metaBoxInstance = await Hive.openBox<String>(_metaBox);
  }

  // ─── Generic helpers ─────────────────────────────────────────────────────

  /// Writes [jsonString] to [box] under [key] and records the timestamp in
  /// the meta-box.  Also stores a lightweight hash so callers can detect
  /// whether the server actually returned new data.
  static Future<void> _write(
    Box<String> box,
    String key,
    String jsonString,
  ) async {
    await box.put(key, jsonString);
    await _metaBoxInstance.put(
      '${key}_at',
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
    // store hash for change-detection
    await _metaBoxInstance.put('${key}_hash', _hash(jsonString));
  }

  /// Returns the raw JSON string stored under [key], or `null` if absent or
  /// if the entry is older than [ttl].
  static String? _read(Box<String> box, String key, Duration ttl) {
    final raw = box.get(key);
    if (raw == null) return null;

    final atStr = _metaBoxInstance.get('${key}_at');
    if (atStr == null) return null;

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(int.parse(atStr));
    if (DateTime.now().difference(cachedAt) > ttl) return null; // expired

    return raw;
  }

  /// Returns `true` when [newJsonString] differs from what is stored,
  /// meaning the server returned genuinely new data.
  static bool hasChanged(String key, String newJsonString) {
    final storedHash = _metaBoxInstance.get('${key}_hash');
    return storedHash != _hash(newJsonString);
  }

  static String _hash(String s) {
    // Lightweight non-crypto hash (djb2 variant) – fast and collision-resistant
    // enough for change-detection.
    var h = 5381;
    for (var i = 0; i < s.length; i++) {
      h = ((h << 5) + h) + s.codeUnitAt(i);
      h &= 0xFFFFFFFF;
    }
    return h.toString();
  }

  static Future<void> _delete(Box<String> box, String key) async {
    await box.delete(key);
    await _metaBoxInstance.delete('${key}_at');
    await _metaBoxInstance.delete('${key}_hash');
  }

  // ─── Vehicle Types ────────────────────────────────────────────────────────

  static const String _vehicleTypesKey = 'vehicle_types';

  static Future<void> cacheVehicleTypes(List<Map<String, dynamic>> data) async {
    await _write(
      _vehicleTypesBoxInstance,
      _vehicleTypesKey,
      jsonEncode(data),
    );
  }

  static List<Map<String, dynamic>>? getCachedVehicleTypes() {
    final raw = _read(
      _vehicleTypesBoxInstance,
      _vehicleTypesKey,
      _vehicleTypesTtl,
    );
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  static bool vehicleTypesChanged(List<Map<String, dynamic>> newData) =>
      hasChanged(_vehicleTypesKey, jsonEncode(newData));

  // ─── Governorates ─────────────────────────────────────────────────────────

  static const String _governoratesKey = 'governorates';

  static Future<void> cacheGovernorates(
    List<Map<String, dynamic>> data,
  ) async {
    await _write(
      _governoratesBoxInstance,
      _governoratesKey,
      jsonEncode(data),
    );
  }

  static List<Map<String, dynamic>>? getCachedGovernorates() {
    final raw = _read(
      _governoratesBoxInstance,
      _governoratesKey,
      _governoratesTtl,
    );
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  static bool governoratesChanged(List<Map<String, dynamic>> newData) =>
      hasChanged(_governoratesKey, jsonEncode(newData));

  // ─── Profile ──────────────────────────────────────────────────────────────

  static const String _profileKey = 'profile';

  static Future<void> cacheProfile(Map<String, dynamic> data) async {
    await _write(_profileBoxInstance, _profileKey, jsonEncode(data));
  }

  static Map<String, dynamic>? getCachedProfile() {
    final raw = _read(_profileBoxInstance, _profileKey, _profileTtl);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static bool profileChanged(Map<String, dynamic> newData) =>
      hasChanged(_profileKey, jsonEncode(newData));

  static Future<void> clearProfile() async =>
      _delete(_profileBoxInstance, _profileKey);

  // ─── Notifications ────────────────────────────────────────────────────────

  static const String _notificationsKey = 'notifications';
  static const String _notifCountKey = 'notif_count';

  static Future<void> cacheNotifications(
    List<Map<String, dynamic>> data,
  ) async {
    await _write(
      _notificationsBoxInstance,
      _notificationsKey,
      jsonEncode(data),
    );
  }

  static List<Map<String, dynamic>>? getCachedNotifications() {
    final raw = _read(
      _notificationsBoxInstance,
      _notificationsKey,
      _notificationsTtl,
    );
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  static bool notificationsChanged(List<Map<String, dynamic>> newData) =>
      hasChanged(_notificationsKey, jsonEncode(newData));

  static Future<void> cacheNotificationCount(int count) async {
    await _metaBoxInstance.put(_notifCountKey, count.toString());
  }

  static int? getCachedNotificationCount() {
    final raw = _metaBoxInstance.get(_notifCountKey);
    return raw != null ? int.tryParse(raw) : null;
  }

  // ─── Shipments (paginated) ────────────────────────────────────────────────

  /// Caches a single page of shipments.
  static Future<void> cacheShipmentsPage(
    int page,
    Map<String, dynamic> responseJson,
  ) async {
    final key = 'shipments_page_$page';
    await _write(_shipmentsBoxInstance, key, jsonEncode(responseJson));
  }

  static Map<String, dynamic>? getCachedShipmentsPage(int page) {
    final key = 'shipments_page_$page';
    final raw = _read(_shipmentsBoxInstance, key, _shipmentsTtl);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static bool shipmentsPageChanged(
    int page,
    Map<String, dynamic> newResponse,
  ) {
    final key = 'shipments_page_$page';
    return hasChanged(key, jsonEncode(newResponse));
  }

  /// Clears all cached shipment pages (call after pull-to-refresh).
  static Future<void> clearAllShipmentPages() async {
    final keys = _shipmentsBoxInstance.keys
        .where((k) => k.toString().startsWith('shipments_page_'))
        .toList();
    for (final k in keys) {
      await _shipmentsBoxInstance.delete(k);
      await _metaBoxInstance.delete('${k}_at');
      await _metaBoxInstance.delete('${k}_hash');
    }
  }

  // ─── Driver Reviews ───────────────────────────────────────────────────────

  static const Duration _reviewsTtl = Duration(hours: 2);

  static String _reviewsKey(int driverId) => 'reviews_$driverId';

  static Future<void> cacheDriverReviews(
    int driverId,
    Map<String, dynamic> data,
  ) async {
    await _write(
      _profileBoxInstance,
      _reviewsKey(driverId),
      jsonEncode(data),
    );
  }

  static Map<String, dynamic>? getCachedDriverReviews(int driverId) {
    final raw =
        _read(_profileBoxInstance, _reviewsKey(driverId), _reviewsTtl);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static bool driverReviewsChanged(
    int driverId,
    Map<String, dynamic> newData,
  ) =>
      hasChanged(_reviewsKey(driverId), jsonEncode(newData));

  // ─── Full cache clear (logout) ────────────────────────────────────────────

  static Future<void> clearAll() async {
    await _vehicleTypesBoxInstance.clear();
    await _profileBoxInstance.clear();
    await _notificationsBoxInstance.clear();
    await _shipmentsBoxInstance.clear();
    await _governoratesBoxInstance.clear();
    await _metaBoxInstance.clear();
  }
}
