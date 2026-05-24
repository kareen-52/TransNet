// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_shipments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not allowed to use it as is, and will likely throw. Please check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClientShipmentsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShipmentModel> shipments, bool hasReachedMax) success,
    required TResult Function() empty,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult? Function()? empty,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult Function()? empty,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientShipmentsStateCopyWith<$Res> {}

/// @nodoc
class _$ClientShipmentsStateCopyWithImpl<$Res, $Val extends ClientShipmentsState>
    implements $ClientShipmentsStateCopyWith<$Res> {
  _$ClientShipmentsStateCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ClientShipmentsStateCopyWith<$Res> {}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ClientShipmentsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(_$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc
class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() => 'ClientShipmentsState.initial()';

  @override
  bool operator ==(Object other) => identical(this, other) || other is _$InitialImpl;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShipmentModel> shipments, bool hasReachedMax) success,
    required TResult Function() empty,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) => initial();

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult? Function()? empty,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) => initial?.call();

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult Function()? empty,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) => initial != null ? initial() : orElse();
}

abstract class _Initial implements ClientShipmentsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
class _$LoadingImpl implements Loading {
  const _$LoadingImpl();
  @override
  String toString() => 'ClientShipmentsState.loading()';
  @override
  bool operator ==(Object other) => identical(this, other) || other is _$LoadingImpl;
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShipmentModel> shipments, bool hasReachedMax) success,
    required TResult Function() empty,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) => loading();
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult? Function()? empty,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) => loading?.call();
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult Function()? empty,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) => loading != null ? loading() : orElse();
}

abstract class Loading implements ClientShipmentsState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
class _$SuccessImpl implements Success {
  const _$SuccessImpl(this.shipments, this.hasReachedMax);
  @override
  final List<ShipmentModel> shipments;
  @override
  final bool hasReachedMax;
  @override
  String toString() => 'ClientShipmentsState.success(shipments: $shipments, hasReachedMax: $hasReachedMax)';
  @override
  bool operator ==(Object other) => identical(this, other) || (other is _$SuccessImpl && other.shipments == shipments && other.hasReachedMax == hasReachedMax);
  @override
  int get hashCode => Object.hash(runtimeType, shipments, hasReachedMax);
  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShipmentModel> shipments, bool hasReachedMax) success,
    required TResult Function() empty,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) => success(shipments, hasReachedMax);
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult? Function()? empty,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) => success?.call(shipments, hasReachedMax);
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult Function()? empty,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) => success != null ? success(shipments, hasReachedMax) : orElse();
}

abstract class Success implements ClientShipmentsState {
  const factory Success(final List<ShipmentModel> shipments, final bool hasReachedMax) = _$SuccessImpl;
  List<ShipmentModel> get shipments;
  bool get hasReachedMax;
}

/// @nodoc
class _$EmptyImpl implements Empty {
  const _$EmptyImpl();
  @override
  String toString() => 'ClientShipmentsState.empty()';
  @override
  bool operator ==(Object other) => identical(this, other) || other is _$EmptyImpl;
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShipmentModel> shipments, bool hasReachedMax) success,
    required TResult Function() empty,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) => empty();
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult? Function()? empty,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) => empty?.call();
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult Function()? empty,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) => empty != null ? empty() : orElse();
}

abstract class Empty implements ClientShipmentsState {
  const factory Empty() = _$EmptyImpl;
}

/// @nodoc
class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.apiErrorModel);
  @override
  final ApiErrorModel apiErrorModel;
  @override
  String toString() => 'ClientShipmentsState.error(apiErrorModel: $apiErrorModel)';
  @override
  bool operator ==(Object other) => identical(this, other) || (other is _$ErrorImpl && other.apiErrorModel == apiErrorModel);
  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);
  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShipmentModel> shipments, bool hasReachedMax) success,
    required TResult Function() empty,
    required TResult Function(ApiErrorModel apiErrorModel) error,
  }) => error(apiErrorModel);
  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult? Function()? empty,
    TResult? Function(ApiErrorModel apiErrorModel)? error,
  }) => error?.call(apiErrorModel);
  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShipmentModel> shipments, bool hasReachedMax)? success,
    TResult Function()? empty,
    TResult Function(ApiErrorModel apiErrorModel)? error,
    required TResult Function() orElse,
  }) => error != null ? error(apiErrorModel) : orElse();
}

abstract class Error implements ClientShipmentsState {
  const factory Error(final ApiErrorModel apiErrorModel) = _$ErrorImpl;
  ApiErrorModel get apiErrorModel;
}
