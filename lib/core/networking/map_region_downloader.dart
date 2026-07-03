import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_progect/core/helpers/map_tile_cache_service.dart';
import 'package:graduation_progect/core/networking/app_config.dart';
import 'package:graduation_progect/features/shared_screens/map/data/map_constants.dart';

/// تقدّم تحميل منطقة، يُستخدم لتحديث UI شريط التقدم.
class RegionDownloadProgress {
  final int downloaded;
  final int total;
  final bool isComplete;

  const RegionDownloadProgress({
    required this.downloaded,
    required this.total,
    required this.isComplete,
  });

  double get percentage => total == 0 ? 0 : downloaded / total;
}

/// يحمّل Tiles محافظة كاملة (حسب [MapConstants.governorateData]) مسبقاً
/// إلى كاش Hive، لتُستخدم لاحقاً بدون اتصال بالإنترنت.
///
/// يُستخدم عادة من شاشة "تحميل الخريطة أوفلاين" في إعدادات المستخدم،
/// أو من شاشة تفاصيل الشحنة لتحميل منطقتها مسبقاً.
class MapRegionDownloader {
  MapRegionDownloader._();

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'User-Agent': AppConfig.userAgent},
    ),
  );

  static bool _isDownloading = false;
  static bool get isDownloading => _isDownloading;

  static bool _cancelRequested = false;

  /// إلغاء أي تحميل جارٍ.
  static void cancel() => _cancelRequested = true;

  /// يحمّل Tiles ضمن حدود [bounds] للمستويات [minZoom] إلى [maxZoom].
  /// [onProgress] يُستدعى بعد كل دفعة لتحديث شريط التقدم في الواجهة.
  static Future<void> downloadRegion({
    required LatLngBounds bounds,
    int minZoom = 11,
    int maxZoom = 15,
    int concurrency = 4,
    void Function(RegionDownloadProgress progress)? onProgress,
  }) async {
    if (_isDownloading) return;
    _isDownloading = true;
    _cancelRequested = false;

    try {
      final tileCoords = _tilesInBounds(bounds, minZoom, maxZoom);
      final total = tileCoords.length;
      var downloaded = 0;

      // تحميل بدفعات صغيرة متوازية، بدل تسلسلي بطيء أو متوازي بالكامل يُثقل الجهاز والخادم
      for (var i = 0; i < tileCoords.length; i += concurrency) {
        if (_cancelRequested) break;

        final batch = tileCoords.skip(i).take(concurrency);
        await Future.wait(batch.map((coord) async {
          if (_cancelRequested) return;
          final z = coord.$1, x = coord.$2, y = coord.$3;

          if (MapTileCacheService.hasTile(z, x, y)) {
            downloaded++;
            return;
          }

          try {
            final url = AppConfig.mapTileUrl
                .replaceAll('{z}', '$z')
                .replaceAll('{x}', '$x')
                .replaceAll('{y}', '$y');

            final response = await _dio.get<List<int>>(
              url,
              options: Options(responseType: ResponseType.bytes),
            );

            if (response.data != null && response.data!.isNotEmpty) {
              await MapTileCacheService.saveTile(
                z,
                x,
                y,
                Uint8List.fromList(response.data!),
              );
            }
          } catch (_) {
            // تجاهل فشل تايل منفردة وتابع الباقي، لا نوقف التحميل كله لأجل تايل واحدة
          }
          downloaded++;
        }));

        onProgress?.call(
          RegionDownloadProgress(
            downloaded: downloaded,
            total: total,
            isComplete: downloaded >= total,
          ),
        );
      }
    } finally {
      _isDownloading = false;
    }
  }

  /// اختصار: يحمّل منطقة محافظة بالـ id كما هي معرّفة في [MapConstants.governorateData].
  static Future<void> downloadGovernorate(
    int governorateId, {
    int minZoom = 11,
    int maxZoom = 15,
    void Function(RegionDownloadProgress progress)? onProgress,
  }) async {
    final data = MapConstants.governorateData[governorateId];
    if (data == null) return;
    final bounds = data['bounds'] as LatLngBounds;
    await downloadRegion(
      bounds: bounds,
      minZoom: minZoom,
      maxZoom: maxZoom,
      onProgress: onProgress,
    );
  }

  /// يحوّل حدود جغرافية إلى قائمة إحداثيات Tiles (z, x, y) لكل مستوى تكبير،
  /// عبر معادلة Web Mercator القياسية المستخدمة في كل خرائط الـ Slippy Map.
  static List<(int, int, int)> _tilesInBounds(
    LatLngBounds bounds,
    int minZoom,
    int maxZoom,
  ) {
    final result = <(int, int, int)>[];

    for (var z = minZoom; z <= maxZoom; z++) {
      final topLeft = _latLngToTile(bounds.north, bounds.west, z);
      final bottomRight = _latLngToTile(bounds.south, bounds.east, z);

      for (var x = topLeft.$1; x <= bottomRight.$1; x++) {
        for (var y = topLeft.$2; y <= bottomRight.$2; y++) {
          result.add((z, x, y));
        }
      }
    }
    return result;
  }

  static (int, int) _latLngToTile(double lat, double lng, int zoom) {
    final n = 1 << zoom;
    final x = ((lng + 180.0) / 360.0 * n).floor();
    final latRad = lat * math.pi / 180.0;
    final y = ((1.0 - math.log(math.tan(latRad) + 1.0 / math.cos(latRad)) / math.pi) /
            2.0 *
            n)
        .floor();
    return (x.clamp(0, n - 1), y.clamp(0, n - 1));
  }
}
