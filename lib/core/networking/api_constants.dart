class ApiConstants {
  static int? driverId;
  static String? driverName;

  static const String url = "http://10.220.186.190:8000/";
  // static const String url = "http://192.168.1.106:8000/";

  static const String api = "api/";
  static const String apiBaseUrl = url + api;

  static const String orsApiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImYwNTI4MWQzMTJhNDQzYzNiNzlhZmQ3NzdjNzc4OTkyIiwiaCI6Im11cm11cjY0In0=';
  static const String mapUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  static const String userAgent = 'com.example.transnet_graduation_project';

  static const String refreshToken = 'refreshToken';

  static const String saveDeviceToken = "saveDeviceToken";

  static const String login = "login";
  static const String signup = "register";
  static const String sendEmail = "sendEmail";
  static const String emailVerification = "emailVerification";
  static const String verifyResetCode = "newPasswordVerification";
  static const String resetPassword = "reSetPassword";
  static const String logout = "logout";

  static const String getGovernorates = "governorates";
  static const String createShipment = "shipment/create";
  static const String getAvailableDrivers = "availableDrivers";
  static const String getDriverDetails = "driver/{id}";
  static const String sendToDriver = "shipment/send-to-driver";
  static const String getVehicleTypes = "vehicleTypes";
  static const String extendShipment = "shipment/extend";

  static const String editProfile = "editProfile";
  static const String profile = "profile";
  static const String attachGovernorate = 'governorate/attach';
  static const String detachGovernorate = 'governorate/detatch';
  static const String driverImage = 'driverImage';
  static const String countContinuousSuccessfulShipments =
      'countContinuousSuccessfulShipments';
  static const String changeDriverAvailability = 'changeDriverAvailability';

  static const String getAllNotifications = "notifications";
  static const String getNewNotificationsCount = "newNotifications/count";
  static const String driverSetLocation = "driver/setLocation";
  static const String driverShipments = "shipments/driver";
  static const String reviews = "reviews";
  static const String respondToRequest = "shipment/respond";
}
