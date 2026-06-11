import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_state.dart';
import 'package:shimmer/shimmer.dart';

class AppbarUserSection extends StatefulWidget {
  const AppbarUserSection({super.key});

  @override
  State<AppbarUserSection> createState() => _AppbarUserSectionState();
}

class _AppbarUserSectionState extends State<AppbarUserSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: 60.r,
          height: 60.r,

          child: Image.asset('assets/icons/app_icon.png', fit: BoxFit.contain),
        ),
        horizontalSpace(8),

        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => _buildShimmerLoading(theme),

              success: (profileData) {
                final String fName = profileData.user?.firstName ?? '';
                final String clientName = (fName.isEmpty)
                    ? 'عميلنا العزيز'
                    : fName;

                return _buildUserInfo(theme, clientName);
              },

              orElse: () => _buildUserInfo(theme, 'بك'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildUserInfo(ThemeData theme, String clientName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "مرحبا $clientName",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildShimmerLoading(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface.withOpacity(0.1),
      highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          verticalSpace(6),
          Container(
            width: 100.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
