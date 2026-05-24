import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/hive_cache_service.dart';

/// Call [CacheAwareLogout.execute] on every sign-out path.
/// Wipes all Hive caches, shared prefs, and resets in-memory state.
class CacheAwareLogout {
  CacheAwareLogout._();

  static Future<void> execute() async {
    await Future.wait([
      HiveCacheService.clearAll(),
      SharedPrefHelper.clearAllSecuredData(),
      SharedPrefHelper.clearAllData(),
    ]);
  }
}
