// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveOrderModel {

 int get id;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'driver_id') int get driverId;@JsonKey(name: 'shipment_number') int get shipmentNumber; double get price; String get status; ActiveOrderDriverModel get driver;
/// Create a copy of ActiveOrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveOrderModelCopyWith<ActiveOrderModel> get copyWith => _$ActiveOrderModelCopyWithImpl<ActiveOrderModel>(this as ActiveOrderModel, _$identity);

  /// Serializes this ActiveOrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveOrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.shipmentNumber, shipmentNumber) || other.shipmentNumber == shipmentNumber)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.driver, driver) || other.driver == driver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,driverId,shipmentNumber,price,status,driver);

@override
String toString() {
  return 'ActiveOrderModel(id: $id, userId: $userId, driverId: $driverId, shipmentNumber: $shipmentNumber, price: $price, status: $status, driver: $driver)';
}


}

/// @nodoc
abstract mixin class $ActiveOrderModelCopyWith<$Res>  {
  factory $ActiveOrderModelCopyWith(ActiveOrderModel value, $Res Function(ActiveOrderModel) _then) = _$ActiveOrderModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'driver_id') int driverId,@JsonKey(name: 'shipment_number') int shipmentNumber, double price, String status, ActiveOrderDriverModel driver
});


$ActiveOrderDriverModelCopyWith<$Res> get driver;

}
/// @nodoc
class _$ActiveOrderModelCopyWithImpl<$Res>
    implements $ActiveOrderModelCopyWith<$Res> {
  _$ActiveOrderModelCopyWithImpl(this._self, this._then);

  final ActiveOrderModel _self;
  final $Res Function(ActiveOrderModel) _then;

/// Create a copy of ActiveOrderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? driverId = null,Object? shipmentNumber = null,Object? price = null,Object? status = null,Object? driver = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as int,shipmentNumber: null == shipmentNumber ? _self.shipmentNumber : shipmentNumber // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as ActiveOrderDriverModel,
  ));
}
/// Create a copy of ActiveOrderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveOrderDriverModelCopyWith<$Res> get driver {
  
  return $ActiveOrderDriverModelCopyWith<$Res>(_self.driver, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveOrderModel].
extension ActiveOrderModelPatterns on ActiveOrderModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveOrderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveOrderModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveOrderModel value)  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveOrderModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'driver_id')  int driverId, @JsonKey(name: 'shipment_number')  int shipmentNumber,  double price,  String status,  ActiveOrderDriverModel driver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveOrderModel() when $default != null:
return $default(_that.id,_that.userId,_that.driverId,_that.shipmentNumber,_that.price,_that.status,_that.driver);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'driver_id')  int driverId, @JsonKey(name: 'shipment_number')  int shipmentNumber,  double price,  String status,  ActiveOrderDriverModel driver)  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderModel():
return $default(_that.id,_that.userId,_that.driverId,_that.shipmentNumber,_that.price,_that.status,_that.driver);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'driver_id')  int driverId, @JsonKey(name: 'shipment_number')  int shipmentNumber,  double price,  String status,  ActiveOrderDriverModel driver)?  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderModel() when $default != null:
return $default(_that.id,_that.userId,_that.driverId,_that.shipmentNumber,_that.price,_that.status,_that.driver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveOrderModel implements ActiveOrderModel {
  const _ActiveOrderModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'driver_id') required this.driverId, @JsonKey(name: 'shipment_number') required this.shipmentNumber, required this.price, required this.status, required this.driver});
  factory _ActiveOrderModel.fromJson(Map<String, dynamic> json) => _$ActiveOrderModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'driver_id') final  int driverId;
@override@JsonKey(name: 'shipment_number') final  int shipmentNumber;
@override final  double price;
@override final  String status;
@override final  ActiveOrderDriverModel driver;

/// Create a copy of ActiveOrderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveOrderModelCopyWith<_ActiveOrderModel> get copyWith => __$ActiveOrderModelCopyWithImpl<_ActiveOrderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveOrderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveOrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.shipmentNumber, shipmentNumber) || other.shipmentNumber == shipmentNumber)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.driver, driver) || other.driver == driver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,driverId,shipmentNumber,price,status,driver);

@override
String toString() {
  return 'ActiveOrderModel(id: $id, userId: $userId, driverId: $driverId, shipmentNumber: $shipmentNumber, price: $price, status: $status, driver: $driver)';
}


}

/// @nodoc
abstract mixin class _$ActiveOrderModelCopyWith<$Res> implements $ActiveOrderModelCopyWith<$Res> {
  factory _$ActiveOrderModelCopyWith(_ActiveOrderModel value, $Res Function(_ActiveOrderModel) _then) = __$ActiveOrderModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'driver_id') int driverId,@JsonKey(name: 'shipment_number') int shipmentNumber, double price, String status, ActiveOrderDriverModel driver
});


