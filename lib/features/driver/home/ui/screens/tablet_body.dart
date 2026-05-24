import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/driver/home/ui/screens/mobile_body.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/driver_tablet_appbar.dart';
import 'package:graduation_progect/features/driver/profile/ui/screen/profile_driver_screen.dart';

import '../shared/home_content.dart';

class TabletBody extends StatefulWidget {
  const TabletBody({super.key});

  @override
  State<TabletBody> createState() => _TabletBodyState();
}

class _TabletBodyState extends State<TabletBody> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(isTablet: true),
    ClientAdsScreen(),
    MyOrdersScreen(),
    ProfileDriverScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: DriverTabletAppbar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight + 16.h),
        child: IndexedStack(index: _currentIndex, children: _screens),
      ),
    );
  }
}

class ClientAdsScreen extends StatelessWidget {
  const ClientAdsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('اعلاناتي'));
}
