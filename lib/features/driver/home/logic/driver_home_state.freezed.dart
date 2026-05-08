// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverHomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverHomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverHomeState()';
}


}

/// @nodoc
class $DriverHomeStateCopyWith<$Res>  {
$DriverHomeStateCopyWith(DriverHomeState _, $Res Function(DriverHomeState) __);
}


/// Adds pattern-matching-related methods to [DriverHomeState].
extension DriverHomeStatePatterns on DriverHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( AvailabilityChanged value)?  availabilityChanged,TResult Function( ShipmentCountLoaded value)?  shipmentCountLoaded,TResult Function( DriverImageLoaded value)?  driverImageLoaded,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case AvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that);case ShipmentCountLoaded() when shipmentCountLoaded != null:
return shipmentCountLoaded(_that);case DriverImageLoaded() when driverImageLoaded != null:
return driverImageLoaded(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( AvailabilityChanged value)  availabilityChanged,required TResult Function( ShipmentCountLoaded value)  shipmentCountLoaded,required TResult Function( DriverImageLoaded value)  driverImageLoaded,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case AvailabilityChanged():
return availabilityChanged(_that);case ShipmentCountLoaded():
return shipmentCountLoaded(_that);case DriverImageLoaded():
return driverImageLoaded(_that);case Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( AvailabilityChanged value)?  availabilityChanged,TResult? Function( ShipmentCountLoaded value)?  shipmentCountLoaded,TResult? Function( DriverImageLoaded value)?  driverImageLoaded,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case AvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that);case ShipmentCountLoaded() when shipmentCountLoaded != null:
return shipmentCountLoaded(_that);case DriverImageLoaded() when driverImageLoaded != null:
return driverImageLoaded(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message,  bool isAvailable)?  availabilityChanged,TResult Function( int count)?  shipmentCountLoaded,TResult Function( Uint8List imageBytes)?  driverImageLoaded,TResult Function( ApiErrorModel apiErrorModel)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case AvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that.message,_that.isAvailable);case ShipmentCountLoaded() when shipmentCountLoaded != null:
return shipmentCountLoaded(_that.count);case DriverImageLoaded() when driverImageLoaded != null:
return driverImageLoaded(_that.imageBytes);case Error() when error != null:
return error(_that.apiErrorModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message,  bool isAvailable)  availabilityChanged,required TResult Function( int count)  shipmentCountLoaded,required TResult Function( Uint8List imageBytes)  driverImageLoaded,required TResult Function( ApiErrorModel apiErrorModel)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case AvailabilityChanged():
return availabilityChanged(_that.message,_that.isAvailable);case ShipmentCountLoaded():
return shipmentCountLoaded(_that.count);case DriverImageLoaded():
return driverImageLoaded(_that.imageBytes);case Error():
return error(_that.apiErrorModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message,  bool isAvailable)?  availabilityChanged,TResult? Function( int count)?  shipmentCountLoaded,TResult? Function( Uint8List imageBytes)?  driverImageLoaded,TResult? Function( ApiErrorModel apiErrorModel)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case AvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that.message,_that.isAvailable);case ShipmentCountLoaded() when shipmentCountLoaded != null:
return shipmentCountLoaded(_that.count);case DriverImageLoaded() when driverImageLoaded != null:
return driverImageLoaded(_that.imageBytes);case Error() when error != null:
return error(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DriverHomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverHomeState.initial()';
}


}




/// @nodoc


class Loading implements DriverHomeState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverHomeState.loading()';
}


}




/// @nodoc


class AvailabilityChanged implements DriverHomeState {
  const AvailabilityChanged({required this.message, required this.isAvailable});
  

 final  String message;
 final  bool isAvailable;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityChangedCopyWith<AvailabilityChanged> get copyWith => _$AvailabilityChangedCopyWithImpl<AvailabilityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityChanged&&(identical(other.message, message) || other.message == message)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,message,isAvailable);

@override
String toString() {
  return 'DriverHomeState.availabilityChanged(message: $message, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $AvailabilityChangedCopyWith<$Res> implements $DriverHomeStateCopyWith<$Res> {
  factory $AvailabilityChangedCopyWith(AvailabilityChanged value, $Res Function(AvailabilityChanged) _then) = _$AvailabilityChangedCopyWithImpl;
@useResult
$Res call({
 String message, bool isAvailable
});




}
/// @nodoc
class _$AvailabilityChangedCopyWithImpl<$Res>
    implements $AvailabilityChangedCopyWith<$Res> {
  _$AvailabilityChangedCopyWithImpl(this._self, this._then);

  final AvailabilityChanged _self;
  final $Res Function(AvailabilityChanged) _then;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? isAvailable = null,}) {
  return _then(AvailabilityChanged(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ShipmentCountLoaded implements DriverHomeState {
  const ShipmentCountLoaded(this.count);
  

 final  int count;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipmentCountLoadedCopyWith<ShipmentCountLoaded> get copyWith => _$ShipmentCountLoadedCopyWithImpl<ShipmentCountLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentCountLoaded&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'DriverHomeState.shipmentCountLoaded(count: $count)';
}


}

/// @nodoc
abstract mixin class $ShipmentCountLoadedCopyWith<$Res> implements $DriverHomeStateCopyWith<$Res> {
  factory $ShipmentCountLoadedCopyWith(ShipmentCountLoaded value, $Res Function(ShipmentCountLoaded) _then) = _$ShipmentCountLoadedCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$ShipmentCountLoadedCopyWithImpl<$Res>
    implements $ShipmentCountLoadedCopyWith<$Res> {
  _$ShipmentCountLoadedCopyWithImpl(this._self, this._then);

  final ShipmentCountLoaded _self;
  final $Res Function(ShipmentCountLoaded) _then;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(ShipmentCountLoaded(
null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DriverImageLoaded implements DriverHomeState {
  const DriverImageLoaded(this.imageBytes);
  

 final  Uint8List imageBytes;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverImageLoadedCopyWith<DriverImageLoaded> get copyWith => _$DriverImageLoadedCopyWithImpl<DriverImageLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverImageLoaded&&const DeepCollectionEquality().equals(other.imageBytes, imageBytes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imageBytes));

@override
String toString() {
  return 'DriverHomeState.driverImageLoaded(imageBytes: $imageBytes)';
}


}

/// @nodoc
abstract mixin class $DriverImageLoadedCopyWith<$Res> implements $DriverHomeStateCopyWith<$Res> {
  factory $DriverImageLoadedCopyWith(DriverImageLoaded value, $Res Function(DriverImageLoaded) _then) = _$DriverImageLoadedCopyWithImpl;
@useResult
$Res call({
 Uint8List imageBytes
});




}
/// @nodoc
class _$DriverImageLoadedCopyWithImpl<$Res>
    implements $DriverImageLoadedCopyWith<$Res> {
  _$DriverImageLoadedCopyWithImpl(this._self, this._then);

  final DriverImageLoaded _self;
  final $Res Function(DriverImageLoaded) _then;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageBytes = null,}) {
  return _then(DriverImageLoaded(
null == imageBytes ? _self.imageBytes : imageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class Error implements DriverHomeState {
  const Error(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'DriverHomeState.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $DriverHomeStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(Error(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
