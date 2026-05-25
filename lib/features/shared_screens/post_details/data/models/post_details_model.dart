import 'package:json_annotation/json_annotation.dart';

part 'post_details_model.g.dart';

String? _stringFromJson(dynamic value) => value?.toString();

@JsonSerializable()
class PostDetailsModel {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(fromJson: _stringFromJson)
  final String? weight;
  @JsonKey(fromJson: _stringFromJson)
  final String? height;
  @JsonKey(fromJson: _stringFromJson)
  final String? width;
  @JsonKey(fromJson: _stringFromJson)
  final String? length;
  final String? object;
  final int? insurance;
  @JsonKey(name: 'start_position_lat', fromJson: _stringFromJson)
  final String? startPositionLat;
  @JsonKey(name: 'start_position_lng', fromJson: _stringFromJson)
  final String? startPositionLng;
  @JsonKey(name: 'end_position_lat', fromJson: _stringFromJson)
  final String? endPositionLat;
  @JsonKey(name: 'end_position_lng', fromJson: _stringFromJson)
  final String? endPositionLng;
  @JsonKey(name: 'start_location_details')
  final String? startLocationDetails;
  @JsonKey(name: 'end_location_details')
  final String? endLocationDetails;
  @JsonKey(name: 'max_price')
  final num? maxPrice;
  @JsonKey(name: 'min_price')
  final num? minPrice;
  @JsonKey(name: 'last_date')
  final String? lastDate;
  final int? finished;
  @JsonKey(name: 'start_governorate')
  final String? startGovernorate;
  @JsonKey(name: 'end_governorate')
  final String? endGovernorate;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  
  final List<PostDriverOfferModel>? drivers;

  PostDetailsModel({
    required this.id,
    required this.userId,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.object,
    this.insurance,
    this.startPositionLat,
    this.startPositionLng,
    this.endPositionLat,
    this.endPositionLng,
    this.startLocationDetails,
    this.endLocationDetails,
    this.maxPrice,
    this.minPrice,
    this.lastDate,
    this.finished,
    this.startGovernorate,
    this.endGovernorate,
    this.createdAt,
    this.updatedAt,
    this.drivers,
  });

  bool get isFinished => finished == 1;

  String get formattedPriceRange {
    if (minPrice == null || maxPrice == null) return 'غير محدد';
    return '${_formatNumber(minPrice!)} - ${_formatNumber(maxPrice!)} ل.س';
  }

  String _formatNumber(num number) {
    return number
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) => 
      _$PostDetailsModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PostDetailsModelToJson(this);
}

@JsonSerializable()
class PostDriverOfferModel {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final num? rating;
  final String? vehicle;
  final String? date;
  final num? price;
  final String? badge;
  @JsonKey(name: 'badge_text')
  final String? badgeText;

  PostDriverOfferModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.rating,
    this.vehicle,
    this.date,
    this.price,
    this.badge,
    this.badgeText,
  });

  String get fullName => '$firstName $lastName';

  String get formattedPrice {
    if (price == null) return 'غير محدد';
    return '${price!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ل.س';
  }

  factory PostDriverOfferModel.fromJson(Map<String, dynamic> json) => 
      _$PostDriverOfferModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PostDriverOfferModelToJson(this);
}