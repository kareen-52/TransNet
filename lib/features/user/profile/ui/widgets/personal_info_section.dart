import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/shared_profile_dialogs.dart'; // المشترك
import 'profile_client_info_card.dart';

class PersonalInfoSection extends StatelessWidget {
  final UserData user;
  const PersonalInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('المعلومات الشخصية', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        ),
        verticalSpace(12),
        ProfileClientInfoCard(
          user: user,
          onEditPhone: () => SharedProfileDialogs.showEditPhoneDialog(context, user),
          onEditName: () => SharedProfileDialogs.showEditNameDialog(context, user),
        ),
      ],
    );
  }
}