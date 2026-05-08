// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeModel _$VehicleTypeModelFromJson(Map<String, dynamic> json) =>
    VehicleTypeModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      description: json['description'] as String,
      vehicleCoefficient: json['vehicle_coefficient'] as String,
      avgFuelConsumption: json['avg_fuel_consumption'] as String,
      baseFare: json['base_fare'] as String,
      minWeight: json['min_weight'] as String,
      maxWeight: json['max_weight'] as String,
      minLength: json['min_length'] as String,
      maxLength: json['max_length'] as String,
      minWidth: json['min_width'] as String,
      maxWidth: json['max_width'] as String,
      minHeight: json['min_height'] as String,
      maxHeight: json['max_height'] as String,
    );

Map<String, dynamic> _$VehicleTypeModelToJson(VehicleTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'description': instance.description,
      'vehicle_coefficient': instance.vehicleCoefficient,
      'avg_fuel_consumption': instance.avgFuelConsumption,
      'base_fare': instance.baseFare,
      'min_weight': instance.minWeight,
      'max_weight': instance.maxWeight,
      'min_length': instance.minLength,
      'max_length': instance.maxLength,
      'min_width': instance.minWidth,
      'max_width': instance.maxWidth,
      'min_height': instance.minHeight,
      'max_height': instance.maxHeight,
    };
