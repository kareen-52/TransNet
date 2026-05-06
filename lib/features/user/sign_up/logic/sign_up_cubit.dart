import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/sign_up/data/models/sign_up_request_body.dart';
import 'package:graduation_progect/features/user/sign_up/data/repos/sign_up_repo.dart';
import 'package:graduation_progect/features/user/sign_up/logic/sign_up_state.dart';


class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _repo;
  SignupCubit(this._repo) : super(const SignupState.initial());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  void emitSignupStates() async {
    if (!formKey.currentState!.validate()) return;
    emit(const SignupState.signupLoading());
    final response = await _repo.signup(
      SignupRequestBody(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
      
      ),
    );
    response.when(
      success: (signupResponse) {
        emit(SignupState.signupSuccess(signupResponse));
      },
      failure: (error) {
        emit(SignupState.signupError(error));
      },
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    return super.close();
  }
}