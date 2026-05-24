// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClientProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse profileResponse) success,
    required TResult Function(String message) editSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse profileResponse)? success,
    TResult? Function(String message)? editSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse profileResponse)? success,
    TResult Function(String message)? editSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EditSuccess value) editSuccess,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EditSuccess value)? editSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EditSuccess value)? editSuccess,
    TResult Function(_Error value)? error,
    required TResult Function(ClientProfileState value) orElse,
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientProfileStateCopyWith<$Res> {
  factory $ClientProfileStateCopyWith(
          ClientProfileState value, $Res Function(ClientProfileState) then) =
      _$ClientProfileStateCopyWithImpl<$Res, ClientProfileState>;
}

/// @nodoc
class _$ClientProfileStateCopyWithImpl<$Res, $Val extends ClientProfileState>
    implements $ClientProfileStateCopyWith<$Res> {
  _$ClientProfileStateCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ClientProfileStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc
class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() => 'ClientProfileState.initial()';
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse profileResponse) success,
    required TResult Function(String message) editSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) =>
      initial();
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse profileResponse)? success,
    TResult? Function(String message)? editSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) =>
      initial?.call();
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse profileResponse)? success,
    TResult Function(String message)? editSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) =>
      initial != null ? initial() : orElse();
  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EditSuccess value) editSuccess,
    required TResult Function(_Error value) error,
  }) =>
      initial(this);
  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EditSuccess value)? editSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      initial?.call(this);
  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EditSuccess value)? editSuccess,
    TResult Function(_Error value)? error,
    required TResult Function(ClientProfileState value) orElse,
  }) =>
      initial != null ? initial(this) : orElse(this);
}

abstract class _Initial implements ClientProfileState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() => 'ClientProfileState.loading()';
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse profileResponse) success,
    required TResult Function(String message) editSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) =>
      loading();
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse profileResponse)? success,
    TResult? Function(String message)? editSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) =>
      loading?.call();
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse profileResponse)? success,
    TResult Function(String message)? editSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) =>
      loading != null ? loading() : orElse();
  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EditSuccess value) editSuccess,
    required TResult Function(_Error value) error,
  }) =>
      loading(this);
  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EditSuccess value)? editSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      loading?.call(this);
  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EditSuccess value)? editSuccess,
    TResult Function(_Error value)? error,
    required TResult Function(ClientProfileState value) orElse,
  }) =>
      loading != null ? loading(this) : orElse(this);
}

abstract class _Loading implements ClientProfileState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProfileResponse profileResponse});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ClientProfileStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profileResponse = null}) {
    return _then(_$SuccessImpl(
      null == profileResponse
          ? _value.profileResponse
          : profileResponse as ProfileResponse,
    ));
  }
}

/// @nodoc
class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.profileResponse);

  @override
  final ProfileResponse profileResponse;

  @override
  String toString() => 'ClientProfileState.success(profileResponse: $profileResponse)';
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.profileResponse, profileResponse) ||
                other.profileResponse == profileResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profileResponse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse profileResponse) success,
    required TResult Function(String message) editSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) =>
      success(profileResponse);
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse profileResponse)? success,
    TResult? Function(String message)? editSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) =>
      success?.call(profileResponse);
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse profileResponse)? success,
    TResult Function(String message)? editSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) =>
      success != null ? success(profileResponse) : orElse();
  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EditSuccess value) editSuccess,
    required TResult Function(_Error value) error,
  }) =>
      success(this);
  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EditSuccess value)? editSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      success?.call(this);
  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EditSuccess value)? editSuccess,
    TResult Function(_Error value)? error,
    required TResult Function(ClientProfileState value) orElse,
  }) =>
      success != null ? success(this) : orElse(this);
}

abstract class _Success implements ClientProfileState {
  const factory _Success(final ProfileResponse profileResponse) = _$SuccessImpl;
  ProfileResponse get profileResponse;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$EditSuccessImpl implements _EditSuccess {
  const _$EditSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() => 'ClientProfileState.editSuccess(message: $message)';
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse profileResponse) success,
    required TResult Function(String message) editSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) =>
      editSuccess(message);
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse profileResponse)? success,
    TResult? Function(String message)? editSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) =>
      editSuccess?.call(message);
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse profileResponse)? success,
    TResult Function(String message)? editSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) =>
      editSuccess != null ? editSuccess(message) : orElse();
  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EditSuccess value) editSuccess,
    required TResult Function(_Error value) error,
  }) =>
      editSuccess(this);
  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EditSuccess value)? editSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      editSuccess?.call(this);
  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EditSuccess value)? editSuccess,
    TResult Function(_Error value)? error,
    required TResult Function(ClientProfileState value) orElse,
  }) =>
      editSuccess != null ? editSuccess(this) : orElse(this);
}

abstract class _EditSuccess implements ClientProfileState {
  const factory _EditSuccess(final String message) = _$EditSuccessImpl;
  String get message;
}

/// @nodoc
class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() => 'ClientProfileState.error(apiErrorModel: $apiErrorModel)';
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse profileResponse) success,
    required TResult Function(String message) editSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) =>
      error(apiErrorModel);
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse profileResponse)? success,
    TResult? Function(String message)? editSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) =>
      error?.call(apiErrorModel);
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse profileResponse)? success,
    TResult Function(String message)? editSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) =>
      error != null ? error(apiErrorModel) : orElse();
  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EditSuccess value) editSuccess,
    required TResult Function(_Error value) error,
  }) =>
      error(this);
  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EditSuccess value)? editSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      error?.call(this);
  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EditSuccess value)? editSuccess,
    TResult Function(_Error value)? error,
    required TResult Function(ClientProfileState value) orElse,
  }) =>
      error != null ? error(this) : orElse(this);
}

abstract class _Error implements ClientProfileState {
  const factory _Error(final ApiErrorModel apiErrorModel) = _$ErrorImpl;
  ApiErrorModel get apiErrorModel;
}
