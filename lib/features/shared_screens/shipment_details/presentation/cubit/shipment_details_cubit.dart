import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/usecases/get_shipment_details_usecase.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/cubit/shipment_details_state.dart';

class ShipmentDetailsCubit extends Cubit<ShipmentDetailsState> {
  final GetShipmentDetailsUseCase _getShipmentDetailsUseCase;


  static final Map<String, ShipmentDetailsEntity> _cache = {};

  ShipmentDetailsCubit(this._getShipmentDetailsUseCase)
      : super(const ShipmentDetailsState.initial());

  static String _cacheKey(int userId, int shipmentId) => '${userId}_$shipmentId';

  static int? _getCurrentUserId() {
    return SharedPrefHelper.getInt(SharedPrefKeys.userId);
  }

  Future<void> load(int shipmentId) async {
    if (isClosed) return;

    final userId = _getCurrentUserId();
    if (userId == null) {
    
      emit(const ShipmentDetailsState.loading());
      await _fetch(shipmentId);
      return;
    }

    final key = _cacheKey(userId, shipmentId);
    final cached = _cache[key];
    if (cached != null) {
      emit(ShipmentDetailsState.success(cached));
      return;
    }

    emit(const ShipmentDetailsState.loading());
    await _fetch(shipmentId, userId: userId);
  }

  Future<void> refresh(int shipmentId) async {
    if (isClosed) return;
    final userId = _getCurrentUserId();
    if (userId != null) {
      _cache.remove(_cacheKey(userId, shipmentId));
    } else {
  
      _cache.removeWhere((key, _) => key.endsWith('_$shipmentId'));
    }
    emit(const ShipmentDetailsState.loading());
    await _fetch(shipmentId, userId: userId);
  }

  Future<void> _fetch(int shipmentId, {int? userId}) async {
    final result = await _getShipmentDetailsUseCase(shipmentId);
    if (isClosed) return;

    result.when(
      success: (data) {
        if (userId != null) {
          final key = _cacheKey(userId, shipmentId);
          _cache[key] = data;
        }
        emit(ShipmentDetailsState.success(data));
      },
      failure: (error) => emit(ShipmentDetailsState.error(error)),
    );
  }

  static void clearCurrentUserCache() {
    final userId = SharedPrefHelper.getInt(SharedPrefKeys.userId);
 
    _cache.removeWhere((key, _) => key.startsWith('${userId}_'));
  }


  static void clearAllCache() => _cache.clear();


  static void invalidate(int shipmentId) {
    final userId = SharedPrefHelper.getInt(SharedPrefKeys.userId);
  
      _cache.remove(_cacheKey(userId, shipmentId));
    
  }
}