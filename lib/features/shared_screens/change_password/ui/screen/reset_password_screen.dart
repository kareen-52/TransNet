import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/text_styles.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_cubit.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_state.dart';
import 'package:graduation_progect/features/shared_screens/change_password/ui/widget/reset_password_form.dart';
import 'package:graduation_progect/features/shared_screens/change_password/ui/widget/reset_password_header.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String resetToken;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.resetToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<ForgotPasswordCubit>();
        cubit.resetToken = widget.resetToken;
        cubit.emailController.text = widget.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) =>
            current is ResetPasswordSuccess || current is Error,
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تم تغيير كلمة المرور بنجاح!',
                  style: TextStyles.success(context),
                ),
                backgroundColor: Colors.green,
              ),
            );

            context.pushNamedAndRemoveUntil(
              Routes.login,
              predicate: (route) => false,
            );
          } else if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.apiErrorModel.message ?? "حدث خطأ ما",
                  style: TextStyles.error(context),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  verticalSpace(20),
                  const ResetPasswordHeader(),
                  verticalSpace(30),
                  const ResetPasswordForm(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResetPasswordArguments {
  final String email;
  final String resetToken;

  const ResetPasswordArguments({required this.email, required this.resetToken});
}
