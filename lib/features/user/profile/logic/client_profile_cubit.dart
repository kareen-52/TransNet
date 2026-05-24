import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/profile/repo/client_profile_repo.dart';

import 'client_profile_state.dart';

/// Client-specific profile cubit.
/// Completely separate from ProfileCubit (which is driver-only).
class ClientProfileCubit extends Cubit<ClientProfileState> {
  final ClientProfileRepo _repo;
  ClientProfileCubit(this._repo) : super(const ClientProfileState.initial());

  Future<void> getProfileData() async {
    if (isClosed) return;
    emit(const ClientProfileState.loading());

    final response = await _repo.getProfile();
    if (isClosed) return;

    response.when(
      success: (data) async {
        final name = data.user?.firstName;
        if (name != null && name.isNotEmpty) {
          await SharedPrefHelper.setData(SharedPrefKeys.userFirstName, name);
        }
        if (!isClosed) emit(ClientProfileState.success(data));
      },
      failure: (error) {
        if (!isClosed) emit(ClientProfileState.error(error));
      },
    );
  }

  Future<void> updateProfile({
    required String phone,
    String? fName,
    String? lName,
  }) async {
    if (isClosed) return;
    emit(const ClientProfileState.loading());

    final response = await _repo.updateProfile(phone: phone, fName: fName, lName: lName);
    if (isClosed) return;

    response.when(
      success: (message) {
        if (!isClosed) emit(ClientProfileState.editSuccess(message));
      },
      failure: (error) {
        if (!isClosed) emit(ClientProfileState.error(error));
      },
    );
  }
}
