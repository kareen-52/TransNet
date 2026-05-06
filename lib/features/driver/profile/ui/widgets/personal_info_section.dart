import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/driver_profile_info_card.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/shared_profile_dialogs.dart';

class PersonalInfoSection extends StatelessWidget {
  final UserData user;

  const PersonalInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'المعلومات الشخصية',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        verticalSpace(12),

        DriverProfileInfoCard(
          user: user,
          onEditPhone: () => SharedProfileDialogs.showEditPhoneDialog(context, user),
        ),
      ],
    );
  }
}

// void showEditPhoneDialog(BuildContext context, UserData user) {
//   final phoneController = TextEditingController(text: user.phoneNumber ?? "");

//   final formKey = GlobalKey<FormState>();

//   showDialog(
//     context: context,
//     builder: (dialogContext) => Directionality(
//       textDirection: TextDirection.rtl,
//       child: AlertDialog(
//         title: const Text('تعديل رقم الهاتف'),
//         content: Form(
//           key: formKey,
//           child: AppTextFormField(
//             hintText: 'رقم الهاتف',
//             controller: phoneController,
//             fieldType: FieldType.number,
//             validator: (value) {
//               if (value == null || value.trim().isEmpty) {
//                 return 'الرجاء إدخال رقم الموبايل';
//               }
//               if (!AppRegex.isPhoneNumberValid(value)) {
//                 return 'رقم الموبايل يجب أن يبدأ بـ 09 ويتكون من 10 أرقام';
//               }
//               return null;
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext),
//             child: const Text('إلغاء'),
//           ),

//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Theme.of(context).primaryColor,
//               foregroundColor: Colors.white,
//             ),
//             onPressed: () {
//               if (!formKey.currentState!.validate()) return;

//               final newPhone = phoneController.text.trim();

//               context.read<ProfileCubit>().updateProfile(
//                 phone: newPhone,
//                 fName: user.firstName,
//                 lName: user.lastName,
//               );

//               Navigator.pop(dialogContext);
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
