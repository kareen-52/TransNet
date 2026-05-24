import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/data/models/active_driver_shipment_model.dart';
import 'package:graduation_progect/features/driver/home/ui/screens/driver_home_screen.dart';
import 'package:graduation_progect/features/driver/tracking/logic/driver_tracking_cubit.dart';
import 'package:graduation_progect/features/driver/tracking/ui/screen/driver_tracking_screen.dart';
import 'package:graduation_progect/features/driver/profile/ui/screen/profile_driver_screen.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
import 'package:graduation_progect/features/shared_screens/change_password/ui/screen/enter_email_screen.dart';
import 'package:graduation_progect/features/shared_screens/change_password/ui/screen/reset_password_screen.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/login_cubit.dart';
import 'package:graduation_progect/features/shared_screens/map/ui/screen/pick_location_screen.dart';
import 'package:graduation_progect/features/shared_screens/notifications/ui/screens/notifications_screen.dart';
import 'package:graduation_progect/features/shared_screens/onboarding/screens/onboarding_screen.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/screens/shipment_details_screen.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/logic/verification_cubit.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/ui/screen/otp_screen.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/screen/login_screen.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/screens/available_drivers_screen.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/create_post/ui/screen/create_post_screen.dart';
import 'package:graduation_progect/features/user/create_post/ui/widgets/price_adjustment.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/screens/create_shipment_stepper.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/client_home_screen.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_cubit.dart';
import 'package:graduation_progect/features/user/sign_up/ui/screens/sign_up_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.verificationCode:
        if (arguments == null || arguments is! Map<String, dynamic>) {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        }
        final args = arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<VerificationCubit>(),
            child: OtpScreen(
              email: args['email'],
              type: args['type'] as VerificationType,
            ),
          ),
        );

      case Routes.clientHomeScreen:
        return MaterialPageRoute(builder: (_) => const ClientHomeScreen());

      case Routes.driverHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const DriverHomeScreen(),
        ); //DriverHomeScreen

      case Routes.onboardingScreens:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.enterEmailScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: EnterEmailScreen(),
          ),
        );

      case Routes.resetPasswordScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: ResetPasswordScreen(
              email: args['email'],
              resetToken: args['resetToken'],
            ),
          ),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: SignUpScreen(),
          ),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.mapScreen:
        final args = arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PickLocationScreen(
            initialLocation: args['initialLocation'],
            title: args['title'],
            expectedGovernorate: args['governorateName'],
            governorateBounds: args['governorateBounds'],
          ),
        );

      case Routes.createShipment:
        return MaterialPageRoute(
          builder: (_) => const CreateShipmentStepper(),
          settings: settings,
        );

      case Routes.availableDriversScreen:
        return MaterialPageRoute(
          builder: (_) => const AvailableDriversScreen(),
          settings: settings,
        );

      case Routes.profileDriverScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileDriverScreen(),
          settings: settings,
        );

      case Routes.getAllNotifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        );

      
      case Routes.waitingDriverScreen:
        final shipment = arguments as ShipmentModel?;
        
        if (shipment == null) {
          return MaterialPageRoute(builder: (_) => const ClientHomeScreen());
        }
        // return MaterialPageRoute(
        //   builder: (_) => WaitingDriverScreen(shipment: shipment),
        //   settings: settings,
        // );


      case Routes.driverTrackingScreen:
        final shipment = arguments as ActiveDriverShipmentModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<DriverTrackingCubit>(),
            child: DriverTrackingScreen(shipment: shipment),
          ),
        );


      case Routes.shipmentDetailsScreen:
        final shipmentId = arguments as int;
        return MaterialPageRoute(
          builder: (_) => ShipmentDetailsScreen(shipmentId: shipmentId),
        );
      

      case Routes.createClientPostScreen:
        return MaterialPageRoute(
          builder: (_) => const CreatePostScreen(),
        );


      case Routes.priceAdjustmentScreen:
        final args = arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args['cubit'] as CreatePostCubit,
            child: PriceAdjustmentScreen(post: args['post']),
          ),
        );


      default:
        return null;
    }
  }
}
