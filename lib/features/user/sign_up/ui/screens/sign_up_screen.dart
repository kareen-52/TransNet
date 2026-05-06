import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/text_styles.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_cubit.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_state.dart';
import 'package:graduation_progect/features/user/sign_up/ui/widgets/already_have_account_text.dart';
import 'package:graduation_progect/features/user/sign_up/ui/widgets/register_form.dart';
import 'package:graduation_progect/features/user/sign_up/ui/widgets/register_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const RegisterHeader(),
              verticalSpace(40),
              BlocProvider(
                create: (context) => getIt<SignupCubit>(),
                child: BlocListener<SignupCubit, SignupState>(
                  listenWhen: (previous, current) =>
                      current is SignupSuccess || current is SignupError,
                  listener: (context, state) {
                    state.whenOrNull(
                      signupSuccess: (response) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response.message ??
                                  'تم إنشاء الحساب بنجاح، تم إرسال رمز التحقق إلى بريدك الإلكتروني',
                              style: TextStyles.success(context),
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );

                     
                          if (context.mounted) {
                            context.pushNamed(
                              Routes.verificationCode,
                              arguments: {
                                'email': context
                                    .read<SignupCubit>()
                                    .emailController
                                    .text,
                                'type': VerificationType.register,
                              },
                            );
                          }
                        
                      },
                      signupError: (apiErrorModel) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              apiErrorModel.message ??
                                  'فشل التسجيل، يرجى المحاولة مرة أخرى',
                              style: TextStyles.error(context),
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                    );
                  },
                  child: const RegisterForm(),
                ),
              ),
              verticalSpace(24),
              const AlreadyHaveAccountText(),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}
