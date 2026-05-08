import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/logic/shipment_details_state.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/repo/shipment_details_repo.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';

class ShipmentDetailsCubit extends Cubit<ShipmentDetailsState> {
  final ShipmentsDetailsRepo _repo;

  /// In-memory cache: shipmentId → response (survives widget rebuilds)
  static final Map<int, ShipmentDetailsResponse> _cache = {};

  ShipmentDetailsCubit(this._repo) : super(const ShipmentDetailsState.initial());

  Future<void> loadShipmentDetails(int shipmentId, {bool forceRefresh = false}) async {
    if (isClosed) return;

    // Serve from cache immediately while refreshing in background
    if (_cache.containsKey(shipmentId) && !forceRefresh) {
      emit(ShipmentDetailsState.success(_cache[shipmentId]!));
      return;
    }

    emit(const ShipmentDetailsState.loading());
    await _fetchAndEmit(shipmentId);
  }

  Future<void> refresh(int shipmentId) async {
    if (isClosed) return;
    // Keep current data visible while refreshing
    final cached = _cache[shipmentId];
    if (cached != null) {
      emit(ShipmentDetailsState.success(cached)); // keep data visible
    }
    await _fetchAndEmit(shipmentId);
  }

  Future<void> _fetchAndEmit(int shipmentId) async {
    final result = await _repo.getShipmentDetails(shipmentId);
    if (isClosed) return;

    result.when(
      success: (data) {
        _cache[shipmentId] = data; // store in cache
        if (!isClosed) emit(ShipmentDetailsState.success(data));
      },
      failure: (error) {
        if (!isClosed) emit(ShipmentDetailsState.error(error));
      },
    );
  }

  /// Invalidate cache entry (e.g., after a status update)
  static void invalidateCache(int shipmentId) => _cache.remove(shipmentId);

  /// Clear entire cache (e.g., on logout)
  static void clearCache() => _cache.clear();
}