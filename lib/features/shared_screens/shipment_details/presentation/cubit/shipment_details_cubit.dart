import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/usecases/get_shipment_details_usecase.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/cubit/shipment_details_state.dart';

/// Cubit for the Shipment Details screen.
///
/// Responsibilities (and ONLY these):
///   - Translate UI events into use-case calls.
///   - Emit the correct [ShipmentDetailsState] based on the result.
///   - Maintain an in-memory cache to prevent redundant network calls.
///
/// Does NOT contain business logic, formatting, or UI concerns.
class ShipmentDetailsCubit extends Cubit<ShipmentDetailsState> {
  final GetShipmentDetailsUseCase _getShipmentDetailsUseCase;

  /// Static cache shared across cubit instances of the same session.
  /// Key: shipmentId. Cleared on logout via [clearCache].
  static final Map<int, ShipmentDetailsEntity> _cache = {};

  ShipmentDetailsCubit(this._getShipmentDetailsUseCase)
      : super(const ShipmentDetailsState.initial());

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Loads shipment details for [shipmentId].
  /// Serves instantly from cache if available; otherwise fetches from network.
  Future<void> load(int shipmentId) async {
    if (isClosed) return;

    final cached = _cache[shipmentId];
    if (cached != null) {
      emit(ShipmentDetailsState.success(cached));
      return;
    }

    emit(const ShipmentDetailsState.loading());
    await _fetch(shipmentId);
  }

  /// Forces a fresh network request for [shipmentId], bypassing the cache.
  Future<void> refresh(int shipmentId) async {
    if (isClosed) return;
    _cache.remove(shipmentId);
    emit(const ShipmentDetailsState.loading());
    await _fetch(shipmentId);
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<void> _fetch(int shipmentId) async {
    final result = await _getShipmentDetailsUseCase(shipmentId);
    if (isClosed) return;

    result.when(
      success: (data) {
        _cache[shipmentId] = data;
        emit(ShipmentDetailsState.success(data));
      },
      failure: (error) => emit(ShipmentDetailsState.error(error)),
    );
  }

  // ── Cache management ───────────────────────────────────────────────────────

  /// Evicts all cached shipment details (call on user logout).
  static void clearCache() => _cache.clear();

  /// Evicts cached data for a single shipment (call after an update).
  static void invalidate(int shipmentId) => _cache.remove(shipmentId);
}
