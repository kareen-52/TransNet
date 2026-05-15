import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import '../data/repo/driver_tracking_repo.dart';
import 'driver_tracking_state.dart';

class DriverTrackingCubit extends Cubit<DriverTrackingState> {
  final DriverTrackingRepo _repo;
  DriverTrackingCubit(this._repo) : super(const DriverTrackingState.initial());

  Future<void> confirmPickup(int shipmentId, String qrPin) async {
    emit(const DriverTrackingState.loadingQr());
    final result = await _repo.confirmPickup(shipmentId: shipmentId, qrPin: qrPin);
    
    result.when(
      success: (msg) => emit(DriverTrackingState.successQr(msg)),
      failure: (error) => emit(DriverTrackingState.errorQr(error.getAllErrorMessages())),
    );
  }

  Future<void> confirmDelivery(int shipmentId, String pin) async {
    emit(const DriverTrackingState.loadingPin());
    final result = await _repo.confirmDelivery(shipmentId: shipmentId, pin: pin);
    
    result.when(
      success: (msg) => emit(DriverTrackingState.successPin(msg)),
      failure: (error) => emit(DriverTrackingState.errorPin(error.getAllErrorMessages())),
    );
  }
}