import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/profile/data/repo/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(const ProfileState.initial());

  Future<void> getProfileData() async {
    if (isClosed) return;
    emit(const ProfileState.loading());

    final response = await _profileRepo.getProfile();
    if (isClosed) return;

    response.when(
      success: (data) async {
        final id   = data.user?.driverId;
        final name = data.user?.firstName;
        if (id != null) {
          ApiConstants.driverId   = id;
          ApiConstants.driverName = name;
          if (!isClosed) {
            await SharedPrefHelper.setData(SharedPrefKeys.userFirstName, name ?? '');
          }
        }
        if (!isClosed) emit(ProfileState.success(data));
      },
      failure: (error) {
        if (!isClosed) emit(ProfileState.error(error));
      },
    );
  }

  Future<void> updateProfile({
    required String phone,
    String? fName,
    String? lName,
  }) async {
    if (isClosed) return;
    emit(const ProfileState.loading());

    final response = await _profileRepo.updateProfile(
      phone: phone,
      fName: fName,
      lName: lName,
    );
    if (isClosed) return;

    response.when(
      success: (message) {
        if (!isClosed) emit(ProfileState.editSuccess(message));
      },
      failure: (error) {
        if (!isClosed) emit(ProfileState.error(error));
      },
    );
  }

  Future<bool> addGovernorate(int govId) async {
    if (isClosed) return false;
    emit(const ProfileState.loading());

    final response = await _profileRepo.attachGovernorate(govId);
    if (isClosed) return false;

    return response.when(
      success: (_) async {
        // Guard: check isClosed before the inner refresh
        if (!isClosed) await getProfileData();
        return true;
      },
      failure: (error) {
        if (!isClosed) emit(ProfileState.error(error));
        return false;
      },
    );
  }

  Future<bool> removeGovernorate(int govId) async {
    if (isClosed) return false;
    emit(const ProfileState.loading());

    final response = await _profileRepo.detachGovernorate(govId);
    if (isClosed) return false;

    return response.when(
      success: (_) async {
        if (!isClosed) await getProfileData();
        return true;
      },
      failure: (error) {
        if (!isClosed) emit(ProfileState.error(error));
        return false;
      },
    );
  }
}
