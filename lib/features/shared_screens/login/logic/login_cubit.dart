import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/dio_factory.dart';
import 'package:graduation_progect/core/notifications/notification_service.dart';
import 'package:graduation_progect/features/shared_screens/login/data/models/login_request.dart';
import 'package:graduation_progect/features/shared_screens/login/data/repo/login_repo.dart';
import 'package:graduation_progect/features/shared_screens/login/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> emitLoginStates() async {
    if (!formKey.currentState!.validate()) return;
    emit(const LoginState.loading());

    final response = await _loginRepo.login(
      LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    response.when(
      success: (loginResponse) async {
        final token = loginResponse.token;
        final role = loginResponse.role;
        final firstLogin = loginResponse.firstLoginForDriver;
        ApiConstants.driverId = loginResponse.driverId;
        final message = loginResponse.message;

        if (token == null &&
            message != null &&
            (message.contains('تأكيد') ||
                message.contains('بريدك الإلكتروني') ||
                message.contains('تحقق') ||
                message.contains('تفعيل'))) {
          emit(
            LoginState.error(
              ApiErrorModel(message: message, code: 202, type: 'unverified'),
            ),
          );
          return;
        }

        if (token == null || role == null) {
          emit(
            LoginState.error(
              ApiErrorModel(message: 'استجابة الخادم غير مكتملة', code: 500),
            ),
          );
          return;
        }

        if (role == 'driver' && firstLogin == true) {
          await _saveUserData(token, loginResponse.refreshToken ?? '', role, true);
          emit(LoginState.successDriverFirstTime(emailController.text));
        } else {
          await _saveUserData(token, loginResponse.refreshToken ?? '', role, false);
          
          if (role == 'client') {
            emit(const LoginState.successClient());
          } else if (role == 'driver') {
          await SharedPrefHelper.setData(SharedPrefKeys.driverId, ApiConstants.driverId);
            emit(const LoginState.successDriverOld());
          } else {
            emit(const LoginState.successClient());
          }
        }
      },
      failure: (apiErrorModel) {
        emit(LoginState.error(apiErrorModel));
      },
    );
  }

Future<void> _saveUserData(String token, String refreshToken, String role, bool isFirstLogin) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    await SharedPrefHelper.setSecuredString('refreshToken', refreshToken); 
    await SharedPrefHelper.setData('userRole', role);
    await SharedPrefHelper.setData(SharedPrefKeys.isFirstLogin, isFirstLogin);
  
    DioFactory.setTokenInHeaderAfterLogin(token);
    await NotificationService.handleDeviceTokenSync();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
