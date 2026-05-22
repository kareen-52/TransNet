import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/party_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';

/// Displays a single party's avatar, role, full name, phone number
/// and a quick-call action button.
///
/// Works for both driver and client — role, icon and accent colour
/// are injected externally so the card stays generic and reusable.
class ShipmentPartyCard extends StatelessWidget {
  final PartyEntity party;
  final String role;
  final bool isDark;
  final IconData icon;
  final Color iconColor;

  const ShipmentPartyCard({
    super.key,
    required this.party,
    required this.role,
    required this.isDark,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: buildCardDecoration(
          surface: surface, border: border, isDark: isDark),
      child: Row(
        children: [
          _PartyAvatar(icon: icon, iconColor: iconColor),
          SizedBox(width: 14.w),
          Expanded(
            child: _PartyInfo(
              party: party,
              role: role,
              secondary: secondary,
            ),
          ),
          _CallButton(iconColor: iconColor, phoneNumber: party.phoneNumber),
        ],
      ),
    );
  }
}

// ─── Avatar ───────────────────────────────────────────────────────────────────

class _PartyAvatar extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const _PartyAvatar({required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.10),
        shape: BoxShape.circle,
        border:
            Border.all(color: iconColor.withValues(alpha: 0.20), width: 1.5),
      ),
      child: Icon(icon, color: iconColor, size: 22.sp),
    );
  }
}

// ─── Info ─────────────────────────────────────────────────────────────────────

class _PartyInfo extends StatelessWidget {
  final PartyEntity party;
  final String role;
  final Color secondary;

  const _PartyInfo({
    required this.party,
    required this.role,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(role,
            style: TextStyle(
                fontSize: 10.sp,
                color: secondary,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 2.h),
        Text(
          party.fullName,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 3.h),
        Text(party.phoneNumber,
            style: TextStyle(
                fontSize: 12.sp, color: secondary, letterSpacing: 0.4)),
      ],
    );
  }
}

// ─── Call button ──────────────────────────────────────────────────────────────

class _CallButton extends StatelessWidget {
  final Color iconColor;
  final String phoneNumber;

  const _CallButton(
      {required this.iconColor, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: iconColor.withValues(alpha: 0.20)),
        ),
        child: Icon(Icons.call_outlined, color: iconColor, size: 18.sp),
      ),
    );
  }
}
