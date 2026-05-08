import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import '../data/repos/vehicle_types_repo.dart';
import 'vehicle_types_state.dart';

class VehicleTypesCubit extends Cubit<VehicleTypesState> {
  final VehicleTypesRepo _repo;

  VehicleTypesCubit(this._repo) : super(const VehicleTypesState.initial());

  void fetchVehicleTypes() async {
    emit(const VehicleTypesState.loading());
    final result = await _repo.getVehicleTypes();
    
    if (isClosed) return;

    result.when(
      success: (vehicles) => emit(VehicleTypesState.success(vehicles)),
      failure: (error) => emit(VehicleTypesState.error(error)),
    );
  }
}