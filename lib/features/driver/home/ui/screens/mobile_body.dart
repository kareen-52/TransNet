import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/driverShipments/ui/screens/driver_shipments_screen.dart';
import 'package:graduation_progect/features/driver/home/logic/driver_home_state.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/home/ui/screens/tablet_body.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/driver_bottom_nav_bar.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/driver_header.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/driver_header_shimmer.dart';
import 'package:graduation_progect/features/driver/home/ui/shared/home_content.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_state.dart';
import 'package:graduation_progect/features/driver/profile/ui/screen/profile_driver_screen.dart';
import 'package:graduation_progect/features/driver/setLocation/logic/driver_location_cubit.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> with WidgetsBindingObserver {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(isTablet: false),
    AdsScreen(),
    MyOrdersScreen(),
    AcountDriverScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        final cubit = context.read<DriverHomeCubit>();
        
        if (cubit.isAvailable) {
          bool? confirm = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text("تأكيد الخروج"),
              content: const Text("إذا خرجت من التطبيق، ستصبح حالتك **غير متاح** ولن تظهر للعملاء. هل تريد المتابعة؟"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("إلغاء"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("نعم، أريد الخروج"),
                ),
              ],
            ),
          );
          
          if (confirm != true) return;
          
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
          
          await cubit.setOfflineAndClose();
          
          if (mounted) Navigator.pop(context);
          
          await SystemNavigator.pop();
        } else {
          await SystemNavigator.pop();
        }
      },
      child: BlocListener<DriverHomeCubit, DriverHomeState>(
        listenWhen: (prev, curr) => curr is AvailabilityChanged,
        listener: (context, state) {
          state.maybeWhen(
            availabilityChanged: (message, isAvailable) {
              context.read<DriverLocationCubit>().toggleLocationTracking(
                isAvailable,
              );
              print(" تحديث تتبع الموقع: ${isAvailable ? 'شغال' : 'متوقف'}");
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(68.h),
            child: SafeArea(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const DriverHeaderShimmer(),
                    success: (data) => DriverHeader(
                      driverName: data.user?.firstName ?? "سائق",
                      driverId: data.user?.id ?? 0,
                    ),
                    orElse: () => const DriverHeaderShimmer(),
                  );
                },
              ),
            ),
          ),
          body: IndexedStack(index: _currentIndex, children: _screens),
          bottomNavigationBar: DriverBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ),
      ),
    );
  }
}

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: BlocProvider(
      create: (context) => getIt<DriverShipmentsCubit>(),
      child: const DriverShipmentsScreen(),
    ),
  );
}

class AcountDriverScreen extends StatelessWidget {
  const AcountDriverScreen({super.key});
  @override
  Widget build(BuildContext context) => const ProfileDriverScreen();
}