import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/text_styles.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_state.dart';
import 'package:graduation_progect/features/shared_screens/change_password/ui/widget/enter_email_form.dart';
import 'package:graduation_progect/features/shared_screens/change_password/ui/widget/enter_email_header.dart';

class EnterEmailScreen extends StatelessWidget {
  const EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet;

    return Scaffold(
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) =>
            current is SendEmailSuccess || current is Error,
        listener: (context, state) {
          state.whenOrNull(
            sendEmailSuccess: (data) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    data.message ?? 'تم ارسال رمز التحقق لبريدك الالكتروني',
                    style: TextStyles.success(context),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
              final email =
                  context.read<ForgotPasswordCubit>().emailController.text;
              context.pushNamed(
                Routes.verificationCode,
                arguments: {
                  'email': email,
                  'type': VerificationType.forgotPassword,
                },
              );
            },
            error: (apiErrorModel) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    apiErrorModel.message ?? 'فشل إرسال كود التحقق',
                    style: TextStyles.error(context),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },

    
        child: isTablet
            ? SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 40.h,
                    ),
                    child: TabletFormContainer(
                      maxWidth: 520,
                      child: Column(
                        children: [
                          verticalSpace(40),
                          const EnterEmailHeader(),
                          verticalSpace(60),
                          EnterEmailForm(),
                          verticalSpace(16),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      verticalSpace(100),
                      const EnterEmailHeader(),
                      verticalSpace(180),
                      EnterEmailForm(),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
