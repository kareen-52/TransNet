import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/text_styles.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/input_field_label.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/login_cubit.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  void _showErrorDialog(
    BuildContext context,
    String message, {
    VoidCallback? onAction,
    String actionText = 'حاول مجدداً',
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('خطأ', style: Theme.of(context).textTheme.titleLarge),
        content: Text(message, style: TextStyles.error(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('رجوع', style: Theme.of(context).textTheme.labelMedium),
          ),
          if (onAction != null)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onAction();
              },
              child: Text(
                actionText,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          successClient: () => context.pushNamedAndRemoveUntil(
            Routes.clientHomeScreen,
            predicate: (route) => false,
          ),
          successDriverFirstTime: (email) => context.pushNamed(
            Routes.verificationCode,
            arguments: {
              'email': email,
              'type': VerificationType.driverFirstLogin,
            },
          ),
          successDriverOld: () => context.pushNamedAndRemoveUntil(
            Routes.driverHomeScreen,
            predicate: (route) => false,
          ),
          error: (apiErrorModel) {
            final message = apiErrorModel.getAllErrorMessages();
            final code = apiErrorModel.code;
            final type = apiErrorModel.type;

            if (code == 202 || (code == 403 && type == 'unverified')) {
              final email = context.read<LoginCubit>().emailController.text;
              _showErrorDialog(
                context,
                message,

                onAction: () {
                  context.pushNamed(
                    Routes.verificationCode,
                    arguments: {
                      'email': email,
                      'type': VerificationType.register,
                    },
                  );
                },
                actionText: 'متابعة',
              );
            } else if (code == 403 && type == 'frozen') {
              _showErrorDialog(context, message);
            } else if (code == 403 && type == 'banned') {
              _showErrorDialog(context, message);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message, style: TextStyles.error(context)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        );
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        final isLoading = state is Loading;
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              const InputFieldLabel(label: 'البريد الإلكتروني'),
              verticalSpace(10),
              AppTextFormField(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.blueGrey,
                ),
                controller: cubit.emailController,
                hintText: 'example@gmail.com',
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return 'الرجاء إدخال البريد الإلكتروني';
                  if (!AppRegex.isEmailValid(value))
                    return 'صيغة البريد الإلكتروني غير صحيحة';
                  return null;
                },
              ),
              verticalSpace(20),
              const InputFieldLabel(label: 'كلمة المرور'),
              verticalSpace(10),
              AppTextFormField(
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Colors.blueGrey,
                ),
                controller: cubit.passwordController,
                hintText: '********',
                fieldType: FieldType.password,
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'الرجاء إدخال كلمة المرور';

                  return null;
                },
              ),
              verticalSpace(20),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.pushNamed(Routes.enterEmailScreen),
                  child: Text(
                    'نسيت كلمة المرور؟',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              verticalSpace(28),
              AppTextButton(
                text: 'تسجيل الدخول',
                onPressed: isLoading ? null : () => cubit.emitLoginStates(),
                isLoading: isLoading,
                isDisabled: isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}
