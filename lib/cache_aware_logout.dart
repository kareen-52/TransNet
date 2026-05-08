
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/hive_cache_service.dart';

/// Call [CacheAwareLogout.execute] wherever the user signs out.
/// It wipes both SharedPreferences credentials AND all Hive data so that
/// a subsequent login starts with a clean slate.
class CacheAwareLogout {
  CacheAwareLogout._();

  static Future<void> execute() async {
    // 1. Clear all Hive boxes
    await HiveCacheService.clearAll();

    // 2. Clear authentication tokens from secure storage
    await SharedPrefHelper.clearAllSecuredData();

    // 3. Clear regular shared preferences (role, theme prefs, etc.)
    //    Keep only non-sensitive prefs if needed; for simplicity we clear all.
    await SharedPrefHelper.clearAllData();
  }
}
