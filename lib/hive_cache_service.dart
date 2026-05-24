import 'dart:convert';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCacheService {
  HiveCacheService._();

  static const String _profileBox = 'profile_box';
  static const String _driverImageBox = 'driver_image_box';
  static const String _reviewsBox = 'reviews_box';
  static const String _vehicleTypesBox = 'vehicle_types_box';
  static const String _governoratesBox = 'governorates_box';
  static const String _notificationsBox = 'notifications_box';
  static const String _driverShipmentsBox = 'driver_shipments_box';
  static const String _clientShipmentsBox = 'client_shipments_box';
  static const String _metaBox = 'meta_box';

  static late Box<String> _profileBoxInst;
  static late Box<Uint8List> _driverImageBoxInst;
  static late Box<String> _reviewsBoxInst;
  static late Box<String> _vehicleTypesBoxInst;
  static late Box<String> _governoratesBoxInst;
  static late Box<String> _notificationsBoxInst;
  static late Box<String> _driverShipmentsBoxInst;
  static late Box<String> _clientShipmentsBoxInst;
  static late Box<String> _metaBoxInst;

  static Future<void> init() async {
    await Hive.initFlutter();
    _profileBoxInst = await Hive.openBox<String>(_profileBox);
    _driverImageBoxInst = await Hive.openBox<Uint8List>(_driverImageBox);
    _reviewsBoxInst = await Hive.openBox<String>(_reviewsBox);
    _vehicleTypesBoxInst = await Hive.openBox<String>(_vehicleTypesBox);
    _governoratesBoxInst = await Hive.openBox<String>(_governoratesBox);
    _notificationsBoxInst = await Hive.openBox<String>(_notificationsBox);
    _driverShipmentsBoxInst = await Hive.openBox<String>(_driverShipmentsBox);
    _clientShipmentsBoxInst = await Hive.openBox<String>(_clientShipmentsBox);
    _metaBoxInst = await Hive.openBox<String>(_metaBox);
  }

  static Future<void> _writeString(
    Box<String> box,
    String key,
    String jsonString,
  ) async {
    await box.put(key, jsonString);
    await _metaBoxInst.put('${key}_hash', _hash(jsonString));
  }

  static String? _readString(Box<String> box, String key) => box.get(key);

  static Future<void> _deleteString(Box<String> box, String key) async {
    await box.delete(key);
    await _metaBoxInst.delete('${key}_hash');
  }

  static bool hasChanged(String key, String newJsonString) {
    final stored = _metaBoxInst.get('${key}_hash');
    return stored != _hash(newJsonString);
  }

  static String _hash(String s) {
    var h = 5381;
    for (var i = 0; i < s.length; i++) {
      h = ((h << 5) + h) + s.codeUnitAt(i);
      h &= 0xFFFFFFFF;
    }
    return h.toString();
  }

  static const String _profileKey = 'profile';

  static Future<void> cacheProfile(Map<String, dynamic> data) async {
    await _writeString(_profileBoxInst, _profileKey, jsonEncode(data));
  }

  static Map<String, dynamic>? getCachedProfile() {
    final raw = _readString(_profileBoxInst, _profileKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> clearProfile() async =>
      _deleteString(_profileBoxInst, _profileKey);

  static String _driverImageKey(int driverId) => 'driver_img_$driverId';

  static Future<void> cacheDriverImage(
    int driverId,
    Uint8List imageBytes, {
    String? imageUrl,
  }) async {
    await _driverImageBoxInst.put(_driverImageKey(driverId), imageBytes);
    if (imageUrl != null) {
      await _metaBoxInst.put('${_driverImageKey(driverId)}_url', imageUrl);
    }
  }

  static Uint8List? getCachedDriverImage(int driverId) =>
      _driverImageBoxInst.get(_driverImageKey(driverId));

  static String? getCachedDriverImageUrl(int driverId) =>
      _metaBoxInst.get('${_driverImageKey(driverId)}_url');

  static Future<void> clearDriverImage(int driverId) async {
    await _driverImageBoxInst.delete(_driverImageKey(driverId));
    await _metaBoxInst.delete('${_driverImageKey(driverId)}_url');
  }

  static String _reviewsKey(int driverId) => 'reviews_$driverId';

  static Future<void> cacheDriverReviews(
    int driverId,
    Map<String, dynamic> data,
  ) async {
    await _writeString(
      _reviewsBoxInst,
      _reviewsKey(driverId),
      jsonEncode(data),
    );
  }

  static Map<String, dynamic>? getCachedDriverReviews(int driverId) {
    final raw = _readString(_reviewsBoxInst, _reviewsKey(driverId));
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static const String _vehicleTypesKey = 'vehicle_types';

  static Future<void> cacheVehicleTypes(List<Map<String, dynamic>> data) async {
    await _writeString(
      _vehicleTypesBoxInst,
      _vehicleTypesKey,
      jsonEncode(data),
    );
  }

  static List<Map<String, dynamic>>? getCachedVehicleTypes() {
    final raw = _readString(_vehicleTypesBoxInst, _vehicleTypesKey);
    if (raw == null) return null;
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  static bool vehicleTypesChanged(List<Map<String, dynamic>> newData) =>
      hasChanged(_vehicleTypesKey, jsonEncode(newData));

  static const String _governoratesKey = 'governorates';

  static Future<void> cacheGovernorates(List<Map<String, dynamic>> data) async {
    await _writeString(
      _governoratesBoxInst,
      _governoratesKey,
      jsonEncode(data),
    );
  }

  static List<Map<String, dynamic>>? getCachedGovernorates() {
    final raw = _readString(_governoratesBoxInst, _governoratesKey);
    if (raw == null) return null;
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  static bool governoratesChanged(List<Map<String, dynamic>> newData) =>
      hasChanged(_governoratesKey, jsonEncode(newData));

  static const String _notifCountKey = 'notif_count';
  static const String _notifCountAtKey = 'notif_count_at';
  static const Duration _notifCountAntiSpam = Duration(seconds: 30);

  static Future<void> cacheNotificationCount(int count) async {
    await _metaBoxInst.put(_notifCountKey, count.toString());
    await _metaBoxInst.put(
      _notifCountAtKey,
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  static int? getCachedNotificationCount() {
    final raw = _metaBoxInst.get(_notifCountKey);
    return raw != null ? int.tryParse(raw) : null;
  }

  /// True if the cached count is still within the anti-spam window.
  static bool isNotifCountFresh() {
    final atStr = _metaBoxInst.get(_notifCountAtKey);
    if (atStr == null) return false;
    final at = DateTime.fromMillisecondsSinceEpoch(int.parse(atStr));
    return DateTime.now().difference(at) < _notifCountAntiSpam;
  }

  static String _driverShipmentKey(int page) => 'drv_page_$page';

  static Future<void> cacheDriverShipmentsPage(
    int page,
    Map<String, dynamic> json,
  ) async {
    await _writeString(
      _driverShipmentsBoxInst,
      _driverShipmentKey(page),
      jsonEncode(json),
    );
  }

  static Map<String, dynamic>? getCachedDriverShipmentsPage(int page) {
    final raw = _readString(_driverShipmentsBoxInst, _driverShipmentKey(page));
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> clearDriverShipmentPages() async {
    final keys = _driverShipmentsBoxInst.keys.toList();
    await Future.wait([
      _driverShipmentsBoxInst.deleteAll(keys),
      ...keys.map((k) => _metaBoxInst.delete('${k}_hash')),
    ]);
  }

  // ─── Client Shipments (paginated) ──────────────────────────────────────────
  static String _clientShipmentKey(int page) => 'cli_page_$page';

  static Future<void> cacheClientShipmentsPage(
    int page,
    Map<String, dynamic> json,
  ) async {
    await _writeString(
      _clientShipmentsBoxInst,
      _clientShipmentKey(page),
      jsonEncode(json),
    );
  }

  static Map<String, dynamic>? getCachedClientShipmentsPage(int page) {
    final raw = _readString(_clientShipmentsBoxInst, _clientShipmentKey(page));
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> clearClientShipmentPages() async {
    final keys = _clientShipmentsBoxInst.keys.toList();
    await Future.wait([
      _clientShipmentsBoxInst.deleteAll(keys),
      ...keys.map((k) => _metaBoxInst.delete('${k}_hash')),
    ]);
  }

  static Future<void> clearAll() async {
    await Future.wait([
      _profileBoxInst.clear(),
      _driverImageBoxInst.clear(),
      _reviewsBoxInst.clear(),
      _vehicleTypesBoxInst.clear(),
      _governoratesBoxInst.clear(),
      _notificationsBoxInst.clear(),
      _driverShipmentsBoxInst.clear(),
      _clientShipmentsBoxInst.clear(),
      _metaBoxInst.clear(),
    ]);
  }
}
