import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/input_field_label.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_cubit.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_state.dart';
import 'package:graduation_progect/features/user/sign_up/ui/widgets/password_strength_indicator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignupCubit>();
    final isLoading = cubit.state is SignupLoading;

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const InputFieldLabel(label: 'الاسم الأول'),
                    verticalSpace(8),
                    AppTextFormField(
                      controller: cubit.firstNameController,
                      hintText: 'الاسم',
                      enabled: !isLoading,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFFAAB8C6),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'الرجاء إدخال الاسم الأول';
                        }
                        if (!AppRegex.isNameValid(value)) {
                          return 'يجب أن يحتوي الاسم على أحرف فقط';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const InputFieldLabel(label: 'اسم العائلة'),
                    verticalSpace(8),
                    AppTextFormField(
                      controller: cubit.lastNameController,
                      hintText: 'العائلة',
                      enabled: !isLoading,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFFAAB8C6),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'الرجاء إدخال اسم العائلة';
                        }
                        if (!AppRegex.isNameValid(value)) {
                          return 'يجب أن يحتوي اسم العائلة على أحرف فقط';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(16),
          const InputFieldLabel(label: 'البريد الإلكتروني'),
          verticalSpace(10),
          AppTextFormField(
            controller: cubit.emailController,
            hintText: 'example@gmail.com',
            enabled: !isLoading,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Colors.blueGrey,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال البريد الإلكتروني';
              }
              if (!AppRegex.isEmailValid(value)) {
                return 'صيغة البريد الإلكتروني غير صحيحة';
              }
              return null;
            },
          ),
          verticalSpace(16),
          const InputFieldLabel(label: 'رقم الموبايل'),
          verticalSpace(8),
          AppTextFormField(
            controller: cubit.phoneNumberController,
            hintText: '09XXXXXXXX',
            enabled: !isLoading,
            prefixIcon: const Icon(
              Icons.phone_android_outlined,
              color: Color(0xFFAAB8C6),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال رقم الموبايل';
              }
              if (!AppRegex.isPhoneNumberValid(value)) {
                return 'رقم الموبايل يجب أن يبدأ بـ 09 ويتكون من 10 أرقام';
              }
              return null;
            },
          ),
          verticalSpace(16),
          const InputFieldLabel(label: 'كلمة المرور'),
          verticalSpace(10),
          AppTextFormField(
            controller: cubit.passwordController,
            hintText: '********',
            fieldType: FieldType.password,
            enabled: !isLoading,
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueGrey),
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

          ValueListenableBuilder<TextEditingValue>(
            valueListenable: cubit.passwordController,
            builder: (context, textEditingValue, _) {
              return PasswordStrengthIndicator(password: textEditingValue.text);
            },
          ),
          verticalSpace(16),
          const InputFieldLabel(label: 'تأكيد كلمة المرور'),
          verticalSpace(8),
          AppTextFormField(
            controller: cubit.passwordConfirmController,
            hintText: '********',
            fieldType: FieldType.password,
            enabled: !isLoading,
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueGrey),
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
          verticalSpace(16),
          TermsAndConditionsCheckbox(
            value: isTermsAccepted,
            onChanged: (value) {
              setState(() {
                isTermsAccepted = value;
              });
            },
          ),
          verticalSpace(24),
          AppTextButton(
            text: 'إنشاء حساب',
            onPressed: (!isLoading && isTermsAccepted)
                ? () => _validateAndSignup(context)
                : null,
            isLoading: isLoading,
            isDisabled: isLoading,
          ),
        ],
      ),
    );
  }

  void _validateAndSignup(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    if (cubit.formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      cubit.emitSignupStates();
    }
  }
}

class TermsAndConditionsCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const TermsAndConditionsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TermsAndConditionsCheckbox> createState() => _TermsAndConditionsCheckboxState();
}

class _TermsAndConditionsCheckboxState
    extends State<TermsAndConditionsCheckbox> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()
      ..onTap = () => Navigator.pushNamed(
            context,
            Routes.termsAndConditionsScreen,
          );
    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () => Navigator.pushNamed(
            context,
            Routes.privacyPolicyScreen,
          );
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: Checkbox(
              value: widget.value,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context).colorScheme.primary;
                }
                return AppColors.moreLightGray;
              }),
              checkColor: AppColors.moreLightGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(color: AppColors.lightGray, width: 1.5.w),
              onChanged: (newValue) {
                if (newValue != null) {
                  widget.onChanged(newValue);
                }
              },
            ),
          ),
          horizontalSpace(4),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF6B7280),
                  fontFamily: 'Cairo',
                ),
                children: [
                  TextSpan(
                    text: 'أوافق على ',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                  ),
                  TextSpan(
                    text: 'الشروط والأحكام ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: _termsRecognizer,
                  ),
                  TextSpan(
                    text: 'و ',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                  ),
                  TextSpan(
                    text: 'سياسة الخصوصية',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: _privacyRecognizer,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
