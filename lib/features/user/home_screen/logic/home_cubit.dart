import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CreateShipmentRepo _shipmentRepo;

  HomeCubit(this._shipmentRepo) : super(const HomeState.initial());

  void checkActiveShipment() async {
    emit(const HomeState.loading());

    final result = await _shipmentRepo.getActiveShipment();

    if (isClosed) return;

    result.when(
      success: (shipment) {
        emit(HomeState.hasActiveShipment(shipment));
      },
      failure: (error) {
        final bool isServerError = error.code == 500;
        final String errorMsg = error.getAllErrorMessages();

        if (isServerError || errorMsg.contains('لا يوجد') || errorMsg.contains('No active')) {
          emit(const HomeState.noActiveShipment());
        }
        else {
          emit(HomeState.error(error));
        }
      },
    );
  }
}
