import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'badge_ui_helper.dart';
import 'badge_info_dialog.dart';

class DriverBadgeWidget extends StatelessWidget {
  final String badgeTitle;
  final String badgeDescription;

  const DriverBadgeWidget({
    super.key,
    required this.badgeTitle,
    required this.badgeDescription,
  });

  @override
  Widget build(BuildContext context) {
    final color = BadgeUiHelper.getBadgeColor(badgeTitle);
    final iconPath = BadgeUiHelper.getBadgeIconPath(badgeTitle);

    return GestureDetector(
      onTap: () {
        BadgeInfoDialog.show(
          context,
          badgeTitle,
          badgeDescription,
          color,
          iconPath,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: color, width: 1.w),
        ),
        child: Row(

          children: [
            Image.asset(iconPath, width: 20.w, fit: BoxFit.contain),
            horizontalSpace(2),
            Text(
              badgeTitle,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeightHelper.extraBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
