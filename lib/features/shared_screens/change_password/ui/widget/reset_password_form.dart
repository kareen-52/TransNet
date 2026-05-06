import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/input_field_label.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_state.dart';
import 'package:graduation_progect/features/user/sign_up/ui/widgets/password_strength_indicator.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ForgotPasswordCubit>();
    final isLoading = cubit.state is Loading;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const InputFieldLabel(label: 'كلمة المرور الجديدة'),
          verticalSpace(8),
          AppTextFormField(
            controller: cubit.passwordController,
            hintText: '********',
            fieldType: FieldType.password,
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueGrey),
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال كلمة المرور';
              }
              if (!AppRegex.isPasswordValid(value)) {
                return 'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل، حرف كبير، حرف صغير، رقم، رمز خاص';
              }
              return null;
            },
          ),
          verticalSpace(16),
          ValueListenableBuilder(
            valueListenable: cubit.passwordController,
            builder: (context, TextEditingValue textEditingValue, _) {
              return PasswordStrengthIndicator(password: textEditingValue.text);
            },
          ),
          verticalSpace(24),
          const InputFieldLabel(label: 'تأكيد كلمة المرور'),
          verticalSpace(8),
          AppTextFormField(
            controller: cubit.confirmPasswordController,
            hintText: '********',
            fieldType: FieldType.password,
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueGrey),
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء تأكيد كلمة المرور';
              }
              if (value != cubit.passwordController.text) {
                return 'كلمتا المرور غير متطابقتين';
              }
              return null;
            },
          ),
          verticalSpace(40),
          AppTextButton(
            text: 'تعيين كلمة المرور',
            onPressed: isLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      cubit.emitResetPassword();
                    }
                  },
            isLoading: isLoading,
            isDisabled: isLoading,
          ),
        ],
      ),
    );
  }
}
