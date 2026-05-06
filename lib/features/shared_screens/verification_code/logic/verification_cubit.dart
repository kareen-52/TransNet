import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/notifications/notification_service.dart';
import 'package:graduation_progect/features/shared_screens/change_password/data/repo/forgot_password_repo.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_request_body.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/models/verification_response.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/data/repos/verification_repo.dart';
import 'package:graduation_progect/features/shared_screens/verification_code/logic/verification_state.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepo _verificationRepo;
  final ForgotPasswordRepo _forgotPasswordRepo;

  VerificationCubit(this._verificationRepo, this._forgotPasswordRepo)
    : super(const VerificationState.initial());

  void emitVerificationStates({
    required String email,
    required String code,
    required VerificationType type,
  }) async {
    emit(const VerificationState.loading(isResending: false));
    try {
      ApiResult result;
      if (type == VerificationType.register) {
        result = await _verificationRepo.verifyEmail(
          VerificationRequestBody(email: email, verificationCode: code),
        );
      } else {
        result = await _forgotPasswordRepo.verifyResetCode(email, code);
      }

      if (!isClosed) {
        result.when(
          success: (data) async {
      if (type == VerificationType.register && data is VerificationResponse) {
              final token = data.token;
              final refreshToken = data.refreshToken;
              final role = 'client';
              final resetToken = data.resetToken;
              if (token != null && token.isNotEmpty) {
                _saveUserData(token, refreshToken ?? '', role);
              }
              if (resetToken != null && resetToken.isNotEmpty) {
                await SharedPrefHelper.setSecuredString(
                  SharedPrefKeys.userResetToken,
                  resetToken,
                );
              }
            }
            emit(VerificationState.success(data, isResending: false));
          },
          failure: (error) => emit(VerificationState.error(error)),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(VerificationState.error(ApiErrorModel(message: e.toString())));
      }
    }
  }

  Future<void> resendCode({
    required String email,
    required VerificationType type,
  }) async {
    emit(const VerificationState.loading(isResending: true));
    try {
      final result = await _forgotPasswordRepo.sendEmail(email);
      if (!isClosed) {
        result.when(
          success: (data) =>
              emit(VerificationState.success(data, isResending: true)),
          failure: (error) => emit(VerificationState.error(error)),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(VerificationState.error(ApiErrorModel(message: e.toString())));
      }
    }
  }

  Future<void> _saveUserData(
    String token,
    String refreshToken,
    String role,
  ) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    await SharedPrefHelper.setSecuredString('refreshToken', refreshToken);
    await SharedPrefHelper.setData('userRole', role);
    DioFactory.setTokenInHeaderAfterLogin(token);
    await NotificationService.handleDeviceTokenSync();
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