@override $ActiveOrderDriverModelCopyWith<$Res> get driver;

}
/// @nodoc
class __$ActiveOrderModelCopyWithImpl<$Res>
    implements _$ActiveOrderModelCopyWith<$Res> {
  __$ActiveOrderModelCopyWithImpl(this._self, this._then);

  final _ActiveOrderModel _self;
  final $Res Function(_ActiveOrderModel) _then;

/// Create a copy of ActiveOrderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? driverId = null,Object? shipmentNumber = null,Object? price = null,Object? status = null,Object? driver = null,}) {
  return _then(_ActiveOrderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as int,shipmentNumber: null == shipmentNumber ? _self.shipmentNumber : shipmentNumber // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as ActiveOrderDriverModel,
  ));
}

/// Create a copy of ActiveOrderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveOrderDriverModelCopyWith<$Res> get driver {
  
  return $ActiveOrderDriverModelCopyWith<$Res>(_self.driver, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}


/// @nodoc
mixin _$ActiveOrderDriverModel {

 int get id;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'phone_number') String get phoneNumber;@JsonKey(name: 'user_number') String get userNumber;
/// Create a copy of ActiveOrderDriverModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveOrderDriverModelCopyWith<ActiveOrderDriverModel> get copyWith => _$ActiveOrderDriverModelCopyWithImpl<ActiveOrderDriverModel>(this as ActiveOrderDriverModel, _$identity);

  /// Serializes this ActiveOrderDriverModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveOrderDriverModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.userNumber, userNumber) || other.userNumber == userNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phoneNumber,userNumber);

@override
String toString() {
  return 'ActiveOrderDriverModel(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, userNumber: $userNumber)';
}


}

/// @nodoc
abstract mixin class $ActiveOrderDriverModelCopyWith<$Res>  {
  factory $ActiveOrderDriverModelCopyWith(ActiveOrderDriverModel value, $Res Function(ActiveOrderDriverModel) _then) = _$ActiveOrderDriverModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'phone_number') String phoneNumber,@JsonKey(name: 'user_number') String userNumber
});




}
/// @nodoc
class _$ActiveOrderDriverModelCopyWithImpl<$Res>
    implements $ActiveOrderDriverModelCopyWith<$Res> {
  _$ActiveOrderDriverModelCopyWithImpl(this._self, this._then);

  final ActiveOrderDriverModel _self;
  final $Res Function(ActiveOrderDriverModel) _then;

/// Create a copy of ActiveOrderDriverModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? userNumber = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,userNumber: null == userNumber ? _self.userNumber : userNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveOrderDriverModel].
extension ActiveOrderDriverModelPatterns on ActiveOrderDriverModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveOrderDriverModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveOrderDriverModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveOrderDriverModel value)  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderDriverModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveOrderDriverModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderDriverModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'phone_number')  String phoneNumber, @JsonKey(name: 'user_number')  String userNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveOrderDriverModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phoneNumber,_that.userNumber);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'phone_number')  String phoneNumber, @JsonKey(name: 'user_number')  String userNumber)  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderDriverModel():
return $default(_that.id,_that.firstName,_that.lastName,_that.phoneNumber,_that.userNumber);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'phone_number')  String phoneNumber, @JsonKey(name: 'user_number')  String userNumber)?  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderDriverModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phoneNumber,_that.userNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveOrderDriverModel implements ActiveOrderDriverModel {
  const _ActiveOrderDriverModel({required this.id, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, @JsonKey(name: 'phone_number') required this.phoneNumber, @JsonKey(name: 'user_number') required this.userNumber});
  factory _ActiveOrderDriverModel.fromJson(Map<String, dynamic> json) => _$ActiveOrderDriverModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'phone_number') final  String phoneNumber;
@override@JsonKey(name: 'user_number') final  String userNumber;

/// Create a copy of ActiveOrderDriverModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveOrderDriverModelCopyWith<_ActiveOrderDriverModel> get copyWith => __$ActiveOrderDriverModelCopyWithImpl<_ActiveOrderDriverModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveOrderDriverModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveOrderDriverModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.userNumber, userNumber) || other.userNumber == userNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phoneNumber,userNumber);

@override
String toString() {
  return 'ActiveOrderDriverModel(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, userNumber: $userNumber)';
}


}

/// @nodoc
abstract mixin class _$ActiveOrderDriverModelCopyWith<$Res> implements $ActiveOrderDriverModelCopyWith<$Res> {
  factory _$ActiveOrderDriverModelCopyWith(_ActiveOrderDriverModel value, $Res Function(_ActiveOrderDriverModel) _then) = __$ActiveOrderDriverModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'phone_number') String phoneNumber,@JsonKey(name: 'user_number') String userNumber
});




}
/// @nodoc
class __$ActiveOrderDriverModelCopyWithImpl<$Res>
    implements _$ActiveOrderDriverModelCopyWith<$Res> {
  __$ActiveOrderDriverModelCopyWithImpl(this._self, this._then);

  final _ActiveOrderDriverModel _self;
  final $Res Function(_ActiveOrderDriverModel) _then;

/// Create a copy of ActiveOrderDriverModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? userNumber = null,}) {
  return _then(_ActiveOrderDriverModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,userNumber: null == userNumber ? _self.userNumber : userNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
