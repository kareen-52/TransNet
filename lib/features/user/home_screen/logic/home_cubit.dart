import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CreateShipmentRepo _shipmentRepo;

  HomeCubit(this._shipmentRepo) : super(const HomeState.initial());

  // void checkActiveShipment() async {
  //   emit(const HomeState.loading());

  //   final result = await _shipmentRepo.getActiveShipment();

  //   if (isClosed) return;

  //   result.when(
  //     success: (shipment) {
  //       if (shipment.driver != null) {
  //         emit(HomeState.waitingForDriver(shipment));
  //       } else {
  //         emit(HomeState.hasActiveShipment(shipment));
  //       }
  //     },
  //     failure: (error) {
  //       final bool isServerError = error.code == 500;
  //       final String errorMsg = error.getAllErrorMessages();

  //       if (isServerError || errorMsg.contains('لا يوجد') || errorMsg.contains('No active')) {
  //         emit(const HomeState.noActiveShipment());
  //       }
  //       else {
  //         emit(HomeState.error(error));
  //       }
  //     },
  //   );
  // }
  void checkActiveShipment() async {
    emit(const HomeState.loading());
    await _fetchShipmentData();
  }

  Future<void> refreshQuietly() async {
    await _fetchShipmentData();
  }

  Future<void> _fetchShipmentData() async {
    final result = await _shipmentRepo.getActiveShipment();

    if (isClosed) return;

    result.when(
      success: (shipment) {
        if (shipment.driver != null) {
          emit(HomeState.waitingForDriver(shipment));
        } else {
          emit(HomeState.hasActiveShipment(shipment));
        }
      },
      failure: (error) {
        final bool isServerError = error.code == 500;
        final String errorMsg = error.getAllErrorMessages();

        if (isServerError ||
            errorMsg.contains('لا يوجد') ||
            errorMsg.contains('No active')) {
          emit(const HomeState.noActiveShipment());
        } else {
          emit(HomeState.error(error));
        }
      },
    );
  }

  Future<void> cancelRequestForDriver(int driverId) async {
    emit(const HomeState.cancelDriverLoading());

    await Future.delayed(Duration.zero);

    final result = await _shipmentRepo.cancelRequestForDriver(driverId);

    if (isClosed) return;

    result.when(
      success: (message) {
        emit(HomeState.cancelDriverSuccess(message));
        checkActiveShipment();
      },
      failure: (error) {
        emit(HomeState.error(error));
      },
    );
  }
}
