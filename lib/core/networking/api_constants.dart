import 'package:graduation_progect/core/networking/app_config.dart';

class ApiConstants {
  ApiConstants._();



  static int? driverId;
  static String? driverName;

 
  static String get apiBaseUrl => AppConfig.apiBaseUrl;
  static String get orsApiKey => AppConfig.orsApiKey;
  static String get mapUrl => AppConfig.mapTileUrl;
  static String get userAgent => AppConfig.userAgent;


  static const String refreshToken = 'refreshToken';

  static const String saveDeviceToken = 'saveDeviceToken';
  static const String login = 'login';
  static const String signup = 'register';
  static const String logout = 'logout';
  static const String sendEmail = 'sendEmail';
  static const String emailVerification = 'emailVerification';
  static const String verifyResetCode = 'newPasswordVerification';
  static const String resetPassword = 'reSetPassword';
  static const String getGovernorates = 'governorates';
  static const String createShipment = 'shipment/create';
  static const String getAvailableDrivers = 'availableDrivers';
  static const String getDriverDetails = 'driver/{id}';
  static const String sendToDriver = 'shipment/send-to-driver';
  static const String getVehicleTypes = 'vehicleTypes';
  static const String extendShipment = 'shipment/extend';
  static const String editProfile = 'editProfile';
  static const String profile = 'profile';
  static const String attachGovernorate = 'governorate/attach';
  static const String detachGovernorate = 'governorate/detatch';
  static const String driverImage = 'driverImage';
  static const String countContinuousSuccessfulShipments =
      'countContinuousSuccessfulShipments';
  static const String changeDriverAvailability = 'changeDriverAvailability';
  static const String getAllNotifications = 'notifications';
  static const String getNewNotificationsCount = 'newNotifications/count';
  static const String driverSetLocation = 'driver/setLocation';
  static const String driverShipments = 'shipments/driver';
  static const String clientShipments = 'shipments/client';
  static const String reviews = 'reviews';
  static const String respondToRequest = 'shipment/respond';
  static const String instantOrdersForDriver = 'shipmentRequest/driver';
  static const String cancelDriverRequest = 'shipment/cancel-request-for-driver';
  static const String shipmentDetails = 'shipment/id/';
  static const String deleteShipment = 'shipment/delete';
  static const String updateShipment = 'shipment/update';
  static const String getShipment = 'shipment/active';
  static const String searchShipmentsByDate = 'shipments/searchByDate';
  static const String activeOrdersClient = 'activeShipments/client';

  static const String activeShipmentsDriver = 'activeShipments/driver';

  static const String confirmPickup = 'shipment/confirm-pickup';
  static const String confirmDelivery = 'shipment/confirm-delivery';
  static const String createReview = 'review';

  static const String clientPosts = 'posts/client';
  static const String createPost = 'post/create';
  static const String updatePostPrices = 'post/update';
  static const String deletePostClient = 'post/{id}';

  static const String postDetails = 'post/{id}';

}
