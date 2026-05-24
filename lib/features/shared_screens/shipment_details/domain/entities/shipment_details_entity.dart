import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/party_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/route_geometry_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';


class ShipmentDetailsEntity {
  final ShipmentEntity shipment;
  final RouteGeometryEntity? routeGeometry;
  final PartyEntity? driver;
  final PartyEntity? client;

  const ShipmentDetailsEntity({
    required this.shipment,
    this.routeGeometry,
    this.driver,
    this.client,
  });

  bool get hasDriver => driver != null;
  bool get hasClient => client != null;
  bool get hasRoute => routeGeometry != null && routeGeometry!.isNotEmpty;
  bool get hasParties => hasDriver || hasClient;
}
