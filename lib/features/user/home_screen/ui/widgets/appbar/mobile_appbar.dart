import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/icon_button_header.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/appbar_user_section.dart';
import 'package:graduation_progect/features/user/home_screen/ui/widgets/appbar/notification_icon.dart';

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horizontalSpace(16),
        AppbarUserSection(),
        const Spacer(),
        const IconButtonHeader(icon: Icons.search),
        horizontalSpace(4),
        const NotificationIcon(),
        horizontalSpace(16),
      ],
    );
  }
}
