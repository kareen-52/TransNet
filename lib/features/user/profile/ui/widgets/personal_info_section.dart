import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/shared_profile_dialogs.dart';
import 'package:graduation_progect/features/user/profile/logic/client_profile_cubit.dart';
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
          onEditPhone: () => SharedProfileDialogs.showEditPhoneDialog(
            context,
            user,
            onSave: ({required phone, fName, lName}) => context
                .read<ClientProfileCubit>()
                .updateProfile(phone: phone, fName: fName, lName: lName),
          ),
          onEditName: () => SharedProfileDialogs.showEditNameDialog(
            context,
            user,
            onSave: ({required phone, fName, lName}) => context
                .read<ClientProfileCubit>()
                .updateProfile(phone: phone, fName: fName, lName: lName),
          ),
        ),
      ],
    );
  }
}