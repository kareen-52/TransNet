import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';

abstract interface class ShipmentDetailsRepository {

  Future<ApiResult<ShipmentDetailsEntity>> getShipmentDetails(int shipmentId);
}
