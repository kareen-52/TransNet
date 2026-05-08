import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/repo/driver_shipments_repo.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_state.dart';

class DriverShipmentsCubit extends Cubit<DriverShipmentsState> {
  final DriverShipmentsRepo _repo;

  int currentPage = 1;
  bool isFetchingMore = false;
  bool hasReachedMax = false;
  bool _isReloading = false;
  List<ShipmentModel> allShipments = [];

  DriverShipmentsCubit(this._repo)
    : super(const DriverShipmentsState.initial());

  Future<void> getShipments({bool isReload = false}) async {
    // ── Guards ────────────────────────────────────────────────────────────────
    if (isReload) {
      if (_isReloading) return;
    } else {
      if (isFetchingMore || hasReachedMax) return;
    }

    // قراءة الـ role من SharedPrefs — لا استيراد من main.dart
    final role = SharedPrefHelper.getString(SharedPrefKeys.userRole);

    if (isReload) {
      _isReloading = true;
      currentPage = 1;
      hasReachedMax = false;
      allShipments.clear();
      emit(const DriverShipmentsState.loading());
    }

    isFetchingMore = true;

    if (kDebugMode) {
      debugPrint(
        '🚚 getShipments page=$currentPage isReload=$isReload role=$role',
      );
    }

    try {
      final ApiResult<DriverShipmentsResponse> response;
      if (role == 'driver') {
        response = await _repo.getShipments(currentPage);
      } else {
        response = await _repo.getClientrShipments(currentPage);
      }

      if (isClosed) return;

      response.when(
        success: (data) {
          final shipments = data.data ?? [];
          final lastPage = data.lastPage;

          hasReachedMax = (lastPage != null && currentPage >= lastPage);
          allShipments.addAll(shipments);
          if (!hasReachedMax) currentPage++;

          emit(
            DriverShipmentsState.success(
              List.from(allShipments),
              hasReachedMax,
            ),
          );
        },
        failure: (error) {
          if (allShipments.isNotEmpty) {
            emit(
              DriverShipmentsState.success(
                List.from(allShipments),
                hasReachedMax,
              ),
            );
          } else {
            emit(DriverShipmentsState.error(error));
          }
        },
      );
    } finally {
      isFetchingMore = false;
      _isReloading = false;
    }
  }
}
