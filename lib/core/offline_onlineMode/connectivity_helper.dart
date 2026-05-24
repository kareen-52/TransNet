import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityHelper {
  ConnectivityHelper._();

  static bool _isOnline = true;
  static bool _initialized = false;
  static StreamSubscription<List<ConnectivityResult>>? _subscription;


  static final StreamController<bool> _controller = StreamController<bool>.broadcast();
  static Stream<bool> get onConnectivityChange => _controller.stream;

  static Future<void> init() async {
    final result = await Connectivity().checkConnectivity();
    _isOnline = _resultIsOnline(result);
    _controller.add(_isOnline);

    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      final wasOnline = _isOnline;
      _isOnline = _resultIsOnline(result);
      if (wasOnline != _isOnline) {
        _controller.add(_isOnline);
        if (kDebugMode) {
          debugPrint(' Connectivity changed: $_isOnline');
        }
      }
    });

    _initialized = true;
  }

  static void dispose() {
    _subscription?.cancel();
    _controller.close();
  }

  static bool get isOnline {
    if (!_initialized) return true;
    return _isOnline;
  }

  static Future<bool> isOnlineAsync() async => isOnline;

  static bool _resultIsOnline(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }
}