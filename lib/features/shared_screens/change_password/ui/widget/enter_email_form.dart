import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/input_field_label.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_state.dart';


class EnterEmailForm extends StatefulWidget {
  const EnterEmailForm({super.key});

  @override
  State<EnterEmailForm> createState() => _EnterEmailFormState();
}

class _EnterEmailFormState extends State<EnterEmailForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ForgotPasswordCubit>();
    final isLoading = cubit.state is Loading;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const InputFieldLabel(label: 'البريد الإلكتروني'),
          verticalSpace(8),
          AppTextFormField(
            controller: cubit.emailController,
            hintText: 'example@gmail.com',
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'الرجاء إدخال البريد الإلكتروني';
              if (!AppRegex.isEmailValid(value)) return 'صيغة البريد الإلكتروني غير صحيحة';
              return null;
            },
            prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFAAB8C6)),
          ),
          verticalSpace(30),
          AppTextButton(
            text: 'إرسال كود التحقق',
            onPressed: isLoading ? null : () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                cubit.emitSendEmail();
              }
            },
            isLoading: isLoading,
            isDisabled: isLoading,
          ),
          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تذكرت كلمة المرور؟ ', style: Theme.of(context).textTheme.bodyMedium),
              GestureDetector(
                onTap: isLoading ? null : () => context.pushNamed(Routes.login),
                child: Text(
                  'العودة إلى تسجيل الدخول ',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeightHelper.bold,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}