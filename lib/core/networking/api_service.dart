import 'package:dio/dio.dart';
import 'package:graduation_progect/core/networking/app_config.dart';
import 'package:graduation_progect/features/driver/driverReviews/data/model/review_response.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/instant_order_model.dart';
import 'package:graduation_progect/features/driver/profile/data/models/edit_profile_request.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/setLocation/data/models/driver_set_location_request.dart';
import 'package:graduation_progect/features/driver/setLocation/data/models/driver_set_location_response.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/models/forgot_password_request_bodies.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/models/forgot_password_responses.dart';
import 'package:graduation_progect/features/shared_screens/login/data/models/login_request.dart';
import 'package:graduation_progect/features/shared_screens/login/data/models/login_response.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/refresh_token_models.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/models/notification_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/data/models/search_shipments_request.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_request_body.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_response.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/driver_model.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/send_to_driver_request.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/create_shipment_request_body.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';
import 'package:graduation_progect/features/user/vehicle_types/data/models/vehicle_type_model.dart';
import 'package:graduation_progect/features/user/sign_up/data/models/sign_up_request_body.dart';
import 'package:graduation_progect/features/user/sign_up/data/models/sign_up_response.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: AppConfig.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.refreshToken)
  Future<RefreshTokenResponse> refreshToken(
    @Body() RefreshTokenRequest refreshTokenRequest,
  );

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signupRequestBody);

  @POST(ApiConstants.sendEmail)
  Future<ForgotPasswordResponse> sendEmailForgetPassword(
    @Body() SendEmailRequestBody body,
  );

  @POST(ApiConstants.emailVerification)
  Future<VerificationResponse> emailVerification(
    @Body() VerificationRequestBody body,
  );

  @POST(ApiConstants.verifyResetCode)
  Future<ForgotPasswordResponse> newPasswordVerification(
    @Body() VerificationRequestBody body,
  );

  @POST(ApiConstants.resetPassword)
  Future<ForgotPasswordResponse> resetPassword(
    @Body() ResetPasswordRequestBody body,
  );

  @GET(ApiConstants.getGovernorates)
  Future<List<GovernorateModel>> getGovernorates();

  @POST(ApiConstants.createShipment)
  Future<dynamic> createShipment(@Body() CreateShipmentRequestBody body);

  @GET(ApiConstants.getAvailableDrivers)
  Future<AvailableDriversResponse> getAvailableDrivers();

  @GET('shipmentRequest')
  Future<dynamic> getShipment();

  @DELETE('shipmentRequest')
  Future<dynamic> deleteShipment();

  @PUT('shipmentRequest')
  Future<dynamic> updateShipment(@Body() CreateShipmentRequestBody body);

  @GET(ApiConstants.extendShipment)
  Future<dynamic> extendShipment();

  @GET(ApiConstants.getVehicleTypes)
  Future<List<VehicleTypeModel>> getVehicleTypes();

  @POST(ApiConstants.sendToDriver)
  Future<dynamic> sendToDriver(@Body() SendToDriverRequest body);

  @GET(ApiConstants.getDriverDetails)
  Future<dynamic> getDriverDetails(@Path('id') int id);

  @POST(ApiConstants.saveDeviceToken)
  Future<dynamic> saveDeviceToken(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.getNewNotificationsCount)
  Future<dynamic> getNewNotificationsCount();

  @GET(ApiConstants.profile)
  Future<ProfileResponse> getProfileData();

  @PUT(ApiConstants.editProfile)
  Future<dynamic> editProfile(@Body() EditProfileRequest editRequest);

  @POST(ApiConstants.attachGovernorate)
  Future<dynamic> attachGovernorate(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.detachGovernorate)
  Future<dynamic> detachGovernorate(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.changeDriverAvailability)
  Future<dynamic> changeDriverAvailability();

  @GET(ApiConstants.countContinuousSuccessfulShipments)
  Future<dynamic> countContinuousSuccessfulShipments();

  @GET("${ApiConstants.driverImage}/{driver_id}")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getDriverImage(@Path('driver_id') int id);

  @POST(ApiConstants.driverSetLocation)
  Future<DriverSetLocationResponse> driverSetLocation(
    @Body() DriverSetLocationRequest driverSetLocationRequest,
  );

  @GET(ApiConstants.driverShipments)
  Future<DriverShipmentsResponse> getDriverShipments(@Query("page") int page);

  @GET(ApiConstants.clientShipments)
  Future<DriverShipmentsResponse> getClientrShipments(@Query("page") int page);

  @GET(ApiConstants.reviews)
  Future<ReviewResponse> getDriverReviews(@Query('driver_id') int driverId);

  @POST(ApiConstants.respondToRequest)
  Future<dynamic> respondToRequest(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.instantOrdersForDriver)
  Future<List<InstantOrderModel>> getRequestsForDriver();

  @GET("${ApiConstants.cancelDriverRequest}/{driver_id}")
  Future<dynamic> cancelRequestForDriver(@Path('driver_id') int driverId);

  @GET('${ApiConstants.getAllNotifications}/{latest}')
  Future<NotificationListResponse> getNotifications(@Path('latest') int latest);

  @GET('${ApiConstants.shipmentDetails}/{id}')
  Future<ShipmentDetailsResponse> getShipmentDetails(@Path('id') int id);

@POST(ApiConstants.searchShipmentsByDate)
Future<List<ShipmentModel>> searchShipmentsByDate(
  @Body() SearchShipmentsRequest request,
);

  @GET(ApiConstants.activeOrdersClient)
  Future<dynamic> getActiveOrders();

  @GET(ApiConstants.activeShipmentsDriver) Future<dynamic> getActiveShipmentsForDriver();

  @POST(ApiConstants.confirmPickup)
  Future<dynamic> confirmPickup(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.confirmDelivery)
  Future<dynamic> confirmDelivery(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.createReview)
  Future<dynamic> createReview(@Body() Map<String, dynamic> body);
  
}
