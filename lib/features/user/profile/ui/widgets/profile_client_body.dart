import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/logout_dialog.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/shared_settings_section.dart';
import 'package:graduation_progect/features/user/profile/ui/widgets/personal_info_section.dart';
import 'package:graduation_progect/features/user/profile/ui/widgets/profile_client_header.dart';

class ProfileClientBody extends StatelessWidget {
  final ProfileResponse profileData;

  const ProfileClientBody({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet;
    return isTablet ? _TabletProfile(profileData: profileData) : _MobileProfile(profileData: profileData);
  }
}


class _MobileProfile extends StatelessWidget {
  final ProfileResponse profileData;
  const _MobileProfile({required this.profileData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          verticalSpace(40),
          ClientProfileHeader(userData: profileData.user),
          verticalSpace(32),
          PersonalInfoSection(user: profileData.user!),
          verticalSpace(24),
          const SharedSettingsSection(isClient: true),
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


class _TabletProfile extends StatelessWidget {
  final ProfileResponse profileData;
  const _TabletProfile({required this.profileData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
      child: Column(
        children: [
 
          TabletFormContainer(
            maxWidth: 480,
            child: Column(
              children: [
                verticalSpace(24),
                ClientProfileHeader(userData: profileData.user),
                verticalSpace(32),
              ],
            ),
          ),

          // Two-column body
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    PersonalInfoSection(user: profileData.user!),
                  ],
                ),
              ),
              horizontalSpace(24),
              Expanded(
                child: Column(
                  children: [
                    const SharedSettingsSection(isClient: true),
                    verticalSpace(24),
                    AppTextButton(
                      text: 'تسجيل الخروج',
                      onPressed: () => showLogoutConfirmDialog(context),
                      backgroundColor: colorScheme.surface,
                      textStyle:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
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
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(48),
        ],
      ),
    );
  }
}
