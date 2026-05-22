import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/repositories/shipment_details_repository.dart';

/// Use case: Retrieve complete shipment details.
///
/// Single Responsibility: this class exists solely to orchestrate fetching
/// shipment details from the repository. Business rules (e.g., validation,
/// caching policy) live here — not in the cubit or repository.
///
/// Conforms to the Interface Segregation Principle — the cubit only depends
/// on this use case, not on the entire repository contract.
class GetShipmentDetailsUseCase {
  final ShipmentDetailsRepository _repository;

  const GetShipmentDetailsUseCase(this._repository);

  /// Executes the use case.
  /// [shipmentId] must be a positive integer.
  Future<ApiResult<ShipmentDetailsEntity>> call(int shipmentId) {
    assert(shipmentId > 0, 'shipmentId must be a positive integer');
    return _repository.getShipmentDetails(shipmentId);
  }
}
