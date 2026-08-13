import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/shared_profile_dialogs.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/driver_profile_info_card.dart';

class DriverPersonalInfoSection extends StatelessWidget {
  final UserData user;

  const DriverPersonalInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'المعلومات الشخصية',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        verticalSpace(12),
        
        DriverProfileInfoCard(
          user: user,
          onEditPhone: () => SharedProfileDialogs.showEditPhoneDialog(
            context,
            user,
            onSave: ({required phone, fName, lName}) => context
                .read<ProfileCubit>()
                .updateProfile(phone: phone, fName: fName, lName: lName),
          ),
        ),
      ],
    );
  }
}