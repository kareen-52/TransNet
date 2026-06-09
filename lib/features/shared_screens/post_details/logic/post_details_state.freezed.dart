// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PostDetailsState()';
}


}

/// @nodoc
class $PostDetailsStateCopyWith<$Res>  {
$PostDetailsStateCopyWith(PostDetailsState _, $Res Function(PostDetailsState) __);
}


/// Adds pattern-matching-related methods to [PostDetailsState].
extension PostDetailsStatePatterns on PostDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,TResult Function( _AcceptLoading value)?  acceptLoading,TResult Function( _AcceptSuccess value)?  acceptSuccess,TResult Function( _AcceptError value)?  acceptError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _AcceptLoading() when acceptLoading != null:
return acceptLoading(_that);case _AcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that);case _AcceptError() when acceptError != null:
return acceptError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,required TResult Function( _AcceptLoading value)  acceptLoading,required TResult Function( _AcceptSuccess value)  acceptSuccess,required TResult Function( _AcceptError value)  acceptError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _AcceptLoading():
return acceptLoading(_that);case _AcceptSuccess():
return acceptSuccess(_that);case _AcceptError():
return acceptError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,TResult? Function( _AcceptLoading value)?  acceptLoading,TResult? Function( _AcceptSuccess value)?  acceptSuccess,TResult? Function( _AcceptError value)?  acceptError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _AcceptLoading() when acceptLoading != null:
return acceptLoading(_that);case _AcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that);case _AcceptError() when acceptError != null:
return acceptError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PostDetailsModel data)?  success,TResult Function( ApiErrorModel error)?  error,TResult Function( int driverId)?  acceptLoading,TResult Function( String message)?  acceptSuccess,TResult Function( ApiErrorModel error)?  acceptError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.data);case _Error() when error != null:
return error(_that.error);case _AcceptLoading() when acceptLoading != null:
return acceptLoading(_that.driverId);case _AcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that.message);case _AcceptError() when acceptError != null:
return acceptError(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PostDetailsModel data)  success,required TResult Function( ApiErrorModel error)  error,required TResult Function( int driverId)  acceptLoading,required TResult Function( String message)  acceptSuccess,required TResult Function( ApiErrorModel error)  acceptError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.data);case _Error():
return error(_that.error);case _AcceptLoading():
return acceptLoading(_that.driverId);case _AcceptSuccess():
return acceptSuccess(_that.message);case _AcceptError():
return acceptError(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PostDetailsModel data)?  success,TResult? Function( ApiErrorModel error)?  error,TResult? Function( int driverId)?  acceptLoading,TResult? Function( String message)?  acceptSuccess,TResult? Function( ApiErrorModel error)?  acceptError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.data);case _Error() when error != null:
return error(_that.error);case _AcceptLoading() when acceptLoading != null:
return acceptLoading(_that.driverId);case _AcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that.message);case _AcceptError() when acceptError != null:
return acceptError(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PostDetailsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PostDetailsState.initial()';
}


}




/// @nodoc


class _Loading implements PostDetailsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PostDetailsState.loading()';
}


}




/// @nodoc


class _Success implements PostDetailsState {
  const _Success(this.data);
  

 final  PostDetailsModel data;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PostDetailsState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $PostDetailsStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 PostDetailsModel data
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Success(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PostDetailsModel,
  ));
}


}

/// @nodoc


class _Error implements PostDetailsState {
  const _Error(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'PostDetailsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PostDetailsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class _AcceptLoading implements PostDetailsState {
  const _AcceptLoading(this.driverId);
  

 final  int driverId;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptLoadingCopyWith<_AcceptLoading> get copyWith => __$AcceptLoadingCopyWithImpl<_AcceptLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptLoading&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,driverId);

@override
String toString() {
  return 'PostDetailsState.acceptLoading(driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class _$AcceptLoadingCopyWith<$Res> implements $PostDetailsStateCopyWith<$Res> {
  factory _$AcceptLoadingCopyWith(_AcceptLoading value, $Res Function(_AcceptLoading) _then) = __$AcceptLoadingCopyWithImpl;
@useResult
$Res call({
 int driverId
});




}
/// @nodoc
class __$AcceptLoadingCopyWithImpl<$Res>
    implements _$AcceptLoadingCopyWith<$Res> {
  __$AcceptLoadingCopyWithImpl(this._self, this._then);

  final _AcceptLoading _self;
  final $Res Function(_AcceptLoading) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,}) {
  return _then(_AcceptLoading(
null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AcceptSuccess implements PostDetailsState {
  const _AcceptSuccess(this.message);
  

 final  String message;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptSuccessCopyWith<_AcceptSuccess> get copyWith => __$AcceptSuccessCopyWithImpl<_AcceptSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PostDetailsState.acceptSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$AcceptSuccessCopyWith<$Res> implements $PostDetailsStateCopyWith<$Res> {
  factory _$AcceptSuccessCopyWith(_AcceptSuccess value, $Res Function(_AcceptSuccess) _then) = __$AcceptSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$AcceptSuccessCopyWithImpl<$Res>
    implements _$AcceptSuccessCopyWith<$Res> {
  __$AcceptSuccessCopyWithImpl(this._self, this._then);

  final _AcceptSuccess _self;
  final $Res Function(_AcceptSuccess) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_AcceptSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AcceptError implements PostDetailsState {
  const _AcceptError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptErrorCopyWith<_AcceptError> get copyWith => __$AcceptErrorCopyWithImpl<_AcceptError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'PostDetailsState.acceptError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$AcceptErrorCopyWith<$Res> implements $PostDetailsStateCopyWith<$Res> {
  factory _$AcceptErrorCopyWith(_AcceptError value, $Res Function(_AcceptError) _then) = __$AcceptErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class __$AcceptErrorCopyWithImpl<$Res>
    implements _$AcceptErrorCopyWith<$Res> {
  __$AcceptErrorCopyWithImpl(this._self, this._then);

  final _AcceptError _self;
  final $Res Function(_AcceptError) _then;

/// Create a copy of PostDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_AcceptError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
