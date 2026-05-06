import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/home_content.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/mobile_body.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/tablet_appbar.dart';
import 'package:graduation_progect/features/user/profile/ui/screen/profile_client_screen.dart';

class TabletBody extends StatefulWidget {
  const TabletBody({super.key});

  @override
  State<TabletBody> createState() => _TabletBodyState();
}

class _TabletBodyState extends State<TabletBody> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(isTablet: true),
    MyAdsScreen(),
    MyOrdersScreen(),
    ProfileClientScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: TabletAppBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
    );
  }
}
