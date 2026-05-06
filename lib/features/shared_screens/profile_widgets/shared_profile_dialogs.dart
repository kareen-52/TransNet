import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';

class SharedProfileDialogs {
  
  static void showEditNameDialog(BuildContext context, UserData user) {
    final firstNameController = TextEditingController(text: user.firstName ?? "");
    final lastNameController = TextEditingController(text: user.lastName ?? "");
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تعديل الاسم'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(
                  hintText: 'الاسم الأول',
                  controller: firstNameController,
                  validator: (value) => (value == null || value.trim().isEmpty) ? 'الرجاء إدخال الاسم الأول' : null,
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  hintText: 'الاسم الثاني',
                  controller: lastNameController,
                  validator: (value) => (value == null || value.trim().isEmpty) ? 'الرجاء إدخال الاسم الثاني' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
              child: const Text('حفظ'),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                context.read<ProfileCubit>().updateProfile(
                  phone: user.phoneNumber ?? '',
                  fName: firstNameController.text.trim(),
                  lName: lastNameController.text.trim(),
                );
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  static void showEditPhoneDialog(BuildContext context, UserData user) {
    final phoneController = TextEditingController(text: user.phoneNumber ?? "");
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تعديل رقم الهاتف'),
          content: Form(
            key: formKey,
            child: AppTextFormField(
              hintText: 'رقم الهاتف',
              controller: phoneController,
              fieldType: FieldType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'الرجاء إدخال رقم الموبايل';
                if (!AppRegex.isPhoneNumberValid(value)) return 'رقم الموبايل يجب أن يبدأ بـ 09 ويتكون من 10 أرقام';
                return null;
              },
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
              child: const Text('حفظ'),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                context.read<ProfileCubit>().updateProfile(
                  phone: phoneController.text.trim(),
                  fName: user.firstName,
                  lName: user.lastName,
                );
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      ),
    );
  }
}