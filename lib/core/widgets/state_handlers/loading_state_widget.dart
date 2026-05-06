import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/animation_constants.dart';

class LoadingStateWidget extends StatelessWidget {
  final String? animationPath;
  final double? size;
  const LoadingStateWidget({super.key, this.animationPath, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Lottie.asset(
              animationPath ?? AnimationConstants.blueLoading,
              width: size ?? 200.w,
              height: size ?? 200.h,
            ),
            verticalSpace(32),
          ],
        ),
      ),
    );
  }
}
