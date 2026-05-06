import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/models/forgot_password_request_bodies.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/repo/forgot_password_repo.dart';
import 'package:graduation_progect/features/shared_screens/change_password/logic/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _repo;
  ForgotPasswordCubit(this._repo) : super(const ForgotPasswordState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? resetToken;

  void emitSendEmail() async {
    emit(const ForgotPasswordState.loading());
    try {
      final response = await _repo.sendEmail(emailController.text);
      if (!isClosed) {
        response.when(
          success: (data) {
            resetToken = null;
            emit(ForgotPasswordState.sendEmailSuccess(data));
          },
          failure: (error) {
            emit(ForgotPasswordState.error(error));
          },
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(ForgotPasswordState.error(
          ApiErrorModel(message: e.toString()),
        ));
      }
    }
  }

  void emitVerifyCode(String code) async {
    emit(const ForgotPasswordState.loading());
    try {
      final response = await _repo.verifyResetCode(emailController.text, code);
      if (!isClosed) {
        response.when(
          success: (data) {
            resetToken = data.resetToken;
            emit(ForgotPasswordState.verifyCodeSuccess(data));
          },
          failure: (error) => emit(ForgotPasswordState.error(error)),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(ForgotPasswordState.error(
          ApiErrorModel(message: e.toString()),
        ));
      }
    }
  }

  void emitResetPassword() async {
    emit(const ForgotPasswordState.loading());
    try {
      final response = await _repo.resetPassword(
        ResetPasswordRequestBody(
          email: emailController.text,
          resetToken: resetToken ?? '',
          newPassword: passwordController.text,
        ),
      );
      if (!isClosed) {
        response.when(
          success: (data) => emit(ForgotPasswordState.resetPasswordSuccess(data)),
          failure: (error) => emit(ForgotPasswordState.error(error)),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(ForgotPasswordState.error(
          ApiErrorModel(message: e.toString()),
        ));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}