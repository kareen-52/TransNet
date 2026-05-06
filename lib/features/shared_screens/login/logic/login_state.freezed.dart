// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( SuccessClient value)?  successClient,TResult Function( SuccessDriverFirstTime value)?  successDriverFirstTime,TResult Function( SuccessDriverOld value)?  successDriverOld,TResult Function( LoginError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case SuccessClient() when successClient != null:
return successClient(_that);case SuccessDriverFirstTime() when successDriverFirstTime != null:
return successDriverFirstTime(_that);case SuccessDriverOld() when successDriverOld != null:
return successDriverOld(_that);case LoginError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( SuccessClient value)  successClient,required TResult Function( SuccessDriverFirstTime value)  successDriverFirstTime,required TResult Function( SuccessDriverOld value)  successDriverOld,required TResult Function( LoginError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case SuccessClient():
return successClient(_that);case SuccessDriverFirstTime():
return successDriverFirstTime(_that);case SuccessDriverOld():
return successDriverOld(_that);case LoginError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( SuccessClient value)?  successClient,TResult? Function( SuccessDriverFirstTime value)?  successDriverFirstTime,TResult? Function( SuccessDriverOld value)?  successDriverOld,TResult? Function( LoginError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case SuccessClient() when successClient != null:
return successClient(_that);case SuccessDriverFirstTime() when successDriverFirstTime != null:
return successDriverFirstTime(_that);case SuccessDriverOld() when successDriverOld != null:
return successDriverOld(_that);case LoginError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  successClient,TResult Function( String email)?  successDriverFirstTime,TResult Function()?  successDriverOld,TResult Function( ApiErrorModel apiErrorModel)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case SuccessClient() when successClient != null:
return successClient();case SuccessDriverFirstTime() when successDriverFirstTime != null:
return successDriverFirstTime(_that.email);case SuccessDriverOld() when successDriverOld != null:
return successDriverOld();case LoginError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  successClient,required TResult Function( String email)  successDriverFirstTime,required TResult Function()  successDriverOld,required TResult Function( ApiErrorModel apiErrorModel)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case SuccessClient():
return successClient();case SuccessDriverFirstTime():
return successDriverFirstTime(_that.email);case SuccessDriverOld():
return successDriverOld();case LoginError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  successClient,TResult? Function( String email)?  successDriverFirstTime,TResult? Function()?  successDriverOld,TResult? Function( ApiErrorModel apiErrorModel)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case SuccessClient() when successClient != null:
return successClient();case SuccessDriverFirstTime() when successDriverFirstTime != null:
return successDriverFirstTime(_that.email);case SuccessDriverOld() when successDriverOld != null:
return successDriverOld();case LoginError() when error != null:
return error(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LoginState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class Loading implements LoginState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loading()';
}


}




/// @nodoc


class SuccessClient implements LoginState {
  const SuccessClient();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessClient);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.successClient()';
}


}




/// @nodoc


class SuccessDriverFirstTime implements LoginState {
  const SuccessDriverFirstTime(this.email);
  

 final  String email;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessDriverFirstTimeCopyWith<SuccessDriverFirstTime> get copyWith => _$SuccessDriverFirstTimeCopyWithImpl<SuccessDriverFirstTime>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessDriverFirstTime&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'LoginState.successDriverFirstTime(email: $email)';
}


}

/// @nodoc
abstract mixin class $SuccessDriverFirstTimeCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $SuccessDriverFirstTimeCopyWith(SuccessDriverFirstTime value, $Res Function(SuccessDriverFirstTime) _then) = _$SuccessDriverFirstTimeCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$SuccessDriverFirstTimeCopyWithImpl<$Res>
    implements $SuccessDriverFirstTimeCopyWith<$Res> {
  _$SuccessDriverFirstTimeCopyWithImpl(this._self, this._then);

  final SuccessDriverFirstTime _self;
  final $Res Function(SuccessDriverFirstTime) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(SuccessDriverFirstTime(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SuccessDriverOld implements LoginState {
  const SuccessDriverOld();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessDriverOld);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.successDriverOld()';
}


}




/// @nodoc


class LoginError implements LoginState {
  const LoginError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginErrorCopyWith<LoginError> get copyWith => _$LoginErrorCopyWithImpl<LoginError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginError&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'LoginState.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $LoginErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $LoginErrorCopyWith(LoginError value, $Res Function(LoginError) _then) = _$LoginErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$LoginErrorCopyWithImpl<$Res>
    implements $LoginErrorCopyWith<$Res> {
  _$LoginErrorCopyWithImpl(this._self, this._then);

  final LoginError _self;
  final $Res Function(LoginError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(LoginError(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
