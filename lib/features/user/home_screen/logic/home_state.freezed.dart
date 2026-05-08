// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( HasActiveShipment value)?  hasActiveShipment,TResult Function( WaitingForDriver value)?  waitingForDriver,TResult Function( NoActiveShipment value)?  noActiveShipment,TResult Function( Error value)?  error,TResult Function( _DeleteLoading value)?  deleteLoading,TResult Function( CancelDriverLoading value)?  cancelDriverLoading,TResult Function( CancelDriverSuccess value)?  cancelDriverSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case HasActiveShipment() when hasActiveShipment != null:
return hasActiveShipment(_that);case WaitingForDriver() when waitingForDriver != null:
return waitingForDriver(_that);case NoActiveShipment() when noActiveShipment != null:
return noActiveShipment(_that);case Error() when error != null:
return error(_that);case _DeleteLoading() when deleteLoading != null:
return deleteLoading(_that);case CancelDriverLoading() when cancelDriverLoading != null:
return cancelDriverLoading(_that);case CancelDriverSuccess() when cancelDriverSuccess != null:
return cancelDriverSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( HasActiveShipment value)  hasActiveShipment,required TResult Function( WaitingForDriver value)  waitingForDriver,required TResult Function( NoActiveShipment value)  noActiveShipment,required TResult Function( Error value)  error,required TResult Function( _DeleteLoading value)  deleteLoading,required TResult Function( CancelDriverLoading value)  cancelDriverLoading,required TResult Function( CancelDriverSuccess value)  cancelDriverSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case HasActiveShipment():
return hasActiveShipment(_that);case WaitingForDriver():
return waitingForDriver(_that);case NoActiveShipment():
return noActiveShipment(_that);case Error():
return error(_that);case _DeleteLoading():
return deleteLoading(_that);case CancelDriverLoading():
return cancelDriverLoading(_that);case CancelDriverSuccess():
return cancelDriverSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( HasActiveShipment value)?  hasActiveShipment,TResult? Function( WaitingForDriver value)?  waitingForDriver,TResult? Function( NoActiveShipment value)?  noActiveShipment,TResult? Function( Error value)?  error,TResult? Function( _DeleteLoading value)?  deleteLoading,TResult? Function( CancelDriverLoading value)?  cancelDriverLoading,TResult? Function( CancelDriverSuccess value)?  cancelDriverSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case HasActiveShipment() when hasActiveShipment != null:
return hasActiveShipment(_that);case WaitingForDriver() when waitingForDriver != null:
return waitingForDriver(_that);case NoActiveShipment() when noActiveShipment != null:
return noActiveShipment(_that);case Error() when error != null:
return error(_that);case _DeleteLoading() when deleteLoading != null:
return deleteLoading(_that);case CancelDriverLoading() when cancelDriverLoading != null:
return cancelDriverLoading(_that);case CancelDriverSuccess() when cancelDriverSuccess != null:
return cancelDriverSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ShipmentModel shipment)?  hasActiveShipment,TResult Function( ShipmentModel shipment)?  waitingForDriver,TResult Function()?  noActiveShipment,TResult Function( ApiErrorModel error)?  error,TResult Function()?  deleteLoading,TResult Function()?  cancelDriverLoading,TResult Function( String message)?  cancelDriverSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case HasActiveShipment() when hasActiveShipment != null:
return hasActiveShipment(_that.shipment);case WaitingForDriver() when waitingForDriver != null:
return waitingForDriver(_that.shipment);case NoActiveShipment() when noActiveShipment != null:
return noActiveShipment();case Error() when error != null:
return error(_that.error);case _DeleteLoading() when deleteLoading != null:
return deleteLoading();case CancelDriverLoading() when cancelDriverLoading != null:
return cancelDriverLoading();case CancelDriverSuccess() when cancelDriverSuccess != null:
return cancelDriverSuccess(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ShipmentModel shipment)  hasActiveShipment,required TResult Function( ShipmentModel shipment)  waitingForDriver,required TResult Function()  noActiveShipment,required TResult Function( ApiErrorModel error)  error,required TResult Function()  deleteLoading,required TResult Function()  cancelDriverLoading,required TResult Function( String message)  cancelDriverSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case HasActiveShipment():
return hasActiveShipment(_that.shipment);case WaitingForDriver():
return waitingForDriver(_that.shipment);case NoActiveShipment():
return noActiveShipment();case Error():
return error(_that.error);case _DeleteLoading():
return deleteLoading();case CancelDriverLoading():
return cancelDriverLoading();case CancelDriverSuccess():
return cancelDriverSuccess(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ShipmentModel shipment)?  hasActiveShipment,TResult? Function( ShipmentModel shipment)?  waitingForDriver,TResult? Function()?  noActiveShipment,TResult? Function( ApiErrorModel error)?  error,TResult? Function()?  deleteLoading,TResult? Function()?  cancelDriverLoading,TResult? Function( String message)?  cancelDriverSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case HasActiveShipment() when hasActiveShipment != null:
return hasActiveShipment(_that.shipment);case WaitingForDriver() when waitingForDriver != null:
return waitingForDriver(_that.shipment);case NoActiveShipment() when noActiveShipment != null:
return noActiveShipment();case Error() when error != null:
return error(_that.error);case _DeleteLoading() when deleteLoading != null:
return deleteLoading();case CancelDriverLoading() when cancelDriverLoading != null:
return cancelDriverLoading();case CancelDriverSuccess() when cancelDriverSuccess != null:
return cancelDriverSuccess(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class _Loading implements HomeState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class HasActiveShipment implements HomeState {
  const HasActiveShipment(this.shipment);
  

 final  ShipmentModel shipment;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HasActiveShipmentCopyWith<HasActiveShipment> get copyWith => _$HasActiveShipmentCopyWithImpl<HasActiveShipment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HasActiveShipment&&(identical(other.shipment, shipment) || other.shipment == shipment));
}


