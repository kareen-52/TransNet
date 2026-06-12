import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/shared_screens/report_user/ui/report_dialog.dart';
import 'package:graduation_progect/features/shared_screens/report_user/logic/report_cubit.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/party_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';
import 'package:graduation_progect/features/user/active_orders/ui/widgets/driver_info_row.dart';
import 'package:graduation_progect/features/user/review_driver/logic/review_driver_cubit.dart';
import 'package:graduation_progect/features/user/review_driver/ui/review_dialog.dart';

class ShipmentPartyCard extends StatelessWidget {
  final PartyEntity party;
  final String role;
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final bool isCompleted;

  const ShipmentPartyCard({
    super.key,
    required this.party,
    required this.role,
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    
    final bool showRating = isCompleted && role == 'السائق';

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: buildCardDecoration(surface: surface, border: border, isDark: isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PartyAvatar(icon: icon, iconColor: iconColor),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        role,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: iconColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      party.fullName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      party.phoneNumber,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: secondary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: border, height: 1, thickness: 0.8),
          ),


          Row(
            children: [

              Expanded(
                flex: showRating ? 2 : 4,
                child: _ActionButton(
                  onPressed: () => callUser(context, party.phoneNumber),
                  icon: Icons.call_rounded,
                  label: showRating ? null : 'اتصال',
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.w),


              if (showRating) ...[
                Expanded(
                  flex: 5,
                  child: _ActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider(
                          create: (context) => getIt<ReviewDriverCubit>(),
                          child: ReviewDialog(driverId: party.id),
                        ),
                      );
                    },
                    icon: Icons.star_rate_rounded,
                    label: 'تقييم السائق',
                    backgroundColor: AppColors.warning.withOpacity(0.1),
                    foregroundColor: AppColors.warning,
                  ),
                ),
                SizedBox(width: 8.w),
              ],


              Expanded(
                flex: showRating ? 2 : 1,
                child: _ActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => BlocProvider(
                        create: (context) => getIt<ReportCubit>(),
                        child: ReportDialog(reportedId: party.id, role: role),
                      ),
                    );
                  },
                  icon: Icons.flag_rounded,
                  label: showRating ? null : null,
                  backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.08),
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PartyAvatar extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const _PartyAvatar({required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.06),
        shape: BoxShape.circle,
        border: Border.all(color: iconColor.withOpacity(0.15), width: 1.2),
      ),
      child: Icon(icon, color: iconColor, size: 20.sp),
    );
  }
}


class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? label;
  final Color backgroundColor;
  final Color foregroundColor;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor, size: 18.sp),
            if (label != null) ...[
              SizedBox(width: 6.w),
              Text(
                label!,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}