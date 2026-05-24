// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_shipments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientShipmentsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientShipmentsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientShipmentsState()';
}


}

/// @nodoc
class $ClientShipmentsStateCopyWith<$Res>  {
$ClientShipmentsStateCopyWith(ClientShipmentsState _, $Res Function(ClientShipmentsState) __);
}


/// Adds pattern-matching-related methods to [ClientShipmentsState].
extension ClientShipmentsStatePatterns on ClientShipmentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( Empty value)?  empty,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Empty() when empty != null:
return empty(_that);case Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( Empty value)  empty,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case Empty():
return empty(_that);case Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( Empty value)?  empty,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Empty() when empty != null:
return empty(_that);case Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ShipmentModel> shipments,  bool hasReachedMax)?  success,TResult Function()?  empty,TResult Function( ApiErrorModel apiErrorModel)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.shipments,_that.hasReachedMax);case Empty() when empty != null:
return empty();case Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ShipmentModel> shipments,  bool hasReachedMax)  success,required TResult Function()  empty,required TResult Function( ApiErrorModel apiErrorModel)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case Success():
return success(_that.shipments,_that.hasReachedMax);case Empty():
return empty();case Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ShipmentModel> shipments,  bool hasReachedMax)?  success,TResult? Function()?  empty,TResult? Function( ApiErrorModel apiErrorModel)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.shipments,_that.hasReachedMax);case Empty() when empty != null:
return empty();case Error() when error != null:
return error(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ClientShipmentsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientShipmentsState.initial()';
}


}




/// @nodoc


class Loading implements ClientShipmentsState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientShipmentsState.loading()';
}


}




/// @nodoc


class Success implements ClientShipmentsState {
  const Success(final  List<ShipmentModel> shipments, this.hasReachedMax): _shipments = shipments;
  

 final  List<ShipmentModel> _shipments;
 List<ShipmentModel> get shipments {
  if (_shipments is EqualUnmodifiableListView) return _shipments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shipments);
}

 final  bool hasReachedMax;

/// Create a copy of ClientShipmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&const DeepCollectionEquality().equals(other._shipments, _shipments)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shipments),hasReachedMax);

@override
String toString() {
  return 'ClientShipmentsState.success(shipments: $shipments, hasReachedMax: $hasReachedMax)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $ClientShipmentsStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 List<ShipmentModel> shipments, bool hasReachedMax
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of ClientShipmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shipments = null,Object? hasReachedMax = null,}) {
  return _then(Success(
null == shipments ? _self._shipments : shipments // ignore: cast_nullable_to_non_nullable
as List<ShipmentModel>,null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Empty implements ClientShipmentsState {
  const Empty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientShipmentsState.empty()';
}


}




/// @nodoc


class Error implements ClientShipmentsState {
  const Error(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of ClientShipmentsState
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
  return 'ClientShipmentsState.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $ClientShipmentsStateCopyWith<$Res> {
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

/// Create a copy of ClientShipmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(Error(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
