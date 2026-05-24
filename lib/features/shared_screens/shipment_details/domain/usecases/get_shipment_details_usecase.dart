import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/repositories/shipment_details_repository.dart';

class GetShipmentDetailsUseCase {
  final ShipmentDetailsRepository _repository;

  const GetShipmentDetailsUseCase(this._repository);


  Future<ApiResult<ShipmentDetailsEntity>> call(int shipmentId) {
    assert(shipmentId > 0, 'shipmentId must be a positive integer');
    return _repository.getShipmentDetails(shipmentId);
  }
}
