import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import '../data/models/active_driver_shipment_model.dart';
import '../data/repos/active_driver_shipments_repo.dart';
import 'active_driver_shipments_state.dart';


class ActiveDriverShipmentsCubit extends Cubit<ActiveDriverShipmentsState> {
  final ActiveDriverShipmentsRepo _repo;

  List<ActiveDriverShipmentModel> _currentShipments = [];

  ActiveDriverShipmentsCubit(this._repo)
      : super(const ActiveDriverShipmentsState.initial());

  Future<void> fetch() async {
    emit(const ActiveDriverShipmentsState.loading());
    await _fetchAndEmit();
  }

  Future<void> silentRefresh() async {
    await _fetchAndEmit();
  }

  // ── حذف شحنة فورياً محلياً (بعد confirm_delivery) ────────────────────────
  void removeShipment(int shipmentId) {
    _currentShipments.removeWhere((s) => s.id == shipmentId);
    _emitCurrentState();
  }


  Future<void> _fetchAndEmit() async {
    if (isClosed) return;

    final result = await _repo.getActiveShipments();

    if (isClosed) return;

    result.when(
      success: (shipments) {
        _currentShipments = List.from(shipments);
        _emitCurrentState();
      },
      failure: (error) {
        if (_currentShipments.isNotEmpty) {
          _emitCurrentState();
        } else {
          emit(ActiveDriverShipmentsState.error(error));
        }
      },
    );
  }

  void _emitCurrentState() {
    if (!isClosed) {
      if (_currentShipments.isEmpty) {
        emit(const ActiveDriverShipmentsState.empty());
      } else {
        emit(ActiveDriverShipmentsState.loaded(List.from(_currentShipments)));
      }
    }
  }
}
