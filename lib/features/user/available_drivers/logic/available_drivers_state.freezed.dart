// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_drivers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvailableDriversState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableDriversState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState()';
}


}

/// @nodoc
class $AvailableDriversStateCopyWith<$Res>  {
$AvailableDriversStateCopyWith(AvailableDriversState _, $Res Function(AvailableDriversState) __);
}


/// Adds pattern-matching-related methods to [AvailableDriversState].
extension AvailableDriversStatePatterns on AvailableDriversState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( Empty value)?  empty,TResult Function( Error value)?  error,TResult Function( ShowExtendDialog value)?  showExtendDialog,TResult Function( ExtendSuccess value)?  extendSuccess,TResult Function( ShipmentExpired value)?  shipmentExpired,TResult Function( DeleteLoading value)?  deleteLoading,TResult Function( DeleteSuccess value)?  deleteSuccess,TResult Function( SendToDriverLoading value)?  sendToDriverLoading,TResult Function( SendToDriverSuccess value)?  sendToDriverSuccess,TResult Function( ActionError value)?  actionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Empty() when empty != null:
return empty(_that);case Error() when error != null:
return error(_that);case ShowExtendDialog() when showExtendDialog != null:
return showExtendDialog(_that);case ExtendSuccess() when extendSuccess != null:
return extendSuccess(_that);case ShipmentExpired() when shipmentExpired != null:
return shipmentExpired(_that);case DeleteLoading() when deleteLoading != null:
return deleteLoading(_that);case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case SendToDriverLoading() when sendToDriverLoading != null:
return sendToDriverLoading(_that);case SendToDriverSuccess() when sendToDriverSuccess != null:
return sendToDriverSuccess(_that);case ActionError() when actionError != null:
return actionError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( Empty value)  empty,required TResult Function( Error value)  error,required TResult Function( ShowExtendDialog value)  showExtendDialog,required TResult Function( ExtendSuccess value)  extendSuccess,required TResult Function( ShipmentExpired value)  shipmentExpired,required TResult Function( DeleteLoading value)  deleteLoading,required TResult Function( DeleteSuccess value)  deleteSuccess,required TResult Function( SendToDriverLoading value)  sendToDriverLoading,required TResult Function( SendToDriverSuccess value)  sendToDriverSuccess,required TResult Function( ActionError value)  actionError,}){
final _that = this;
switch (_that) {
case Loading():
return loading(_that);case Success():
return success(_that);case Empty():
return empty(_that);case Error():
return error(_that);case ShowExtendDialog():
return showExtendDialog(_that);case ExtendSuccess():
return extendSuccess(_that);case ShipmentExpired():
return shipmentExpired(_that);case DeleteLoading():
return deleteLoading(_that);case DeleteSuccess():
return deleteSuccess(_that);case SendToDriverLoading():
return sendToDriverLoading(_that);case SendToDriverSuccess():
return sendToDriverSuccess(_that);case ActionError():
return actionError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( Empty value)?  empty,TResult? Function( Error value)?  error,TResult? Function( ShowExtendDialog value)?  showExtendDialog,TResult? Function( ExtendSuccess value)?  extendSuccess,TResult? Function( ShipmentExpired value)?  shipmentExpired,TResult? Function( DeleteLoading value)?  deleteLoading,TResult? Function( DeleteSuccess value)?  deleteSuccess,TResult? Function( SendToDriverLoading value)?  sendToDriverLoading,TResult? Function( SendToDriverSuccess value)?  sendToDriverSuccess,TResult? Function( ActionError value)?  actionError,}){
final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Empty() when empty != null:
return empty(_that);case Error() when error != null:
return error(_that);case ShowExtendDialog() when showExtendDialog != null:
return showExtendDialog(_that);case ExtendSuccess() when extendSuccess != null:
return extendSuccess(_that);case ShipmentExpired() when shipmentExpired != null:
return shipmentExpired(_that);case DeleteLoading() when deleteLoading != null:
return deleteLoading(_that);case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case SendToDriverLoading() when sendToDriverLoading != null:
return sendToDriverLoading(_that);case SendToDriverSuccess() when sendToDriverSuccess != null:
return sendToDriverSuccess(_that);case ActionError() when actionError != null:
return actionError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<DriverModel> drivers)?  success,TResult Function()?  empty,TResult Function( ApiErrorModel error)?  error,TResult Function()?  showExtendDialog,TResult Function()?  extendSuccess,TResult Function()?  shipmentExpired,TResult Function()?  deleteLoading,TResult Function()?  deleteSuccess,TResult Function()?  sendToDriverLoading,TResult Function( String message)?  sendToDriverSuccess,TResult Function( ApiErrorModel error)?  actionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.drivers);case Empty() when empty != null:
return empty();case Error() when error != null:
return error(_that.error);case ShowExtendDialog() when showExtendDialog != null:
return showExtendDialog();case ExtendSuccess() when extendSuccess != null:
return extendSuccess();case ShipmentExpired() when shipmentExpired != null:
return shipmentExpired();case DeleteLoading() when deleteLoading != null:
return deleteLoading();case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess();case SendToDriverLoading() when sendToDriverLoading != null:
return sendToDriverLoading();case SendToDriverSuccess() when sendToDriverSuccess != null:
return sendToDriverSuccess(_that.message);case ActionError() when actionError != null:
return actionError(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<DriverModel> drivers)  success,required TResult Function()  empty,required TResult Function( ApiErrorModel error)  error,required TResult Function()  showExtendDialog,required TResult Function()  extendSuccess,required TResult Function()  shipmentExpired,required TResult Function()  deleteLoading,required TResult Function()  deleteSuccess,required TResult Function()  sendToDriverLoading,required TResult Function( String message)  sendToDriverSuccess,required TResult Function( ApiErrorModel error)  actionError,}) {final _that = this;
switch (_that) {
case Loading():
return loading();case Success():
return success(_that.drivers);case Empty():
return empty();case Error():
return error(_that.error);case ShowExtendDialog():
return showExtendDialog();case ExtendSuccess():
return extendSuccess();case ShipmentExpired():
return shipmentExpired();case DeleteLoading():
return deleteLoading();case DeleteSuccess():
return deleteSuccess();case SendToDriverLoading():
return sendToDriverLoading();case SendToDriverSuccess():
return sendToDriverSuccess(_that.message);case ActionError():
return actionError(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<DriverModel> drivers)?  success,TResult? Function()?  empty,TResult? Function( ApiErrorModel error)?  error,TResult? Function()?  showExtendDialog,TResult? Function()?  extendSuccess,TResult? Function()?  shipmentExpired,TResult? Function()?  deleteLoading,TResult? Function()?  deleteSuccess,TResult? Function()?  sendToDriverLoading,TResult? Function( String message)?  sendToDriverSuccess,TResult? Function( ApiErrorModel error)?  actionError,}) {final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.drivers);case Empty() when empty != null:
return empty();case Error() when error != null:
return error(_that.error);case ShowExtendDialog() when showExtendDialog != null:
return showExtendDialog();case ExtendSuccess() when extendSuccess != null:
return extendSuccess();case ShipmentExpired() when shipmentExpired != null:
return shipmentExpired();case DeleteLoading() when deleteLoading != null:
return deleteLoading();case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess();case SendToDriverLoading() when sendToDriverLoading != null:
return sendToDriverLoading();case SendToDriverSuccess() when sendToDriverSuccess != null:
return sendToDriverSuccess(_that.message);case ActionError() when actionError != null:
return actionError(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class Loading implements AvailableDriversState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.loading()';
}


}




