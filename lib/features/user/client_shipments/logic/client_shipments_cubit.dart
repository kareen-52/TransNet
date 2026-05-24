import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/user/client_shipments/data/repo/client_shipments_repo.dart';
import 'client_shipments_state.dart';

class ClientShipmentsCubit extends Cubit<ClientShipmentsState> {
  final ClientShipmentsRepo _repo;

  int  currentPage    = 1;
  bool isFetchingMore = false;
  bool hasReachedMax  = false;
  bool _isReloading   = false;
  List<ShipmentModel> allShipments = [];

  ClientShipmentsCubit(this._repo) : super(const ClientShipmentsState.initial());

  Future<void> getShipments({bool isReload = false}) async {
    if (isReload) {
      if (_isReloading) return;
    } else {
      if (isFetchingMore || hasReachedMax) return;
    }

    if (isReload) {
      _isReloading  = true;
      currentPage   = 1;
      hasReachedMax = false;
      allShipments.clear();
      if (!isClosed) emit(const ClientShipmentsState.loading());
    }

    isFetchingMore = true;
    if (kDebugMode) debugPrint('📦 ClientShipmentsCubit page=$currentPage reload=$isReload');

    try {
      final ApiResult<DriverShipmentsResponse> result =
          await _repo.getShipments(currentPage);
      if (isClosed) return;

      result.when(
        success: (data) {
          final page = data.data ?? [];
          hasReachedMax = (data.lastPage != null && currentPage >= data.lastPage!);
          allShipments.addAll(page);
          if (!hasReachedMax) currentPage++;
          if (!isClosed) {
            emit(ClientShipmentsState.success(List.from(allShipments), hasReachedMax));
          }
        },
        failure: (error) {
          if (isClosed) return;
          if (allShipments.isNotEmpty) {
            emit(ClientShipmentsState.success(List.from(allShipments), hasReachedMax));
          } else {
            emit(ClientShipmentsState.error(error));
          }
        },
      );
    } finally {
      isFetchingMore = false;
      _isReloading   = false;
    }
  }


  Future<void> invalidateAndReload() async {
    await _repo.invalidateCache();
    await getShipments(isReload: true);
  }
}
