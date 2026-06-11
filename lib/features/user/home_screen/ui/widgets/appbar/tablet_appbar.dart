import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/notification_icon.dart';

class TabletAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TabletAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShadowCard(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => onTap(0),
                child: _NavTextItem(
                  title: 'الرئيسية',
                  icon: Icons.home,
                  isActive: currentIndex == 0,
                ),
              ),
              horizontalSpace(16),

              GestureDetector(
                onTap: () => onTap(1),
                child: _NavTextItem(
                  title: 'الإعلانات',
                  icon: Icons.campaign_rounded,
                  isActive: currentIndex == 1,
                ),
              ),
              horizontalSpace(16),

              GestureDetector(
                onTap: () => onTap(2),
                child: _NavTextItem(
                  title: 'السجلات',
                  icon: Icons.receipt_long,
                  isActive: currentIndex == 2,
                ),
              ),
              horizontalSpace(16),

              GestureDetector(
                onTap: () => onTap(3),
                child: _NavTextItem(
                  title: 'الحساب',
                  icon: Icons.person,
                  isActive: currentIndex == 3,
                ),
              ),

            ],
          ),
          const NotificationIcon(),
        ],
      ),
    );
  }
}

class _NavTextItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;

  const _NavTextItem({
    required this.title,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isActive
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withOpacity(0.7);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 26.sp),
          horizontalSpace(8),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
