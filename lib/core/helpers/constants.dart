bool isLoggedInUser = false;

class SharedPrefKeys {
  static const String userToken = 'access_token';
  static const String userId = 'user_id';
  static const String userResetToken = 'userResetToken';
  static const String userRole = 'userRole';
  static const String isFirstLogin = 'isFirstLogin';
  static const String themeMode = 'theme_mode';
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';
  static const String systemTheme = 'system';
  static const String refreshToken = 'refreshToken';

  static const String driverId = 'driverId';
  static const String userFirstName = 'userFirstName';

  static const String cachedInstantOrders = 'cached_instant_orders';
}

enum VerificationType { register, driverFirstLogin, forgotPassword }
