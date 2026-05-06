import 'package:json_annotation/json_annotation.dart';
part 'vehicle_type_model.g.dart';

@JsonSerializable()
class VehicleTypeModel {
  final int id;
  final String type;
  final String description;
  @JsonKey(name: 'vehicle_coefficient')
  final String vehicleCoefficient;
  @JsonKey(name: 'avg_fuel_consumption')
  final String avgFuelConsumption;
  @JsonKey(name: 'base_fare')
  final String baseFare;
  @JsonKey(name: 'min_weight')
  final String minWeight;
  @JsonKey(name: 'max_weight')
  final String maxWeight;
  @JsonKey(name: 'min_length')
  final String minLength;
  @JsonKey(name: 'max_length')
  final String maxLength;
  @JsonKey(name: 'min_width')
  final String minWidth;
  @JsonKey(name: 'max_width')
  final String maxWidth;
  @JsonKey(name: 'min_height')
  final String minHeight;
  @JsonKey(name: 'max_height')
  final String maxHeight;

  VehicleTypeModel({
    required this.id,
    required this.type,
    required this.description,
    required this.vehicleCoefficient,
    required this.avgFuelConsumption,
    required this.baseFare,
    required this.minWeight,
    required this.maxWeight,
    required this.minLength,
    required this.maxLength,
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) => _$VehicleTypeModelFromJson(json);


}