import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/logic/shipment_details_state.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/repo/shipment_details_repo.dart';

class ShipmentDetailsCubit extends Cubit<ShipmentDetailsState> {
  final ShipmentsDetailsRepo _repo;

  ShipmentDetailsCubit(this._repo) : super(const ShipmentDetailsState.initial());

  Future<void> loadShipmentDetails(int shipmentId) async {
    if (isClosed) return;
    emit(const ShipmentDetailsState.loading());

    final result = await _repo.getShipmentDetails(shipmentId);
    if (isClosed) return;

    result.when(
      success: (data) {
        if (!isClosed) emit(ShipmentDetailsState.success(data));
      },
      failure: (error) {
        if (!isClosed) emit(ShipmentDetailsState.error(error));
      },
    );
  }
}