// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:graduation_progect/core/networking/api_service.dart';
// import 'package:graduation_progect/core/networking/dio_factory.dart';
// import 'package:graduation_progect/features/driver/driverReviews/logic/driver_reviews_cubit.dart';
// import 'package:graduation_progect/features/driver/driverReviews/model/repo/driver_reviews_repo.dart';
// import 'package:graduation_progect/features/driver/driverShipments/data/repo/driver_shipments_repo.dart';
// import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_cubit.dart';
// import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
// import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
// import 'package:graduation_progect/features/driver/profile/data/repo/profile_repo.dart';
// import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
// import 'package:graduation_progect/features/driver/setLocation/data/repo/driver_location_repo.dart';
// import 'package:graduation_progect/features/driver/setLocation/logic/driver_location_cubit.dart';
// import 'package:graduation_progect/features/shared_screens/change_password/data/repo/forgot_password_repo.dart';
// import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
// import 'package:graduation_progect/features/shared_screens/login/data/repo/login_repo.dart';
// import 'package:graduation_progect/features/shared_screens/login/logic/login_cubit.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
// import 'package:graduation_progect/features/shared_screens/verification_code/data/repos/verification_repo.dart';
// import 'package:graduation_progect/features/shared_screens/verification_code/logic/verification_cubit.dart';
// import 'package:graduation_progect/features/user/available_drivers/data/repos/available_drivers_repo.dart';
// import 'package:graduation_progect/features/user/driver_details/data/repo/driver_details_repo.dart';
// import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';
// import 'package:graduation_progect/features/user/driver_details/logic/driver_details_cubit.dart';
// import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';
// import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_cubit.dart';
// import 'package:graduation_progect/features/user/vehicle_types.dart/data/repos/vehicle_types_repo.dart';
// import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';
// import 'package:graduation_progect/features/user/vehicle_types.dart/logic/vehicle_types_cubit.dart';
// import 'package:graduation_progect/features/user/sign_up/data/repos/sign_up_repo.dart';
// import 'package:graduation_progect/features/user/sign_up/logic/sign_up_cubit.dart';
// import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';

// final getIt = GetIt.instance;

// Future<void> setupGetIt() async {
//   // Dio & ApiService
//   Dio dio = await DioFactory.getDio();
//   getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

//   // login
//   getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
//   getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

//   // signup
//   getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
//   getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

//   // Verification
//   getIt.registerLazySingleton<VerificationRepo>(
//     () => VerificationRepo(getIt()),
//   );

//   getIt.registerFactory<VerificationCubit>(
//     () => VerificationCubit(
//       getIt(), // VerificationRepo
//       getIt(), // ForgotPasswordRepo
//     ),
//   );

//   // Forgot Password
//   getIt.registerLazySingleton<ForgotPasswordRepo>(
//     () => ForgotPasswordRepo(getIt()),
//   );
//   getIt.registerFactory<ForgotPasswordCubit>(
//     () => ForgotPasswordCubit(getIt()),
//   );

//   getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

//   //create shipment
//   getIt.registerLazySingleton<CreateShipmentRepo>(
//     () => CreateShipmentRepo(getIt()),
//   );
//   getIt.registerFactory<CreateShipmentCubit>(
//     () => CreateShipmentCubit(getIt()),
//   );

//   // available drivers
//   getIt.registerLazySingleton<AvailableDriversRepo>(
//     () => AvailableDriversRepo(getIt()),
//   );
//   getIt.registerFactory<AvailableDriversCubit>(
//     () => AvailableDriversCubit(getIt(), getIt()),
//   );

//   // vehicle types
//   getIt.registerLazySingleton<VehicleTypesRepo>(
//     () => VehicleTypesRepo(getIt()),
//   );
//   getIt.registerFactory<VehicleTypesCubit>(() => VehicleTypesCubit(getIt()));

//   //driver details
//   getIt.registerLazySingleton<DriverDetailsRepo>(
//     () => DriverDetailsRepo(getIt()),
//   );
//   getIt.registerFactory<DriverDetailsCubit>(() => DriverDetailsCubit(getIt()));

//   //notification
//   getIt.registerLazySingleton<NotificationRepo>(
//     () => NotificationRepo(getIt<ApiService>()),
//   );
//   getIt.registerLazySingleton<NotificationCubit>(
//     () => NotificationCubit(getIt()),
//   );

