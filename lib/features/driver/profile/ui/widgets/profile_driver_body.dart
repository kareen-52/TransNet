import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
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
    return context.isTablet
        ? _TabletDriverProfile(profileData: profileData)
        : _MobileDriverProfile(profileData: profileData);
  }
}

class _MobileDriverProfile extends StatelessWidget {
  final ProfileResponse profileData;
  const _MobileDriverProfile({required this.profileData});

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
            statistics: profileData.statistics,
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
class _TabletDriverProfile extends StatelessWidget {
  final ProfileResponse profileData;
  const _TabletDriverProfile({required this.profileData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
  
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 950),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              TabletFormContainer(
                maxWidth: 500,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: DriverProfileHeader(
                    userData: profileData.user,
                    rating: profileData.averageRate,
                    badge: profileData.badge,
                  ),
                ),
              ),

           
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        DriverPersonalInfoSection(user: profileData.user!),
                        verticalSpace(24),
                        WorkSection(
                          car: profileData.car,
                          governorates: profileData.driverGovernorates,
                          statistics: profileData.statistics,
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(32),

                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const NotificationsSection(),
                        verticalSpace(24),
                        const SharedSettingsSection(),
                        verticalSpace(40),
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
                            size: 24.sp,
                          ),
                          borderRadius: 16.r,
                          height: 60.h, 
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(60),
            ],
          ),
        ),
      ),
    );
  }
}