import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import '../data/repos/active_orders_repo.dart';
import 'active_orders_state.dart';


class ActiveOrdersCubit extends Cubit<ActiveOrdersState> {
  final ActiveOrdersRepo _repo;

  ActiveOrdersCubit(this._repo) : super(const ActiveOrdersState.initial());

  Future<void> fetchActiveOrders() async {
    emit(const ActiveOrdersState.loading());
    await _fetchAndEmit();
  }

  Future<void> silentRefresh() async {
    await _fetchAndEmit();
  }

  Future<void> _fetchAndEmit() async {
    if (isClosed) return;

    final result = await _repo.getActiveOrders();

    if (isClosed) return;

    result.when(
      success: (orders) {
        if (orders.isEmpty) {
          emit(const ActiveOrdersState.empty());
        } else {
          emit(ActiveOrdersState.loaded(orders));
        }
      },
      failure: (error) {
        emit(ActiveOrdersState.error(error));
      },
    );
  }
}
