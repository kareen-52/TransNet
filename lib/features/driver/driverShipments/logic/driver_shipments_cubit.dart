import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/repo/driver_shipments_repo.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_state.dart';

class DriverShipmentsCubit extends Cubit<DriverShipmentsState> {
  final DriverShipmentsRepo _repo;
  int currentPage = 1;
  bool isFetchingMore = false;
  bool hasReachedMax = false;
  List<ShipmentModel> allShipments = [];

  DriverShipmentsCubit(this._repo) : super(const DriverShipmentsState.initial());

  Future<void> getShipments({bool isReload = false}) async {
  
    if (isFetchingMore) return;

  
    if (hasReachedMax && !isReload) return;

    if (isReload) {
      currentPage = 1;
      hasReachedMax = false;
      allShipments.clear();
      emit(const DriverShipmentsState.loading());
    }

    isFetchingMore = true;

    final response = await _repo.getShipments(currentPage);

    response.when(
      success: (data) {
        final shipments = data.data ?? [];
        final lastPage = data.lastPage;

   
        if (lastPage != null && currentPage >= lastPage) {
          hasReachedMax = true;
        } else {
          hasReachedMax = false;
        }

        allShipments.addAll(shipments);

        if (!hasReachedMax) currentPage++;

        emit(DriverShipmentsState.success(List.from(allShipments), hasReachedMax));
        isFetchingMore = false;
      },
      failure: (error) {
        isFetchingMore = false;

        if (allShipments.isNotEmpty) {
          emit(DriverShipmentsState.success(List.from(allShipments), hasReachedMax));
        
        } else {
          emit(DriverShipmentsState.error(error));
        }
      },
    );
  }
}