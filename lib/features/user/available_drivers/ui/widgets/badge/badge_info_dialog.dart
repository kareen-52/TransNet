import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';

class BadgeInfoDialog {
  static void show(
    BuildContext context,
    String title,
    String description,
    Color color,
    String iconPath,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  iconPath,
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),
              ),
              verticalSpace(24),

              Text(
                'سائق $title',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              verticalSpace(8),

              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(24),

              AppTextButton(
                onPressed: () => Navigator.pop(context),
                text: 'حسناً',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