//   // Profile
//   getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
//   getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
//   //home driver
//   getIt.registerLazySingleton<DriverHomeRepo>(() => DriverHomeRepo(getIt()));
//   // getIt.registerFactory<DriverHomeCubit>(() => DriverHomeCubit(getIt()));
//     getIt.registerLazySingleton<DriverHomeCubit>(() => DriverHomeCubit(getIt()));

//    //setLocatin driver
//   getIt.registerLazySingleton<DriverLocationRepo>(
//     () => DriverLocationRepo(getIt()),
//   );
//   getIt.registerFactory<DriverLocationCubit>(
//     () => DriverLocationCubit(getIt()),
//   );

//  //DriverShipments
//   getIt.registerLazySingleton<DriverShipmentsRepo>(
//     () => DriverShipmentsRepo(getIt()),
//   );
//   getIt.registerFactory<DriverShipmentsCubit>(
//     () => DriverShipmentsCubit(getIt()),
//   );

//    //DriverReviewsCubit
//   getIt.registerLazySingleton<DriverReviewsRepo>(
//     () => DriverReviewsRepo(getIt()),
//   );
//   getIt.registerFactory<DriverReviewsCubit>(
//     () => DriverReviewsCubit(getIt()),
//   );

// }
import 'package:get_it/get_it.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/data/repos/active_driver_shipments_repo.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/driverReviews/logic/driver_reviews_cubit.dart';
import 'package:graduation_progect/features/driver/driverReviews/data/repo/driver_reviews_repo.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/repo/driver_shipments_repo.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/repo/instant_orders_repo.dart';
import 'package:graduation_progect/features/driver/instant_orders/logic/instant_orders_cubit.dart';
import 'package:graduation_progect/features/driver/profile/data/repo/profile_repo.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/driver/setLocation/data/repo/driver_location_repo.dart';
import 'package:graduation_progect/features/driver/setLocation/logic/driver_location_cubit.dart';
import 'package:graduation_progect/features/driver/tracking/data/repo/driver_tracking_repo.dart';
import 'package:graduation_progect/features/driver/tracking/logic/driver_tracking_cubit.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/repo/forgot_password_repo.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
import 'package:graduation_progect/features/shared_screens/login/data/repo/login_repo.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/login_cubit.dart';
import 'package:graduation_progect/features/shared_screens/map/logic/data/map_service.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/repo/notification_repo.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/data/repositories/shipment_details_repository_impl.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/repositories/shipment_details_repository.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/usecases/get_shipment_details_usecase.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/cubit/shipment_details_cubit.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/data/repo/shipment_search_repo.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/logic/search_shipments_cubit.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/repos/verification_repo.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/logic/verification_cubit.dart';
import 'package:graduation_progect/features/user/active_orders/data/repos/active_orders_repo.dart';
import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';
import 'package:graduation_progect/features/user/available_drivers/data/repos/available_drivers_repo.dart';
import 'package:graduation_progect/features/user/client_posts/data/repo/client_posts_repo.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_cubit.dart';
import 'package:graduation_progect/features/user/create_post/data/repo/create_post_repo.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/driver_details/data/repo/driver_details_repo.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';
import 'package:graduation_progect/features/user/driver_details/logic/driver_details_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_cubit.dart';
import 'package:graduation_progect/features/user/review_driver/data/repo/review_driver_repo.dart';
import 'package:graduation_progect/features/user/review_driver/logic/review_driver_cubit.dart';
import 'package:graduation_progect/features/user/vehicle_types/data/repos/vehicle_types_repo.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';
import 'package:graduation_progect/features/user/vehicle_types/logic/vehicle_types_cubit.dart';
import 'package:graduation_progect/features/user/sign_up/data/repos/sign_up_repo.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_cubit.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // ── Networking ──────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(DioFactory.getDio()),
  );

  // ── Auth ────────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  getIt.registerLazySingleton<VerificationRepo>(
    () => VerificationRepo(getIt()),
  );
  getIt.registerFactory<VerificationCubit>(
    () => VerificationCubit(getIt(), getIt()),
  );

  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepo(getIt()),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt()),
  );

  // ── Shipment (create / active / cancel) ─────────────────────────────────────
  // CreateShipmentRepo now caches governorates via Hive
  getIt.registerLazySingleton<CreateShipmentRepo>(
    () => CreateShipmentRepo(getIt()),
  );
  getIt.registerFactory<CreateShipmentCubit>(
    () => CreateShipmentCubit(getIt()),
  );

  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));

  // ── Available Drivers ───────────────────────────────────────────────────────
  getIt.registerLazySingleton<AvailableDriversRepo>(
    () => AvailableDriversRepo(getIt()),
  );
  getIt.registerFactory<AvailableDriversCubit>(
    () => AvailableDriversCubit(getIt(), getIt()),
  );

  // ── Vehicle Types (cached via Hive) ─────────────────────────────────────────
  getIt.registerLazySingleton<VehicleTypesRepo>(
    () => VehicleTypesRepo(getIt()),
  );
  getIt.registerFactory<VehicleTypesCubit>(() => VehicleTypesCubit(getIt()));

  // ── Driver Details ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton<DriverDetailsRepo>(
    () => DriverDetailsRepo(getIt()),
  );
  getIt.registerFactory<DriverDetailsCubit>(() => DriverDetailsCubit(getIt()));

  // ── Notifications (cached via Hive) ─────────────────────────────────────────
  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(getIt()),
  );

  // ── Profile (cached via Hive) ───────────────────────────────────────────────
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  // ── Driver Home ─────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<DriverHomeRepo>(() => DriverHomeRepo(getIt()));
  getIt.registerLazySingleton<DriverHomeCubit>(() => DriverHomeCubit(getIt()));

  getIt.registerLazySingleton<InstantOrdersRepo>(
    () => InstantOrdersRepo(getIt()),
  );
  getIt.registerLazySingleton<InstantOrdersCubit>(
    () => InstantOrdersCubit(getIt()),
  );

  // ── Driver Location ─────────────────────────────────────────────────────────
  getIt.registerLazySingleton<DriverLocationRepo>(
    () => DriverLocationRepo(getIt()),
  );
  getIt.registerFactory<DriverLocationCubit>(
    () => DriverLocationCubit(getIt()),
  );

  // ── Shipments History (cached via Hive, paginated) ──────────────────────────
  getIt.registerLazySingleton<DriverShipmentsRepo>(
    () => DriverShipmentsRepo(getIt()),
  );
  getIt.registerFactory<DriverShipmentsCubit>(
    () => DriverShipmentsCubit(getIt()),
  );
  // ── Shipment Details (Clean Architecture) ──────────────────────
  getIt.registerLazySingleton<ShipmentDetailsRepository>(
    () => ShipmentDetailsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<GetShipmentDetailsUseCase>(
    () => GetShipmentDetailsUseCase(getIt()),
  );
  getIt.registerFactory<ShipmentDetailsCubit>(
    () => ShipmentDetailsCubit(getIt()),
  );

  // ── Driver Reviews (cached via Hive) ─────────────────────────────────────────
  getIt.registerLazySingleton<DriverReviewsRepo>(
    () => DriverReviewsRepo(getIt()),
  );
  getIt.registerFactory<DriverReviewsCubit>(() => DriverReviewsCubit(getIt()));

  getIt.registerLazySingleton<ShipmentSearchRepo>(
    () => ShipmentSearchRepo(getIt()),
  );
  getIt.registerFactory<SearchShipmentsCubit>(
    () => SearchShipmentsCubit(getIt()),
  );



  // ── Map Service ─────────────────────────────────────────────────
  getIt.registerLazySingleton<MapService>(() => MapService()); 



  // ── Active Orders (Client) ─────────────────────────────────────────────────
  getIt.registerLazySingleton<ActiveOrdersRepo>(
    () => ActiveOrdersRepo(getIt()),
  );
  getIt.registerLazySingleton<ActiveOrdersCubit>(
    () => ActiveOrdersCubit(getIt()),
  );

  getIt.registerLazySingleton<ActiveDriverShipmentsRepo>(
    () => ActiveDriverShipmentsRepo(getIt()),
  );
  getIt.registerLazySingleton<ActiveDriverShipmentsCubit>(
    () => ActiveDriverShipmentsCubit(getIt()),
  );

  getIt.registerLazySingleton(() => DriverTrackingRepo(getIt()));
  getIt.registerFactory(() => DriverTrackingCubit(getIt()));

  getIt.registerLazySingleton<ReviewDriverRepo>(() => ReviewDriverRepo(getIt()));
  getIt.registerFactory<ReviewDriverCubit>(() => ReviewDriverCubit(getIt()));

  // ── Client Posts ────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<ClientPostsRepo>(() => ClientPostsRepo(getIt()));
  // getIt.registerFactory<ClientPostsCubit>(() => ClientPostsCubit(getIt()));
  getIt.registerLazySingleton<ClientPostsCubit>(() => ClientPostsCubit(getIt()));

  getIt.registerLazySingleton<CreatePostRepo>(() => CreatePostRepo(getIt()));
  getIt.registerFactory<CreatePostCubit>(() => CreatePostCubit(getIt()));
}
