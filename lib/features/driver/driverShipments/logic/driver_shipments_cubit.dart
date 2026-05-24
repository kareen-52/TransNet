import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/repo/driver_shipments_repo.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_state.dart';


class DriverShipmentsCubit extends Cubit<DriverShipmentsState> {
  final DriverShipmentsRepo _repo;

  int  currentPage    = 1;
  bool isFetchingMore = false;
  bool hasReachedMax  = false;
  bool _isReloading   = false;
  List<ShipmentModel> allShipments = [];

  DriverShipmentsCubit(this._repo) : super(const DriverShipmentsState.initial());

  Future<void> getShipments({bool isReload = false}) async {
    if (isReload) {
      if (_isReloading) return;
    } else {
      if (isFetchingMore || hasReachedMax) return;
    }

    if (isReload) {
      _isReloading = true;
      currentPage  = 1;
      hasReachedMax = false;
      allShipments.clear();
      if (!isClosed) emit(const DriverShipmentsState.loading());
    }

    isFetchingMore = true;

    if (kDebugMode) {
      debugPrint('🚚 DriverShipmentsCubit page=$currentPage reload=$isReload');
    }

    try {
      final ApiResult<DriverShipmentsResponse> result =
          await _repo.getShipments(currentPage);
      if (isClosed) return;

      result.when(
        success: (data) {
          final page  = data.data ?? [];
          hasReachedMax =
              (data.lastPage != null && currentPage >= data.lastPage!);
          allShipments.addAll(page);
          if (!hasReachedMax) currentPage++;

          if (!isClosed) {
            emit(DriverShipmentsState.success(
              List.from(allShipments),
              hasReachedMax,
            ));
          }
        },
        failure: (error) {
          if (isClosed) return;
          if (allShipments.isNotEmpty) {
            emit(DriverShipmentsState.success(
              List.from(allShipments),
              hasReachedMax,
            ));
          } else {
            emit(DriverShipmentsState.error(error));
          }
        },
      );
    } finally {
      isFetchingMore = false;
      _isReloading   = false;
    }
  }

  
  Future<void> invalidateAndReload() async {
    await _repo.clearCache();
    await getShipments(isReload: true);
  }
}
