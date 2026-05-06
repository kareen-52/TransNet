import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/notification_icon.dart';

class DriverTabletAppbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const DriverTabletAppbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomShadowCard(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildNavItem(context, 'الرئيسية', Icons.home_rounded, 0),
              horizontalSpace(16),
              _buildNavItem(context, 'الإعلانات', Icons.campaign_rounded, 1),
              horizontalSpace(16),
              _buildNavItem(context, 'السجلات', Icons.history_rounded, 2),
              horizontalSpace(16),
              _buildNavItem(context, 'الحساب', Icons.person_rounded, 3),
              // horizontalSpace(64),
            ],
          ),
          const NotificationIcon(),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    IconData icon,
    int index,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final isActive = currentIndex == index;

    final Color activeColor = theme.colorScheme.primary;
    final Color inactiveColor = theme.colorScheme.onSurface.withOpacity(0.7);

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? activeColor : inactiveColor,
              size: 26.sp,
            ),
            horizontalSpace(8),
            Text(
              title,
              style: textTheme.titleSmall?.copyWith(
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
