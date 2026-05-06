// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerificationState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerificationState<$T>()';
}


}

/// @nodoc
class $VerificationStateCopyWith<T,$Res>  {
$VerificationStateCopyWith(VerificationState<T> _, $Res Function(VerificationState<T>) __);
}


/// Adds pattern-matching-related methods to [VerificationState].
extension VerificationStatePatterns<T> on VerificationState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( VerificationLoading<T> value)?  loading,TResult Function( VerificationSuccess<T> value)?  success,TResult Function( VerificationError<T> value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case VerificationLoading() when loading != null:
return loading(_that);case VerificationSuccess() when success != null:
return success(_that);case VerificationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( VerificationLoading<T> value)  loading,required TResult Function( VerificationSuccess<T> value)  success,required TResult Function( VerificationError<T> value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case VerificationLoading():
return loading(_that);case VerificationSuccess():
return success(_that);case VerificationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( VerificationLoading<T> value)?  loading,TResult? Function( VerificationSuccess<T> value)?  success,TResult? Function( VerificationError<T> value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case VerificationLoading() when loading != null:
return loading(_that);case VerificationSuccess() when success != null:
return success(_that);case VerificationError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isResending)?  loading,TResult Function( T data,  bool isResending)?  success,TResult Function( ApiErrorModel apiErrorModel)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case VerificationLoading() when loading != null:
return loading(_that.isResending);case VerificationSuccess() when success != null:
return success(_that.data,_that.isResending);case VerificationError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isResending)  loading,required TResult Function( T data,  bool isResending)  success,required TResult Function( ApiErrorModel apiErrorModel)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case VerificationLoading():
return loading(_that.isResending);case VerificationSuccess():
return success(_that.data,_that.isResending);case VerificationError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isResending)?  loading,TResult? Function( T data,  bool isResending)?  success,TResult? Function( ApiErrorModel apiErrorModel)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case VerificationLoading() when loading != null:
return loading(_that.isResending);case VerificationSuccess() when success != null:
return success(_that.data,_that.isResending);case VerificationError() when error != null:
return error(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements VerificationState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerificationState<$T>.initial()';
}


}




/// @nodoc


class VerificationLoading<T> implements VerificationState<T> {
  const VerificationLoading({this.isResending = false});
  

@JsonKey() final  bool isResending;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationLoadingCopyWith<T, VerificationLoading<T>> get copyWith => _$VerificationLoadingCopyWithImpl<T, VerificationLoading<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationLoading<T>&&(identical(other.isResending, isResending) || other.isResending == isResending));
}


@override
int get hashCode => Object.hash(runtimeType,isResending);

@override
String toString() {
  return 'VerificationState<$T>.loading(isResending: $isResending)';
}


}

/// @nodoc
abstract mixin class $VerificationLoadingCopyWith<T,$Res> implements $VerificationStateCopyWith<T, $Res> {
  factory $VerificationLoadingCopyWith(VerificationLoading<T> value, $Res Function(VerificationLoading<T>) _then) = _$VerificationLoadingCopyWithImpl;
@useResult
$Res call({
 bool isResending
});




}
/// @nodoc
class _$VerificationLoadingCopyWithImpl<T,$Res>
    implements $VerificationLoadingCopyWith<T, $Res> {
  _$VerificationLoadingCopyWithImpl(this._self, this._then);

  final VerificationLoading<T> _self;
  final $Res Function(VerificationLoading<T>) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isResending = null,}) {
  return _then(VerificationLoading<T>(
isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class VerificationSuccess<T> implements VerificationState<T> {
  const VerificationSuccess(this.data, {this.isResending = false});
  

 final  T data;
@JsonKey() final  bool isResending;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationSuccessCopyWith<T, VerificationSuccess<T>> get copyWith => _$VerificationSuccessCopyWithImpl<T, VerificationSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationSuccess<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.isResending, isResending) || other.isResending == isResending));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),isResending);

@override
String toString() {
  return 'VerificationState<$T>.success(data: $data, isResending: $isResending)';
}


}

/// @nodoc
abstract mixin class $VerificationSuccessCopyWith<T,$Res> implements $VerificationStateCopyWith<T, $Res> {
  factory $VerificationSuccessCopyWith(VerificationSuccess<T> value, $Res Function(VerificationSuccess<T>) _then) = _$VerificationSuccessCopyWithImpl;
@useResult
$Res call({
 T data, bool isResending
});




}
/// @nodoc
class _$VerificationSuccessCopyWithImpl<T,$Res>
    implements $VerificationSuccessCopyWith<T, $Res> {
  _$VerificationSuccessCopyWithImpl(this._self, this._then);

  final VerificationSuccess<T> _self;
  final $Res Function(VerificationSuccess<T>) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? isResending = null,}) {
  return _then(VerificationSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class VerificationError<T> implements VerificationState<T> {
  const VerificationError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationErrorCopyWith<T, VerificationError<T>> get copyWith => _$VerificationErrorCopyWithImpl<T, VerificationError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationError<T>&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'VerificationState<$T>.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $VerificationErrorCopyWith<T,$Res> implements $VerificationStateCopyWith<T, $Res> {
  factory $VerificationErrorCopyWith(VerificationError<T> value, $Res Function(VerificationError<T>) _then) = _$VerificationErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$VerificationErrorCopyWithImpl<T,$Res>
    implements $VerificationErrorCopyWith<T, $Res> {
  _$VerificationErrorCopyWithImpl(this._self, this._then);

  final VerificationError<T> _self;
  final $Res Function(VerificationError<T>) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(VerificationError<T>(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
