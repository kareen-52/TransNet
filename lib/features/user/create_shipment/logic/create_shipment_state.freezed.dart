// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_shipment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateShipmentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateShipmentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateShipmentState()';
}


}

/// @nodoc
class $CreateShipmentStateCopyWith<$Res>  {
$CreateShipmentStateCopyWith(CreateShipmentState _, $Res Function(CreateShipmentState) __);
}


/// Adds pattern-matching-related methods to [CreateShipmentState].
extension CreateShipmentStatePatterns on CreateShipmentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GovLoading value)?  govLoading,TResult Function( GovSuccess value)?  govSuccess,TResult Function( GovError value)?  govError,TResult Function( SubmitLoading value)?  submitLoading,TResult Function( SubmitSuccess value)?  submitSuccess,TResult Function( SubmitError value)?  submitError,TResult Function( UiUpdated value)?  uiUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GovLoading() when govLoading != null:
return govLoading(_that);case GovSuccess() when govSuccess != null:
return govSuccess(_that);case GovError() when govError != null:
return govError(_that);case SubmitLoading() when submitLoading != null:
return submitLoading(_that);case SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case SubmitError() when submitError != null:
return submitError(_that);case UiUpdated() when uiUpdated != null:
return uiUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GovLoading value)  govLoading,required TResult Function( GovSuccess value)  govSuccess,required TResult Function( GovError value)  govError,required TResult Function( SubmitLoading value)  submitLoading,required TResult Function( SubmitSuccess value)  submitSuccess,required TResult Function( SubmitError value)  submitError,required TResult Function( UiUpdated value)  uiUpdated,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GovLoading():
return govLoading(_that);case GovSuccess():
return govSuccess(_that);case GovError():
return govError(_that);case SubmitLoading():
return submitLoading(_that);case SubmitSuccess():
return submitSuccess(_that);case SubmitError():
return submitError(_that);case UiUpdated():
return uiUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GovLoading value)?  govLoading,TResult? Function( GovSuccess value)?  govSuccess,TResult? Function( GovError value)?  govError,TResult? Function( SubmitLoading value)?  submitLoading,TResult? Function( SubmitSuccess value)?  submitSuccess,TResult? Function( SubmitError value)?  submitError,TResult? Function( UiUpdated value)?  uiUpdated,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GovLoading() when govLoading != null:
return govLoading(_that);case GovSuccess() when govSuccess != null:
return govSuccess(_that);case GovError() when govError != null:
return govError(_that);case SubmitLoading() when submitLoading != null:
return submitLoading(_that);case SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case SubmitError() when submitError != null:
return submitError(_that);case UiUpdated() when uiUpdated != null:
return uiUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  govLoading,TResult Function( List<GovernorateModel> governorates)?  govSuccess,TResult Function( ApiErrorModel error)?  govError,TResult Function()?  submitLoading,TResult Function( String message)?  submitSuccess,TResult Function( ApiErrorModel error)?  submitError,TResult Function( int timeStamp)?  uiUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GovLoading() when govLoading != null:
return govLoading();case GovSuccess() when govSuccess != null:
return govSuccess(_that.governorates);case GovError() when govError != null:
return govError(_that.error);case SubmitLoading() when submitLoading != null:
return submitLoading();case SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.message);case SubmitError() when submitError != null:
return submitError(_that.error);case UiUpdated() when uiUpdated != null:
return uiUpdated(_that.timeStamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  govLoading,required TResult Function( List<GovernorateModel> governorates)  govSuccess,required TResult Function( ApiErrorModel error)  govError,required TResult Function()  submitLoading,required TResult Function( String message)  submitSuccess,required TResult Function( ApiErrorModel error)  submitError,required TResult Function( int timeStamp)  uiUpdated,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GovLoading():
return govLoading();case GovSuccess():
return govSuccess(_that.governorates);case GovError():
return govError(_that.error);case SubmitLoading():
return submitLoading();case SubmitSuccess():
return submitSuccess(_that.message);case SubmitError():
return submitError(_that.error);case UiUpdated():
return uiUpdated(_that.timeStamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  govLoading,TResult? Function( List<GovernorateModel> governorates)?  govSuccess,TResult? Function( ApiErrorModel error)?  govError,TResult? Function()?  submitLoading,TResult? Function( String message)?  submitSuccess,TResult? Function( ApiErrorModel error)?  submitError,TResult? Function( int timeStamp)?  uiUpdated,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GovLoading() when govLoading != null:
return govLoading();case GovSuccess() when govSuccess != null:
return govSuccess(_that.governorates);case GovError() when govError != null:
return govError(_that.error);case SubmitLoading() when submitLoading != null:
return submitLoading();case SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.message);case SubmitError() when submitError != null:
return submitError(_that.error);case UiUpdated() when uiUpdated != null:
return uiUpdated(_that.timeStamp);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CreateShipmentState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateShipmentState.initial()';
}


}




/// @nodoc


class GovLoading implements CreateShipmentState {
  const GovLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateShipmentState.govLoading()';
}


}




/// @nodoc


