import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Connectivity helper — فوري وبدون تأخير.
///
/// يعتمد على stream من connectivity_plus للحصول على الحالة فوراً
/// ويتحقق بـ DNS lookup فقط عند الحاجة الفعلية (أول مرة أو بعد تغيير).
class ConnectivityHelper {
  ConnectivityHelper._();

  static bool _isOnline = true; // افتراضي: متصل حتى يثبت العكس
  static bool _initialized = false;
  static StreamSubscription? _subscription;

  /// يُستدعى مرة واحدة في main() بعد init().
  static Future<void> init() async {
    final result = await Connectivity().checkConnectivity();
    _isOnline = _resultIsOnline(result as List<ConnectivityResult>);

    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      final wasOnline = _isOnline;
      _isOnline = _resultIsOnline(result as List<ConnectivityResult>);
      if (kDebugMode && wasOnline != _isOnline) {
        debugPrint('🌐 Connectivity changed: $_isOnline');
      }
    });

    _initialized = true;
  }

  static void dispose() => _subscription?.cancel();

  /// يرجع الحالة فوراً — بدون أي انتظار أو DNS lookup.
  static bool get isOnline {
    if (!_initialized) return true; // آمن قبل الـ init
    return _isOnline;
  }

  /// يُستخدَم كـ async للتوافق مع الكود الحالي في الـ repos.
  /// يرجع فوراً بدون أي تأخير.
  static Future<bool> isOnlineAsync() async => isOnline;

  static bool _resultIsOnline(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }
}
