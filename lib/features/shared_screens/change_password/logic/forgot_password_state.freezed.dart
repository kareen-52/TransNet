// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState _, $Res Function(ForgotPasswordState) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( SendEmailSuccess value)?  sendEmailSuccess,TResult Function( VerifyCodeSuccess value)?  verifyCodeSuccess,TResult Function( ResetPasswordSuccess value)?  resetPasswordSuccess,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case SendEmailSuccess() when sendEmailSuccess != null:
return sendEmailSuccess(_that);case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( SendEmailSuccess value)  sendEmailSuccess,required TResult Function( VerifyCodeSuccess value)  verifyCodeSuccess,required TResult Function( ResetPasswordSuccess value)  resetPasswordSuccess,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case SendEmailSuccess():
return sendEmailSuccess(_that);case VerifyCodeSuccess():
return verifyCodeSuccess(_that);case ResetPasswordSuccess():
return resetPasswordSuccess(_that);case Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( SendEmailSuccess value)?  sendEmailSuccess,TResult? Function( VerifyCodeSuccess value)?  verifyCodeSuccess,TResult? Function( ResetPasswordSuccess value)?  resetPasswordSuccess,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case SendEmailSuccess() when sendEmailSuccess != null:
return sendEmailSuccess(_that);case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ForgotPasswordResponse data)?  sendEmailSuccess,TResult Function( ForgotPasswordResponse data)?  verifyCodeSuccess,TResult Function( ForgotPasswordResponse data)?  resetPasswordSuccess,TResult Function( ApiErrorModel apiErrorModel)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case SendEmailSuccess() when sendEmailSuccess != null:
return sendEmailSuccess(_that.data);case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that.data);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.data);case Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ForgotPasswordResponse data)  sendEmailSuccess,required TResult Function( ForgotPasswordResponse data)  verifyCodeSuccess,required TResult Function( ForgotPasswordResponse data)  resetPasswordSuccess,required TResult Function( ApiErrorModel apiErrorModel)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case SendEmailSuccess():
return sendEmailSuccess(_that.data);case VerifyCodeSuccess():
return verifyCodeSuccess(_that.data);case ResetPasswordSuccess():
return resetPasswordSuccess(_that.data);case Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ForgotPasswordResponse data)?  sendEmailSuccess,TResult? Function( ForgotPasswordResponse data)?  verifyCodeSuccess,TResult? Function( ForgotPasswordResponse data)?  resetPasswordSuccess,TResult? Function( ApiErrorModel apiErrorModel)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case SendEmailSuccess() when sendEmailSuccess != null:
return sendEmailSuccess(_that.data);case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that.data);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.data);case Error() when error != null:
return error(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ForgotPasswordState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.initial()';
}


}




/// @nodoc


class Loading implements ForgotPasswordState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.loading()';
}


}




/// @nodoc


class SendEmailSuccess implements ForgotPasswordState {
  const SendEmailSuccess(this.data);
  

 final  ForgotPasswordResponse data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendEmailSuccessCopyWith<SendEmailSuccess> get copyWith => _$SendEmailSuccessCopyWithImpl<SendEmailSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendEmailSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ForgotPasswordState.sendEmailSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $SendEmailSuccessCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $SendEmailSuccessCopyWith(SendEmailSuccess value, $Res Function(SendEmailSuccess) _then) = _$SendEmailSuccessCopyWithImpl;
@useResult
$Res call({
 ForgotPasswordResponse data
});




}
/// @nodoc
class _$SendEmailSuccessCopyWithImpl<$Res>
    implements $SendEmailSuccessCopyWith<$Res> {
  _$SendEmailSuccessCopyWithImpl(this._self, this._then);

  final SendEmailSuccess _self;
  final $Res Function(SendEmailSuccess) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(SendEmailSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ForgotPasswordResponse,
  ));
}


}

/// @nodoc


class VerifyCodeSuccess implements ForgotPasswordState {
  const VerifyCodeSuccess(this.data);
  

 final  ForgotPasswordResponse data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyCodeSuccessCopyWith<VerifyCodeSuccess> get copyWith => _$VerifyCodeSuccessCopyWithImpl<VerifyCodeSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ForgotPasswordState.verifyCodeSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $VerifyCodeSuccessCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $VerifyCodeSuccessCopyWith(VerifyCodeSuccess value, $Res Function(VerifyCodeSuccess) _then) = _$VerifyCodeSuccessCopyWithImpl;
@useResult
$Res call({
 ForgotPasswordResponse data
});




}
/// @nodoc
class _$VerifyCodeSuccessCopyWithImpl<$Res>
    implements $VerifyCodeSuccessCopyWith<$Res> {
  _$VerifyCodeSuccessCopyWithImpl(this._self, this._then);

  final VerifyCodeSuccess _self;
  final $Res Function(VerifyCodeSuccess) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(VerifyCodeSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ForgotPasswordResponse,
  ));
}


}

/// @nodoc


class ResetPasswordSuccess implements ForgotPasswordState {
  const ResetPasswordSuccess(this.data);
  

 final  ForgotPasswordResponse data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordSuccessCopyWith<ResetPasswordSuccess> get copyWith => _$ResetPasswordSuccessCopyWithImpl<ResetPasswordSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ForgotPasswordState.resetPasswordSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordSuccessCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ResetPasswordSuccessCopyWith(ResetPasswordSuccess value, $Res Function(ResetPasswordSuccess) _then) = _$ResetPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 ForgotPasswordResponse data
});




}
/// @nodoc
class _$ResetPasswordSuccessCopyWithImpl<$Res>
    implements $ResetPasswordSuccessCopyWith<$Res> {
  _$ResetPasswordSuccessCopyWithImpl(this._self, this._then);

  final ResetPasswordSuccess _self;
  final $Res Function(ResetPasswordSuccess) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ResetPasswordSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ForgotPasswordResponse,
  ));
}


}

/// @nodoc


class Error implements ForgotPasswordState {
  const Error(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of ForgotPasswordState
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
  return 'ForgotPasswordState.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
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

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(Error(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
