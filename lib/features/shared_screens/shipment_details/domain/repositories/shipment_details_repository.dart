import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';

/// Abstract repository contract for the Shipment Details domain.
///
/// The domain layer declares *what* it needs; the data layer decides *how*
/// to deliver it (network, cache, local DB, etc.).
/// Following the Dependency Inversion Principle (DIP).
abstract interface class ShipmentDetailsRepository {
  /// Fetches full shipment details by [shipmentId].
  /// Returns either a [ShipmentDetailsEntity] on success
  /// or an [ApiErrorModel] on failure.
  Future<ApiResult<ShipmentDetailsEntity>> getShipmentDetails(int shipmentId);
}
