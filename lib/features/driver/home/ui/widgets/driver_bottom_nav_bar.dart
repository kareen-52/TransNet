import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

class DriverBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const DriverBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.darkShadow : AppColors.lightShadow,
            blurRadius: 6.r,
            spreadRadius: 2.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: CurvedNavigationBar(
        index: currentIndex,
        color: colorScheme.surfaceContainerHighest,
        buttonBackgroundColor: colorScheme.primary,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOutQuart,
        animationDuration: const Duration(milliseconds: 200),

        items: [
          _buildNavItem(context, Icons.home_rounded, 'الرئيسية', 0),
          _buildNavItem(context, Icons.campaign_rounded, 'الإعلانات', 1),
          _buildNavItem(context, Icons.receipt_long_rounded, 'السجلات', 2),
          _buildNavItem(context, Icons.person_rounded, 'الحساب', 3),
        ],
        onTap: onTap,
      ),
    );
  }

  CurvedNavigationBarItem _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final theme = Theme.of(context);
    final isActive = currentIndex == index;

    return CurvedNavigationBarItem(
      child: Icon(
        icon,
        size: 22.sp,
        color: isActive
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurface.withOpacity(0.6),
      ),
      label: label,
      labelStyle: theme.textTheme.labelSmall?.copyWith(
        fontWeight: isActive ? FontWeight.w900 : FontWeight.normal,
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withOpacity(0.6),
      ),
    );
  }
}
