import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/theme_cubit.dart';
import 'package:graduation_progect/features/driver/profile/ui/screen/help_support_screen.dart';
import 'package:graduation_progect/features/shared_screens/notifications/logic/notification_cubit.dart';
import 'profile_section_container.dart';
import 'profile_nav_item.dart';

class SharedSettingsSection extends StatelessWidget {
  final bool isClient;
  const SharedSettingsSection({super.key, this.isClient = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الإعدادات العامة',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        verticalSpace(12),

        ProfileSectionContainer(
          children: [
            if (isClient) ...[
              ProfileNavItem(
                title: 'الإشعارات',
                icon: Icons.notifications_none_outlined,

                onTap: () =>

                    Navigator.pushNamed(
                      context,
                      Routes.getAllNotifications,
                    ).then((_) {
                      if (context.mounted) context.read<NotificationCubit>().fetchUnreadCount();
                    }),
              ),
              const Divider(height: 1, indent: 70, endIndent: 60),
            ],
            ProfileNavItem(
              title: 'المظهر',
              icon: Icons.dark_mode_outlined,
              onTap: () => _showThemeDialog(context),
            ),
            const Divider(height: 1, indent: 70, endIndent: 60),
            ProfileNavItem(
              title: 'المساعدة والدعم',
              icon: Icons.help_outline_rounded,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final currentTheme = themeCubit.state;

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('اختر المظهر'),
          content: Column(
            
            mainAxisSize: MainAxisSize.min,
            children: [
              _themeOption(
                dialogContext,
                themeCubit,
                currentTheme,
                'فاتح',
                ThemeMode.light,
              ),
              _themeOption(
                dialogContext,
                themeCubit,
                currentTheme,
                'داكن',
                ThemeMode.dark,
              ),
              _themeOption(
                dialogContext,
                themeCubit,
                currentTheme,
                'نظام الجهاز',
                ThemeMode.system,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themeOption(
    BuildContext context,
    ThemeCubit cubit,
    ThemeMode current,
    String title,
    ThemeMode mode,
  ) {
    return ListTile(
      title: Text(title),
      leading: Radio<ThemeMode>(
        value: mode,
        groupValue: current,
        onChanged: (value) {
          cubit.setTheme(value!);
          Navigator.pop(context);
        },
      ),
    );
  }
}