/// @nodoc


class Success implements AvailableDriversState {
  const Success(final  List<DriverModel> drivers): _drivers = drivers;
  

 final  List<DriverModel> _drivers;
 List<DriverModel> get drivers {
  if (_drivers is EqualUnmodifiableListView) return _drivers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drivers);
}


/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&const DeepCollectionEquality().equals(other._drivers, _drivers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_drivers));

@override
String toString() {
  return 'AvailableDriversState.success(drivers: $drivers)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $AvailableDriversStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 List<DriverModel> drivers
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? drivers = null,}) {
  return _then(Success(
null == drivers ? _self._drivers : drivers // ignore: cast_nullable_to_non_nullable
as List<DriverModel>,
  ));
}


}

/// @nodoc


class Empty implements AvailableDriversState {
  const Empty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.empty()';
}


}




/// @nodoc


class Error implements AvailableDriversState {
  const Error(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of AvailableDriversState
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
  return 'AvailableDriversState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $AvailableDriversStateCopyWith<$Res> {
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

/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class ShowExtendDialog implements AvailableDriversState {
  const ShowExtendDialog();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowExtendDialog);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.showExtendDialog()';
}


}




/// @nodoc


class ExtendSuccess implements AvailableDriversState {
  const ExtendSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtendSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.extendSuccess()';
}


}




/// @nodoc


class ShipmentExpired implements AvailableDriversState {
  const ShipmentExpired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentExpired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.shipmentExpired()';
}


}




/// @nodoc


class DeleteLoading implements AvailableDriversState {
  const DeleteLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.deleteLoading()';
}


}




/// @nodoc


class DeleteSuccess implements AvailableDriversState {
  const DeleteSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.deleteSuccess()';
}


}




/// @nodoc


class SendToDriverLoading implements AvailableDriversState {
  const SendToDriverLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendToDriverLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvailableDriversState.sendToDriverLoading()';
}


}




/// @nodoc


class SendToDriverSuccess implements AvailableDriversState {
  const SendToDriverSuccess(this.message);
  

 final  String message;

/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendToDriverSuccessCopyWith<SendToDriverSuccess> get copyWith => _$SendToDriverSuccessCopyWithImpl<SendToDriverSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendToDriverSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AvailableDriversState.sendToDriverSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $SendToDriverSuccessCopyWith<$Res> implements $AvailableDriversStateCopyWith<$Res> {
  factory $SendToDriverSuccessCopyWith(SendToDriverSuccess value, $Res Function(SendToDriverSuccess) _then) = _$SendToDriverSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SendToDriverSuccessCopyWithImpl<$Res>
    implements $SendToDriverSuccessCopyWith<$Res> {
  _$SendToDriverSuccessCopyWithImpl(this._self, this._then);

  final SendToDriverSuccess _self;
  final $Res Function(SendToDriverSuccess) _then;

/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SendToDriverSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ActionError implements AvailableDriversState {
  const ActionError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionErrorCopyWith<ActionError> get copyWith => _$ActionErrorCopyWithImpl<ActionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AvailableDriversState.actionError(error: $error)';
}


}

/// @nodoc
abstract mixin class $ActionErrorCopyWith<$Res> implements $AvailableDriversStateCopyWith<$Res> {
  factory $ActionErrorCopyWith(ActionError value, $Res Function(ActionError) _then) = _$ActionErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ActionErrorCopyWithImpl<$Res>
    implements $ActionErrorCopyWith<$Res> {
  _$ActionErrorCopyWithImpl(this._self, this._then);

  final ActionError _self;
  final $Res Function(ActionError) _then;

/// Create a copy of AvailableDriversState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ActionError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
