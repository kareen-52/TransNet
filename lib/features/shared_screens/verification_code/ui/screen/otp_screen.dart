import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/text_styles.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/logic/verification_cubit.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/logic/verification_state.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/ui/widget/otp_header.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/ui/widget/otp_pin_input.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/ui/widget/otp_timer.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final VerificationType type;

  const OtpScreen({super.key, required this.email, required this.type});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pinController = TextEditingController();

  void _verify(BuildContext context) {
    final code = pinController.text;
    if (code.length == 6) {
      FocusScope.of(context).unfocus();
      context.read<VerificationCubit>().emitVerificationStates(
        email: widget.email,
        code: code,
        type: widget.type,
      );
    }
  }

  void _resendCode(BuildContext context) {
    final state = context.read<VerificationCubit>().state;
    final isResending = state is VerificationLoading && state.isResending;
    if (!isResending) {
      context.read<VerificationCubit>().resendCode(
        email: widget.email,
        type: widget.type,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: (isResending) {},
            success: (data, isResending) {
              if (isResending) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "تم إرسال الرمز مرة أخرى",
                      style: TextStyles.success(context),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                final successMsg = data.message ?? "تم التحقق بنجاح";
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      successMsg,
                      style: TextStyles.success(context),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                if (widget.type == VerificationType.register) {
                  context.pushNamedAndRemoveUntil(
                    Routes.clientHomeScreen,
                    predicate: (route) => false,
                  );
                } else {
                  context.pushNamed(
                    Routes.resetPasswordScreen,
                    arguments: {
                      'email': widget.email,
                      'resetToken': data.resetToken,
                    },
                  );
                }
              }
            },
            error: (apiErrorModel) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    apiErrorModel.message ?? "حدث خطأ ما",
                    style: TextStyles.error(context),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () =>
                _buildContent(context, isLoading: false, isResending: false),
            loading: (isResending) => _buildContent(
              context,
              isLoading: true,
              isResending: isResending,
            ),
            success: (data, isResending) =>
                _buildContent(context, isLoading: false, isResending: false),
            error: (error) =>
                _buildContent(context, isLoading: false, isResending: false),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required bool isLoading,
    required bool isResending,
  }) {
    final isVerifyLoading = isLoading && !isResending;
    final bool isTablet = context.isTablet;

  
    if (!isTablet) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              verticalSpace(20),
              OtpHeader(email: widget.email),
              verticalSpace(40),
              OtpPinInput(controller: pinController, enabled: !isLoading),
              verticalSpace(20),
              OtpTimer(
                onResend: () => _resendCode(context),
                isResending: isResending,
              ),
              const Spacer(),
              AppTextButton(
                text: 'تحقق والمتابعة',
                onPressed: isVerifyLoading ? null : () => _verify(context),
                isLoading: isVerifyLoading,
                isDisabled: isVerifyLoading,
              ),
              verticalSpace(40),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
          child: TabletFormContainer(
            maxWidth: 500,
            child: Column(
              children: [
                verticalSpace(24),
                OtpHeader(email: widget.email),
                verticalSpace(48),
                OtpPinInput(controller: pinController, enabled: !isLoading),
                verticalSpace(24),
                OtpTimer(
                  onResend: () => _resendCode(context),
                  isResending: isResending,
                ),
                verticalSpace(48),
                AppTextButton(
                  text: 'تحقق والمتابعة',
                  onPressed: isVerifyLoading ? null : () => _verify(context),
                  isLoading: isVerifyLoading,
                  isDisabled: isVerifyLoading,
                ),
                verticalSpace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
