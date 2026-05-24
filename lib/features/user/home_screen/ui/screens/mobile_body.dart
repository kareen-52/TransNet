import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/user/client_posts/ui/screen/client_post_screen.dart';
import 'package:graduation_progect/features/user/client_shipments/logic/client_shipments_cubit.dart';
import 'package:graduation_progect/features/user/client_shipments/ui/screens/client_shipments_screen.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/home_content.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/mobile_appbar.dart';
import 'package:graduation_progect/features/user/navbar/navbar.dart';
import 'package:graduation_progect/features/user/profile/ui/screen/profile_client_screen.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({super.key});
  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(isTablet: false),
    ClientPostsScreen(),
    MyOrdersScreen(),
    ProfileClientScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Spacer(), const MobileAppBar()],
        ),
      ),

      body: IndexedStack(index: _currentIndex, children: _screens),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ClientShipmentsCubit>(),
    child: const ClientShipmentsScreen(),
  );
}