@override
int get hashCode => Object.hash(runtimeType,shipment);

@override
String toString() {
  return 'HomeState.hasActiveShipment(shipment: $shipment)';
}


}

/// @nodoc
abstract mixin class $HasActiveShipmentCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HasActiveShipmentCopyWith(HasActiveShipment value, $Res Function(HasActiveShipment) _then) = _$HasActiveShipmentCopyWithImpl;
@useResult
$Res call({
 ShipmentModel shipment
});




}
/// @nodoc
class _$HasActiveShipmentCopyWithImpl<$Res>
    implements $HasActiveShipmentCopyWith<$Res> {
  _$HasActiveShipmentCopyWithImpl(this._self, this._then);

  final HasActiveShipment _self;
  final $Res Function(HasActiveShipment) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shipment = null,}) {
  return _then(HasActiveShipment(
null == shipment ? _self.shipment : shipment // ignore: cast_nullable_to_non_nullable
as ShipmentModel,
  ));
}


}

/// @nodoc


class WaitingForDriver implements HomeState {
  const WaitingForDriver(this.shipment);
  

 final  ShipmentModel shipment;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitingForDriverCopyWith<WaitingForDriver> get copyWith => _$WaitingForDriverCopyWithImpl<WaitingForDriver>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitingForDriver&&(identical(other.shipment, shipment) || other.shipment == shipment));
}


@override
int get hashCode => Object.hash(runtimeType,shipment);

@override
String toString() {
  return 'HomeState.waitingForDriver(shipment: $shipment)';
}


}

/// @nodoc
abstract mixin class $WaitingForDriverCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $WaitingForDriverCopyWith(WaitingForDriver value, $Res Function(WaitingForDriver) _then) = _$WaitingForDriverCopyWithImpl;
@useResult
$Res call({
 ShipmentModel shipment
});




}
/// @nodoc
class _$WaitingForDriverCopyWithImpl<$Res>
    implements $WaitingForDriverCopyWith<$Res> {
  _$WaitingForDriverCopyWithImpl(this._self, this._then);

  final WaitingForDriver _self;
  final $Res Function(WaitingForDriver) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shipment = null,}) {
  return _then(WaitingForDriver(
null == shipment ? _self.shipment : shipment // ignore: cast_nullable_to_non_nullable
as ShipmentModel,
  ));
}


}

/// @nodoc


class NoActiveShipment implements HomeState {
  const NoActiveShipment();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoActiveShipment);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.noActiveShipment()';
}


}




/// @nodoc


class Error implements HomeState {
  const Error(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'HomeState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class _DeleteLoading implements HomeState {
  const _DeleteLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.deleteLoading()';
}


}




/// @nodoc


class CancelDriverLoading implements HomeState {
  const CancelDriverLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelDriverLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.cancelDriverLoading()';
}


}




/// @nodoc


class CancelDriverSuccess implements HomeState {
  const CancelDriverSuccess(this.message);
  

 final  String message;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelDriverSuccessCopyWith<CancelDriverSuccess> get copyWith => _$CancelDriverSuccessCopyWithImpl<CancelDriverSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelDriverSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeState.cancelDriverSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $CancelDriverSuccessCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $CancelDriverSuccessCopyWith(CancelDriverSuccess value, $Res Function(CancelDriverSuccess) _then) = _$CancelDriverSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CancelDriverSuccessCopyWithImpl<$Res>
    implements $CancelDriverSuccessCopyWith<$Res> {
  _$CancelDriverSuccessCopyWithImpl(this._self, this._then);

  final CancelDriverSuccess _self;
  final $Res Function(CancelDriverSuccess) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CancelDriverSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
