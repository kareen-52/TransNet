import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_progect/core/helpers/map_tile_cache_service.dart';
import 'package:graduation_progect/core/networking/app_config.dart';


class CachedNetworkTileProvider extends TileProvider {
  final bool isOffline;
  final Dio _dio;

  CachedNetworkTileProvider({this.isOffline = false, Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 8),
                receiveTimeout: const Duration(seconds: 8),
                headers: {'User-Agent': AppConfig.userAgent},
              ),
            );

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final z = coordinates.z.toInt();
    final x = coordinates.x;
    final y = coordinates.y;

    final cached = MapTileCacheService.getTile(z, x, y);
    if (cached != null) {
      return MemoryImage(cached);
    }

    if (isOffline) {
      return MemoryImage(_emptyTileBytes);
    }

    return _CachedNetworkTileImage(
      url: getTileUrl(coordinates, options),
      z: z,
      x: x,
      y: y,
      dio: _dio,
    );
  }
}

final Uint8List _emptyTileBytes = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x64, 0x60, 0x60, 0x60,
  0x60, 0x00, 0x00, 0x00, 0x05, 0x00, 0x01, 0x5C, 0xCD, 0xFF, 0x69, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

class _CachedNetworkTileImage extends ImageProvider<_CachedNetworkTileImage> {
  final String url;
  final int z, x, y;
  final Dio dio;

  const _CachedNetworkTileImage({
    required this.url,
    required this.z,
    required this.x,
    required this.y,
    required this.dio,
  });

  @override
  Future<_CachedNetworkTileImage> obtainKey(ImageConfiguration config) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
    _CachedNetworkTileImage key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(_load(decode));
  }

  Future<ImageInfo> _load(ImageDecoderCallback decode) async {
    Uint8List bytes;
    try {
      final response = await dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      bytes = Uint8List.fromList(response.data ?? []);
      if (bytes.isEmpty) throw Exception('Empty tile response');

      // خزّن بدون انتظار حتى لا نؤخر عرض التايل
      unawaited(MapTileCacheService.saveTile(z, x, y, bytes));
    } catch (_) {
      bytes = _emptyTileBytes;
    }

    final buffer = await ImmutableBuffer.fromUint8List(bytes);
    final codec = await decode(buffer);
    final frame = await codec.getNextFrame();
    return ImageInfo(image: frame.image);
  }

  @override
  bool operator ==(Object other) =>
      other is _CachedNetworkTileImage && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
