// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentDetailsResponseModel _$ShipmentDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => ShipmentDetailsResponseModel(
  shipment: ShipmentDetailModel.fromJson(
    json['shipment'] as Map<String, dynamic>,
  ),
  routeGeometry: json['route_geometry'] == null
      ? null
      : RouteGeometryModel.fromJson(
          json['route_geometry'] as Map<String, dynamic>,
        ),
  liveTracking: json['live_tracking'],
  driver: json['driver'] == null
      ? null
      : PartyModel.fromJson(json['driver'] as Map<String, dynamic>),
  client: json['client'] == null
      ? null
      : PartyModel.fromJson(json['client'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ShipmentDetailsResponseModelToJson(
  ShipmentDetailsResponseModel instance,
) => <String, dynamic>{
  'shipment': instance.shipment,
  'route_geometry': instance.routeGeometry,
  'live_tracking': instance.liveTracking,
  'driver': instance.driver,
  'client': instance.client,
};
