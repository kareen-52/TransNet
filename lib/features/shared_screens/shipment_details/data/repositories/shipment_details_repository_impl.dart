import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/repositories/shipment_details_repository.dart';

class ShipmentDetailsRepositoryImpl implements ShipmentDetailsRepository {
  final ApiService _apiService;

  const ShipmentDetailsRepositoryImpl(this._apiService);

  @override
  Future<ApiResult<ShipmentDetailsEntity>> getShipmentDetails(
    int shipmentId,
  ) async {
    try {
      // Retrofit already deserializes into ShipmentDetailsResponseModel
      // directly — no need to call fromJson again.
      final responseModel = await _apiService.getShipmentDetails(shipmentId);
      return ApiResult.success(responseModel.toEntity());
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}