class GovSuccess implements CreateShipmentState {
  const GovSuccess(final  List<GovernorateModel> governorates): _governorates = governorates;
  

 final  List<GovernorateModel> _governorates;
 List<GovernorateModel> get governorates {
  if (_governorates is EqualUnmodifiableListView) return _governorates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_governorates);
}


/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GovSuccessCopyWith<GovSuccess> get copyWith => _$GovSuccessCopyWithImpl<GovSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovSuccess&&const DeepCollectionEquality().equals(other._governorates, _governorates));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_governorates));

@override
String toString() {
  return 'CreateShipmentState.govSuccess(governorates: $governorates)';
}


}

/// @nodoc
abstract mixin class $GovSuccessCopyWith<$Res> implements $CreateShipmentStateCopyWith<$Res> {
  factory $GovSuccessCopyWith(GovSuccess value, $Res Function(GovSuccess) _then) = _$GovSuccessCopyWithImpl;
@useResult
$Res call({
 List<GovernorateModel> governorates
});




}
/// @nodoc
class _$GovSuccessCopyWithImpl<$Res>
    implements $GovSuccessCopyWith<$Res> {
  _$GovSuccessCopyWithImpl(this._self, this._then);

  final GovSuccess _self;
  final $Res Function(GovSuccess) _then;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? governorates = null,}) {
  return _then(GovSuccess(
null == governorates ? _self._governorates : governorates // ignore: cast_nullable_to_non_nullable
as List<GovernorateModel>,
  ));
}


}

/// @nodoc


class GovError implements CreateShipmentState {
  const GovError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GovErrorCopyWith<GovError> get copyWith => _$GovErrorCopyWithImpl<GovError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CreateShipmentState.govError(error: $error)';
}


}

/// @nodoc
abstract mixin class $GovErrorCopyWith<$Res> implements $CreateShipmentStateCopyWith<$Res> {
  factory $GovErrorCopyWith(GovError value, $Res Function(GovError) _then) = _$GovErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$GovErrorCopyWithImpl<$Res>
    implements $GovErrorCopyWith<$Res> {
  _$GovErrorCopyWithImpl(this._self, this._then);

  final GovError _self;
  final $Res Function(GovError) _then;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GovError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class SubmitLoading implements CreateShipmentState {
  const SubmitLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateShipmentState.submitLoading()';
}


}




/// @nodoc


class SubmitSuccess implements CreateShipmentState {
  const SubmitSuccess(this.message);
  

 final  String message;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitSuccessCopyWith<SubmitSuccess> get copyWith => _$SubmitSuccessCopyWithImpl<SubmitSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CreateShipmentState.submitSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $SubmitSuccessCopyWith<$Res> implements $CreateShipmentStateCopyWith<$Res> {
  factory $SubmitSuccessCopyWith(SubmitSuccess value, $Res Function(SubmitSuccess) _then) = _$SubmitSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SubmitSuccessCopyWithImpl<$Res>
    implements $SubmitSuccessCopyWith<$Res> {
  _$SubmitSuccessCopyWithImpl(this._self, this._then);

  final SubmitSuccess _self;
  final $Res Function(SubmitSuccess) _then;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SubmitSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SubmitError implements CreateShipmentState {
  const SubmitError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitErrorCopyWith<SubmitError> get copyWith => _$SubmitErrorCopyWithImpl<SubmitError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CreateShipmentState.submitError(error: $error)';
}


}

/// @nodoc
abstract mixin class $SubmitErrorCopyWith<$Res> implements $CreateShipmentStateCopyWith<$Res> {
  factory $SubmitErrorCopyWith(SubmitError value, $Res Function(SubmitError) _then) = _$SubmitErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$SubmitErrorCopyWithImpl<$Res>
    implements $SubmitErrorCopyWith<$Res> {
  _$SubmitErrorCopyWithImpl(this._self, this._then);

  final SubmitError _self;
  final $Res Function(SubmitError) _then;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(SubmitError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class UiUpdated implements CreateShipmentState {
  const UiUpdated(this.timeStamp);
  

 final  int timeStamp;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UiUpdatedCopyWith<UiUpdated> get copyWith => _$UiUpdatedCopyWithImpl<UiUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UiUpdated&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp));
}


@override
int get hashCode => Object.hash(runtimeType,timeStamp);

@override
String toString() {
  return 'CreateShipmentState.uiUpdated(timeStamp: $timeStamp)';
}


}

/// @nodoc
abstract mixin class $UiUpdatedCopyWith<$Res> implements $CreateShipmentStateCopyWith<$Res> {
  factory $UiUpdatedCopyWith(UiUpdated value, $Res Function(UiUpdated) _then) = _$UiUpdatedCopyWithImpl;
@useResult
$Res call({
 int timeStamp
});




}
/// @nodoc
class _$UiUpdatedCopyWithImpl<$Res>
    implements $UiUpdatedCopyWith<$Res> {
  _$UiUpdatedCopyWithImpl(this._self, this._then);

  final UiUpdated _self;
  final $Res Function(UiUpdated) _then;

/// Create a copy of CreateShipmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timeStamp = null,}) {
  return _then(UiUpdated(
null == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
