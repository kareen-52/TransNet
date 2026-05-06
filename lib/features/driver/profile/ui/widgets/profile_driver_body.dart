import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/driver_profile_header.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/logout_dialog.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/driver_personal_info_section.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/work_section.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/notifications_section.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/shared_settings_section.dart'; 

class ProfileDriverBody extends StatelessWidget {
  final ProfileResponse profileData;

  const ProfileDriverBody({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          verticalSpace(40),

          DriverProfileHeader(
            userData: profileData.user,
            rating: profileData.averageRate,
            badge: profileData.badge,
          ),

          verticalSpace(40),

          DriverPersonalInfoSection(user: profileData.user!),

          verticalSpace(24),

          WorkSection(
            car: profileData.car,
            governorates: profileData.driverGovernorates,
          ),

          verticalSpace(24),

          const NotificationsSection(),

          verticalSpace(24),

          const SharedSettingsSection(),

          verticalSpace(32),

          AppTextButton(
            text: 'تسجيل الخروج',
            onPressed: () => showLogoutConfirmDialog(context),
            backgroundColor: colorScheme.surface,
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Icon(
              Icons.logout_rounded,
              color: colorScheme.error,
              size: 22.sp,
            ),
            borderRadius: 16.r,
          ),

          verticalSpace(40),
          verticalSpace(60),
        ],
      ),
    );
  }
}
