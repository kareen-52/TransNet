import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

class ProfileClientInfoCard extends StatelessWidget {
  final UserData user;
  final VoidCallback onEditPhone;
  final VoidCallback onEditName;

  const ProfileClientInfoCard({
    super.key,
    required this.user,
    required this.onEditPhone,
    required this.onEditName,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          _buildInfoRow(context, 'الاسم الكامل', '${user.firstName} ${user.lastName}', Icons.person_outline_rounded, actionIcon: Icons.edit_outlined, onActionTap: onEditName),
          const Divider(height: 1, indent: 70, endIndent: 60),
          _buildInfoRow(context, 'رقم الهاتف', user.phoneNumber ?? '', Icons.phone_android_outlined, actionIcon: Icons.edit_outlined, onActionTap: onEditPhone),
          const Divider(height: 1, indent: 70, endIndent: 60),
          _buildInfoRow(context, 'معرف المستخدم', user.userNumber ?? '', Icons.badge_outlined, actionIcon: Icons.copy_outlined, onActionTap: () {
            Clipboard.setData(ClipboardData(text: user.userNumber ?? ''));
            SnackBarHelper.showSuccess(context, 'تم نسخ المعرف');
          }),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon, {IconData? actionIcon, VoidCallback? onActionTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [

          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: colorScheme.primary, size: 24.sp),
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp, color: colorScheme.onSurfaceVariant)),
                Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp, fontWeight: FontWeightHelper.medium, color: colorScheme.onSurface)),
              ],
            ),
          ),
          if (actionIcon != null)
            IconButton(onPressed: onActionTap, icon: Icon(actionIcon, size: 20.sp, color: colorScheme.primary)),
        ],
      ),
    );
  }
}