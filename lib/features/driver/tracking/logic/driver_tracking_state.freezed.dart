// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_tracking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverTrackingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverTrackingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverTrackingState()';
}


}

/// @nodoc
class $DriverTrackingStateCopyWith<$Res>  {
$DriverTrackingStateCopyWith(DriverTrackingState _, $Res Function(DriverTrackingState) __);
}


/// Adds pattern-matching-related methods to [DriverTrackingState].
extension DriverTrackingStatePatterns on DriverTrackingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _LoadingQr value)?  loadingQr,TResult Function( _SuccessQr value)?  successQr,TResult Function( _ErrorQr value)?  errorQr,TResult Function( _LoadingPin value)?  loadingPin,TResult Function( _SuccessPin value)?  successPin,TResult Function( _ErrorPin value)?  errorPin,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _LoadingQr() when loadingQr != null:
return loadingQr(_that);case _SuccessQr() when successQr != null:
return successQr(_that);case _ErrorQr() when errorQr != null:
return errorQr(_that);case _LoadingPin() when loadingPin != null:
return loadingPin(_that);case _SuccessPin() when successPin != null:
return successPin(_that);case _ErrorPin() when errorPin != null:
return errorPin(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _LoadingQr value)  loadingQr,required TResult Function( _SuccessQr value)  successQr,required TResult Function( _ErrorQr value)  errorQr,required TResult Function( _LoadingPin value)  loadingPin,required TResult Function( _SuccessPin value)  successPin,required TResult Function( _ErrorPin value)  errorPin,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _LoadingQr():
return loadingQr(_that);case _SuccessQr():
return successQr(_that);case _ErrorQr():
return errorQr(_that);case _LoadingPin():
return loadingPin(_that);case _SuccessPin():
return successPin(_that);case _ErrorPin():
return errorPin(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _LoadingQr value)?  loadingQr,TResult? Function( _SuccessQr value)?  successQr,TResult? Function( _ErrorQr value)?  errorQr,TResult? Function( _LoadingPin value)?  loadingPin,TResult? Function( _SuccessPin value)?  successPin,TResult? Function( _ErrorPin value)?  errorPin,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _LoadingQr() when loadingQr != null:
return loadingQr(_that);case _SuccessQr() when successQr != null:
return successQr(_that);case _ErrorQr() when errorQr != null:
return errorQr(_that);case _LoadingPin() when loadingPin != null:
return loadingPin(_that);case _SuccessPin() when successPin != null:
return successPin(_that);case _ErrorPin() when errorPin != null:
return errorPin(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loadingQr,TResult Function( String message)?  successQr,TResult Function( String error)?  errorQr,TResult Function()?  loadingPin,TResult Function( String message)?  successPin,TResult Function( String error)?  errorPin,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _LoadingQr() when loadingQr != null:
return loadingQr();case _SuccessQr() when successQr != null:
return successQr(_that.message);case _ErrorQr() when errorQr != null:
return errorQr(_that.error);case _LoadingPin() when loadingPin != null:
return loadingPin();case _SuccessPin() when successPin != null:
return successPin(_that.message);case _ErrorPin() when errorPin != null:
return errorPin(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loadingQr,required TResult Function( String message)  successQr,required TResult Function( String error)  errorQr,required TResult Function()  loadingPin,required TResult Function( String message)  successPin,required TResult Function( String error)  errorPin,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _LoadingQr():
return loadingQr();case _SuccessQr():
return successQr(_that.message);case _ErrorQr():
return errorQr(_that.error);case _LoadingPin():
return loadingPin();case _SuccessPin():
return successPin(_that.message);case _ErrorPin():
return errorPin(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loadingQr,TResult? Function( String message)?  successQr,TResult? Function( String error)?  errorQr,TResult? Function()?  loadingPin,TResult? Function( String message)?  successPin,TResult? Function( String error)?  errorPin,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _LoadingQr() when loadingQr != null:
return loadingQr();case _SuccessQr() when successQr != null:
return successQr(_that.message);case _ErrorQr() when errorQr != null:
return errorQr(_that.error);case _LoadingPin() when loadingPin != null:
return loadingPin();case _SuccessPin() when successPin != null:
return successPin(_that.message);case _ErrorPin() when errorPin != null:
return errorPin(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DriverTrackingState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverTrackingState.initial()';
}


}




/// @nodoc


class _LoadingQr implements DriverTrackingState {
  const _LoadingQr();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingQr);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverTrackingState.loadingQr()';
}


}




