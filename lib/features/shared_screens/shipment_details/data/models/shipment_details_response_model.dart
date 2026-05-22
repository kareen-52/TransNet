import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/data/models/party_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/data/models/route_geometry_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/data/models/shipment_detail_model.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';

part 'shipment_details_response_model.g.dart';

/// Root API response model for the shipment details endpoint.
/// Wraps all nested models and exposes a single [toEntity()] converter
/// that produces the clean domain aggregate.
@JsonSerializable()
class ShipmentDetailsResponseModel {
  final ShipmentDetailModel shipment;

  @JsonKey(name: 'route_geometry')
  final RouteGeometryModel? routeGeometry;

  @JsonKey(name: 'live_tracking')
  final dynamic liveTracking;

  final PartyModel? driver;
  final PartyModel? client;

  const ShipmentDetailsResponseModel({
    required this.shipment,
    this.routeGeometry,
    this.liveTracking,
    this.driver,
    this.client,
  });

  factory ShipmentDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentDetailsResponseModelToJson(this);

  /// Converts the full API response into the clean domain entity aggregate.
  ShipmentDetailsEntity toEntity() => ShipmentDetailsEntity(
        shipment: shipment.toEntity(),
        routeGeometry: routeGeometry?.toEntity(),
        driver: driver?.toEntity(),
        client: client?.toEntity(),
      );
}
