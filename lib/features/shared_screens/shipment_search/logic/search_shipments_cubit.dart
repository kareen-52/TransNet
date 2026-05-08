import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/data/repo/shipment_search_repo.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/logic/search_shipments_state.dart';

class SearchShipmentsCubit extends Cubit<SearchShipmentsState> {
  final ShipmentSearchRepo _repo;
  SearchShipmentsCubit(this._repo) : super(const SearchShipmentsState.initial());

  Future<void> search({required String startDate, required String endDate}) async {
    emit(const SearchShipmentsState.loading());
    final result = await _repo.searchByDate(startDate: startDate, endDate: endDate);
    result.when(
      success: (shipments) {
        if (shipments.isEmpty) {
          emit(const SearchShipmentsState.empty());
        } else {
          emit(SearchShipmentsState.loaded(shipments));
        }
      },
      failure: (error) => emit(SearchShipmentsState.error(error)),
    );
  }
}