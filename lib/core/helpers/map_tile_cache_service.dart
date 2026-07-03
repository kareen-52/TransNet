import 'dart:async';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';

class MapTileCacheService {
  MapTileCacheService._();

  static const String _tilesBoxName = 'map_tiles_cache_box';
  static const String _metaBoxName = 'map_tiles_meta_box';

  static late Box<Uint8List> _tilesBox;
  static late Box<String> _metaBox;

  static const int maxTiles = 3000;

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _tilesBox = await Hive.openBox<Uint8List>(_tilesBoxName);
    _metaBox = await Hive.openBox<String>(_metaBoxName);
    _initialized = true;
  }

  static String _key(int z, int x, int y) => '$z/$x/$y';

  static Future<void> saveTile(int z, int x, int y, Uint8List bytes) async {
    final key = _key(z, x, y);
    await _tilesBox.put(key, bytes);
    await _metaBox.put(key, DateTime.now().millisecondsSinceEpoch.toString());

    if (_tilesBox.length > maxTiles) {
      unawaited(_evictOldest());
    }
  }

  static Uint8List? getTile(int z, int x, int y) {
    final tile = _tilesBox.get(_key(z, x, y));
    if (tile != null) {

      unawaited(
        _metaBox.put(
          _key(z, x, y),
          DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );
    }
    return tile;
  }

  static bool hasTile(int z, int x, int y) =>
      _tilesBox.containsKey(_key(z, x, y));

  static int get cachedTilesCount => _tilesBox.length;

  static double get cacheSizeMB {
    double total = 0;
    for (final tile in _tilesBox.values) {
      total += tile.lengthInBytes;
    }
    return total / (1024 * 1024);
  }

  static Future<void> clearCache() async {
    await _tilesBox.clear();
    await _metaBox.clear();
  }


  static Future<void> _evictOldest() async {
    final entries = _metaBox.toMap().entries.toList()
      ..sort(
        (a, b) => int.parse(a.value).compareTo(int.parse(b.value)),
      );

    final toRemove = (entries.length * 0.1).ceil();
    final keysToRemove = entries.take(toRemove).map((e) => e.key).toList();

    await Future.wait([
      _tilesBox.deleteAll(keysToRemove),
      _metaBox.deleteAll(keysToRemove),
    ]);
  }
}