/// @nodoc


class _SuccessQr implements DriverTrackingState {
  const _SuccessQr(this.message);
  

 final  String message;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessQrCopyWith<_SuccessQr> get copyWith => __$SuccessQrCopyWithImpl<_SuccessQr>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessQr&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DriverTrackingState.successQr(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessQrCopyWith<$Res> implements $DriverTrackingStateCopyWith<$Res> {
  factory _$SuccessQrCopyWith(_SuccessQr value, $Res Function(_SuccessQr) _then) = __$SuccessQrCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessQrCopyWithImpl<$Res>
    implements _$SuccessQrCopyWith<$Res> {
  __$SuccessQrCopyWithImpl(this._self, this._then);

  final _SuccessQr _self;
  final $Res Function(_SuccessQr) _then;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SuccessQr(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ErrorQr implements DriverTrackingState {
  const _ErrorQr(this.error);
  

 final  String error;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorQrCopyWith<_ErrorQr> get copyWith => __$ErrorQrCopyWithImpl<_ErrorQr>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorQr&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DriverTrackingState.errorQr(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorQrCopyWith<$Res> implements $DriverTrackingStateCopyWith<$Res> {
  factory _$ErrorQrCopyWith(_ErrorQr value, $Res Function(_ErrorQr) _then) = __$ErrorQrCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ErrorQrCopyWithImpl<$Res>
    implements _$ErrorQrCopyWith<$Res> {
  __$ErrorQrCopyWithImpl(this._self, this._then);

  final _ErrorQr _self;
  final $Res Function(_ErrorQr) _then;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_ErrorQr(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadingPin implements DriverTrackingState {
  const _LoadingPin();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingPin);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverTrackingState.loadingPin()';
}


}




/// @nodoc


class _SuccessPin implements DriverTrackingState {
  const _SuccessPin(this.message);
  

 final  String message;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessPinCopyWith<_SuccessPin> get copyWith => __$SuccessPinCopyWithImpl<_SuccessPin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessPin&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DriverTrackingState.successPin(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessPinCopyWith<$Res> implements $DriverTrackingStateCopyWith<$Res> {
  factory _$SuccessPinCopyWith(_SuccessPin value, $Res Function(_SuccessPin) _then) = __$SuccessPinCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessPinCopyWithImpl<$Res>
    implements _$SuccessPinCopyWith<$Res> {
  __$SuccessPinCopyWithImpl(this._self, this._then);

  final _SuccessPin _self;
  final $Res Function(_SuccessPin) _then;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SuccessPin(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ErrorPin implements DriverTrackingState {
  const _ErrorPin(this.error);
  

 final  String error;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorPinCopyWith<_ErrorPin> get copyWith => __$ErrorPinCopyWithImpl<_ErrorPin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorPin&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DriverTrackingState.errorPin(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorPinCopyWith<$Res> implements $DriverTrackingStateCopyWith<$Res> {
  factory _$ErrorPinCopyWith(_ErrorPin value, $Res Function(_ErrorPin) _then) = __$ErrorPinCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ErrorPinCopyWithImpl<$Res>
    implements _$ErrorPinCopyWith<$Res> {
  __$ErrorPinCopyWithImpl(this._self, this._then);

  final _ErrorPin _self;
  final $Res Function(_ErrorPin) _then;

/// Create a copy of DriverTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_ErrorPin(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
