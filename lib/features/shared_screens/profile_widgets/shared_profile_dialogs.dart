import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

typedef ProfileSaveCallback =
    void Function({required String phone, String? fName, String? lName});

class SharedProfileDialogs {
  static void showEditNameDialog(
    BuildContext context,
    UserData user, {
    required ProfileSaveCallback onSave,
  }) {
    final firstNameController = TextEditingController(
      text: user.firstName ?? "",
    );
    final lastNameController = TextEditingController(text: user.lastName ?? "");
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('تعديل الاسم'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFormField(
                      hintText: 'الاسم الأول',
                      controller: firstNameController,
                      errorMaxLines: 2,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? 'الرجاء إدخال الاسم الأول'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      hintText: 'الاسم الثاني',
                      controller: lastNameController,
                      errorMaxLines: 2,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? 'الرجاء إدخال الاسم الثاني'
                          : null,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isSaving ? 'جاري الحفظ...' : 'حفظ'),
                  onPressed: isSaving
                      ? null
                      : () {
                          if (!formKey.currentState!.validate()) return;
                          setDialogState(() => isSaving = true);
                          onSave(
                            phone: user.phoneNumber ?? '',
                            fName: firstNameController.text.trim(),
                            lName: lastNameController.text.trim(),
                          );
                          Navigator.pop(dialogContext);
                        },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static void showEditPhoneDialog(
    BuildContext context,
    UserData user, {
    required ProfileSaveCallback onSave,
  }) {
    final phoneController = TextEditingController(text: user.phoneNumber ?? "");
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('تعديل رقم الهاتف'),
              content: Form(
                key: formKey,
                child: AppTextFormField(
                  hintText: 'رقم الهاتف',
                  controller: phoneController,
                  fieldType: FieldType.number,
                  errorMaxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'الرجاء إدخال رقم الموبايل';
                    if (!AppRegex.isPhoneNumberValid(value))
                      return 'رقم الموبايل يجب أن يبدأ بـ 09 ويتكون من 10 أرقام';
                    return null;
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isSaving ? 'جاري الحفظ...' : 'حفظ'),
                  onPressed: isSaving
                      ? null
                      : () {
                          if (!formKey.currentState!.validate()) return;
                          setDialogState(() => isSaving = true);
                          onSave(
                            phone: phoneController.text.trim(),
                            fName: user.firstName,
                            lName: user.lastName,
                          );
                          Navigator.pop(dialogContext);
                        },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
