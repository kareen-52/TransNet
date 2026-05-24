import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/home/logic/driver_home_state.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/badge/driver_badge_widget.dart';

class DriverProfileHeader extends StatelessWidget {
  final UserData?  userData;
  final double?    rating;
  final BadgeData? badge;

  const DriverProfileHeader({
    super.key,
    this.userData,
    this.rating,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final theme       = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // ── Profile image — rebuilds ONLY when image loads/changes ─────────
        BlocBuilder<DriverHomeCubit, DriverHomeState>(
          buildWhen: (prev, curr) => curr.maybeWhen(
            driverImageLoaded: (_) => true,
            initial: ()        => true,
            orElse: ()         => false,
          ),
          builder: (context, _) {
            final imageBytes = context.read<DriverHomeCubit>().profileImage;
            return CircleAvatar(
              radius:          60.r,
              backgroundColor: colorScheme.surface,
              child: ClipOval(
                child: imageBytes != null
                    ? Image.memory(
                        imageBytes,
                        width:  120.r,
                        height: 120.r,
                        fit:    BoxFit.cover,
                      )
                    : Icon(
                        Icons.person,
                        size:  40.r,
                        color: colorScheme.onSurfaceVariant,
                      ),
              ),
            );
          },
        ),

        verticalSpace(16),

        Text(
          '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        verticalSpace(16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: AppColors.warning, size: 18.sp),
            horizontalSpace(4),
            Text(
              (rating ?? 0.0).toStringAsFixed(1),
              style: theme.textTheme.titleMedium?.copyWith(
                color:      AppColors.warning,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (badge?.name != null) ...[
              horizontalSpace(16),
              DriverBadgeWidget(
                badgeTitle:       badge!.name!,
                badgeDescription: badge!.text ?? '',
              ),
            ],
          ],
        ),
      ],
    );
  }
}
