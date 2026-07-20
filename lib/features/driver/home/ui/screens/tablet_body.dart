import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/driver/apply_to_post/ui/apply_post_bottom_sheet.dart';
import 'package:graduation_progect/features/driver/driver_applied_posts/ui/screen/applied_posts_screen.dart';
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
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeContent(isTablet: true),
      AppliedPostsScreen(),
      MyOrdersScreen(),
      ProfileDriverScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverNavCubit, int>(
      bloc: getIt<DriverNavCubit>(),
      builder: (context, currentIndex) {
        return Scaffold(
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: DriverTabletAppbar(
              currentIndex: currentIndex,
              onTap: (index) => getIt<DriverNavCubit>().changeTab(index),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: kToolbarHeight + 16.h),
            child: IndexedStack(index: currentIndex, children: _screens),
          ),
        );
      },
    );
  }
}