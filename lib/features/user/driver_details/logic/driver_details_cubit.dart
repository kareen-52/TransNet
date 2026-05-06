import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import '../data/repo/driver_details_repo.dart';
import 'driver_details_state.dart';

class DriverDetailsCubit extends Cubit<DriverDetailsState> {
  final DriverDetailsRepo _repo;

  DriverDetailsCubit(this._repo) : super(const DriverDetailsState.loading());

  void fetchDriverDetails(int driverId) async {
    emit(const DriverDetailsState.loading());
    final result = await _repo.getDriverDetails(driverId);
    
    if (isClosed) return;

    result.when(
      success: (details) => emit(DriverDetailsState.success(details)),
      failure: (error) => emit(DriverDetailsState.error(error)),
    );
  }
}