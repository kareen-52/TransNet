import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/hive_cache_service.dart';


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
