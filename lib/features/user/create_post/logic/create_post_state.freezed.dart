// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatePostState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostState()';
}


}

/// @nodoc
class $CreatePostStateCopyWith<$Res>  {
$CreatePostStateCopyWith(CreatePostState _, $Res Function(CreatePostState) __);
}


/// Adds pattern-matching-related methods to [CreatePostState].
extension CreatePostStatePatterns on CreatePostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _GovLoading value)?  govLoading,TResult Function( _GovSuccess value)?  govSuccess,TResult Function( _GovError value)?  govError,TResult Function( _UiUpdated value)?  uiUpdated,TResult Function( _StepOneSuccess value)?  stepOneSuccess,TResult Function( _StepTwoSuccess value)?  stepTwoSuccess,TResult Function( _SubmitError value)?  submitError,TResult Function( _StepTwoLoading value)?  stepTwoLoading,TResult Function( _StepTwoError value)?  stepTwoError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _GovLoading() when govLoading != null:
return govLoading(_that);case _GovSuccess() when govSuccess != null:
return govSuccess(_that);case _GovError() when govError != null:
return govError(_that);case _UiUpdated() when uiUpdated != null:
return uiUpdated(_that);case _StepOneSuccess() when stepOneSuccess != null:
return stepOneSuccess(_that);case _StepTwoSuccess() when stepTwoSuccess != null:
return stepTwoSuccess(_that);case _SubmitError() when submitError != null:
return submitError(_that);case _StepTwoLoading() when stepTwoLoading != null:
return stepTwoLoading(_that);case _StepTwoError() when stepTwoError != null:
return stepTwoError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _GovLoading value)  govLoading,required TResult Function( _GovSuccess value)  govSuccess,required TResult Function( _GovError value)  govError,required TResult Function( _UiUpdated value)  uiUpdated,required TResult Function( _StepOneSuccess value)  stepOneSuccess,required TResult Function( _StepTwoSuccess value)  stepTwoSuccess,required TResult Function( _SubmitError value)  submitError,required TResult Function( _StepTwoLoading value)  stepTwoLoading,required TResult Function( _StepTwoError value)  stepTwoError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _GovLoading():
return govLoading(_that);case _GovSuccess():
return govSuccess(_that);case _GovError():
return govError(_that);case _UiUpdated():
return uiUpdated(_that);case _StepOneSuccess():
return stepOneSuccess(_that);case _StepTwoSuccess():
return stepTwoSuccess(_that);case _SubmitError():
return submitError(_that);case _StepTwoLoading():
return stepTwoLoading(_that);case _StepTwoError():
return stepTwoError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _GovLoading value)?  govLoading,TResult? Function( _GovSuccess value)?  govSuccess,TResult? Function( _GovError value)?  govError,TResult? Function( _UiUpdated value)?  uiUpdated,TResult? Function( _StepOneSuccess value)?  stepOneSuccess,TResult? Function( _StepTwoSuccess value)?  stepTwoSuccess,TResult? Function( _SubmitError value)?  submitError,TResult? Function( _StepTwoLoading value)?  stepTwoLoading,TResult? Function( _StepTwoError value)?  stepTwoError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _GovLoading() when govLoading != null:
return govLoading(_that);case _GovSuccess() when govSuccess != null:
return govSuccess(_that);case _GovError() when govError != null:
return govError(_that);case _UiUpdated() when uiUpdated != null:
return uiUpdated(_that);case _StepOneSuccess() when stepOneSuccess != null:
return stepOneSuccess(_that);case _StepTwoSuccess() when stepTwoSuccess != null:
return stepTwoSuccess(_that);case _SubmitError() when submitError != null:
return submitError(_that);case _StepTwoLoading() when stepTwoLoading != null:
return stepTwoLoading(_that);case _StepTwoError() when stepTwoError != null:
return stepTwoError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  govLoading,TResult Function( List<GovernorateModel> govs)?  govSuccess,TResult Function( ApiErrorModel error)?  govError,TResult Function( int timestamp)?  uiUpdated,TResult Function( PostModel post,  String message)?  stepOneSuccess,TResult Function( String message)?  stepTwoSuccess,TResult Function( ApiErrorModel error)?  submitError,TResult Function()?  stepTwoLoading,TResult Function( ApiErrorModel error)?  stepTwoError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _GovLoading() when govLoading != null:
return govLoading();case _GovSuccess() when govSuccess != null:
return govSuccess(_that.govs);case _GovError() when govError != null:
return govError(_that.error);case _UiUpdated() when uiUpdated != null:
return uiUpdated(_that.timestamp);case _StepOneSuccess() when stepOneSuccess != null:
return stepOneSuccess(_that.post,_that.message);case _StepTwoSuccess() when stepTwoSuccess != null:
return stepTwoSuccess(_that.message);case _SubmitError() when submitError != null:
return submitError(_that.error);case _StepTwoLoading() when stepTwoLoading != null:
return stepTwoLoading();case _StepTwoError() when stepTwoError != null:
return stepTwoError(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  govLoading,required TResult Function( List<GovernorateModel> govs)  govSuccess,required TResult Function( ApiErrorModel error)  govError,required TResult Function( int timestamp)  uiUpdated,required TResult Function( PostModel post,  String message)  stepOneSuccess,required TResult Function( String message)  stepTwoSuccess,required TResult Function( ApiErrorModel error)  submitError,required TResult Function()  stepTwoLoading,required TResult Function( ApiErrorModel error)  stepTwoError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _GovLoading():
return govLoading();case _GovSuccess():
return govSuccess(_that.govs);case _GovError():
return govError(_that.error);case _UiUpdated():
return uiUpdated(_that.timestamp);case _StepOneSuccess():
return stepOneSuccess(_that.post,_that.message);case _StepTwoSuccess():
return stepTwoSuccess(_that.message);case _SubmitError():
return submitError(_that.error);case _StepTwoLoading():
return stepTwoLoading();case _StepTwoError():
return stepTwoError(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  govLoading,TResult? Function( List<GovernorateModel> govs)?  govSuccess,TResult? Function( ApiErrorModel error)?  govError,TResult? Function( int timestamp)?  uiUpdated,TResult? Function( PostModel post,  String message)?  stepOneSuccess,TResult? Function( String message)?  stepTwoSuccess,TResult? Function( ApiErrorModel error)?  submitError,TResult? Function()?  stepTwoLoading,TResult? Function( ApiErrorModel error)?  stepTwoError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _GovLoading() when govLoading != null:
return govLoading();case _GovSuccess() when govSuccess != null:
return govSuccess(_that.govs);case _GovError() when govError != null:
return govError(_that.error);case _UiUpdated() when uiUpdated != null:
return uiUpdated(_that.timestamp);case _StepOneSuccess() when stepOneSuccess != null:
return stepOneSuccess(_that.post,_that.message);case _StepTwoSuccess() when stepTwoSuccess != null:
return stepTwoSuccess(_that.message);case _SubmitError() when submitError != null:
return submitError(_that.error);case _StepTwoLoading() when stepTwoLoading != null:
return stepTwoLoading();case _StepTwoError() when stepTwoError != null:
return stepTwoError(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CreatePostState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostState.initial()';
}


}




/// @nodoc


class _Loading implements CreatePostState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostState.loading()';
}


}




/// @nodoc


class _GovLoading implements CreatePostState {
  const _GovLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GovLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostState.govLoading()';
}


}




/// @nodoc


class _GovSuccess implements CreatePostState {
  const _GovSuccess(final  List<GovernorateModel> govs): _govs = govs;
  

 final  List<GovernorateModel> _govs;
 List<GovernorateModel> get govs {
  if (_govs is EqualUnmodifiableListView) return _govs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_govs);
}


/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GovSuccessCopyWith<_GovSuccess> get copyWith => __$GovSuccessCopyWithImpl<_GovSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GovSuccess&&const DeepCollectionEquality().equals(other._govs, _govs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_govs));

@override
String toString() {
  return 'CreatePostState.govSuccess(govs: $govs)';
}


}

/// @nodoc
abstract mixin class _$GovSuccessCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$GovSuccessCopyWith(_GovSuccess value, $Res Function(_GovSuccess) _then) = __$GovSuccessCopyWithImpl;
@useResult
$Res call({
 List<GovernorateModel> govs
});




}
/// @nodoc
class __$GovSuccessCopyWithImpl<$Res>
    implements _$GovSuccessCopyWith<$Res> {
  __$GovSuccessCopyWithImpl(this._self, this._then);

  final _GovSuccess _self;
  final $Res Function(_GovSuccess) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? govs = null,}) {
  return _then(_GovSuccess(
null == govs ? _self._govs : govs // ignore: cast_nullable_to_non_nullable
as List<GovernorateModel>,
  ));
}


}

/// @nodoc


class _GovError implements CreatePostState {
  const _GovError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GovErrorCopyWith<_GovError> get copyWith => __$GovErrorCopyWithImpl<_GovError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GovError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CreatePostState.govError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$GovErrorCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$GovErrorCopyWith(_GovError value, $Res Function(_GovError) _then) = __$GovErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class __$GovErrorCopyWithImpl<$Res>
    implements _$GovErrorCopyWith<$Res> {
  __$GovErrorCopyWithImpl(this._self, this._then);

  final _GovError _self;
  final $Res Function(_GovError) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_GovError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class _UiUpdated implements CreatePostState {
  const _UiUpdated(this.timestamp);
  

 final  int timestamp;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UiUpdatedCopyWith<_UiUpdated> get copyWith => __$UiUpdatedCopyWithImpl<_UiUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UiUpdated&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp);

@override
String toString() {
  return 'CreatePostState.uiUpdated(timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$UiUpdatedCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$UiUpdatedCopyWith(_UiUpdated value, $Res Function(_UiUpdated) _then) = __$UiUpdatedCopyWithImpl;
@useResult
$Res call({
 int timestamp
});




}
/// @nodoc
class __$UiUpdatedCopyWithImpl<$Res>
    implements _$UiUpdatedCopyWith<$Res> {
  __$UiUpdatedCopyWithImpl(this._self, this._then);

  final _UiUpdated _self;
  final $Res Function(_UiUpdated) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timestamp = null,}) {
  return _then(_UiUpdated(
null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StepOneSuccess implements CreatePostState {
  const _StepOneSuccess(this.post, this.message);
  

 final  PostModel post;
 final  String message;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepOneSuccessCopyWith<_StepOneSuccess> get copyWith => __$StepOneSuccessCopyWithImpl<_StepOneSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepOneSuccess&&(identical(other.post, post) || other.post == post)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,post,message);

@override
String toString() {
  return 'CreatePostState.stepOneSuccess(post: $post, message: $message)';
}


}

/// @nodoc
abstract mixin class _$StepOneSuccessCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$StepOneSuccessCopyWith(_StepOneSuccess value, $Res Function(_StepOneSuccess) _then) = __$StepOneSuccessCopyWithImpl;
@useResult
$Res call({
 PostModel post, String message
});




}
/// @nodoc
class __$StepOneSuccessCopyWithImpl<$Res>
    implements _$StepOneSuccessCopyWith<$Res> {
  __$StepOneSuccessCopyWithImpl(this._self, this._then);

  final _StepOneSuccess _self;
  final $Res Function(_StepOneSuccess) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? post = null,Object? message = null,}) {
  return _then(_StepOneSuccess(
null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostModel,null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _StepTwoSuccess implements CreatePostState {
  const _StepTwoSuccess(this.message);
  

 final  String message;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepTwoSuccessCopyWith<_StepTwoSuccess> get copyWith => __$StepTwoSuccessCopyWithImpl<_StepTwoSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepTwoSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CreatePostState.stepTwoSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$StepTwoSuccessCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$StepTwoSuccessCopyWith(_StepTwoSuccess value, $Res Function(_StepTwoSuccess) _then) = __$StepTwoSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$StepTwoSuccessCopyWithImpl<$Res>
    implements _$StepTwoSuccessCopyWith<$Res> {
  __$StepTwoSuccessCopyWithImpl(this._self, this._then);

  final _StepTwoSuccess _self;
  final $Res Function(_StepTwoSuccess) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_StepTwoSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SubmitError implements CreatePostState {
  const _SubmitError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitErrorCopyWith<_SubmitError> get copyWith => __$SubmitErrorCopyWithImpl<_SubmitError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CreatePostState.submitError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$SubmitErrorCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$SubmitErrorCopyWith(_SubmitError value, $Res Function(_SubmitError) _then) = __$SubmitErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class __$SubmitErrorCopyWithImpl<$Res>
    implements _$SubmitErrorCopyWith<$Res> {
  __$SubmitErrorCopyWithImpl(this._self, this._then);

  final _SubmitError _self;
  final $Res Function(_SubmitError) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_SubmitError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class _StepTwoLoading implements CreatePostState {
  const _StepTwoLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepTwoLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostState.stepTwoLoading()';
}


}




/// @nodoc


class _StepTwoError implements CreatePostState {
  const _StepTwoError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepTwoErrorCopyWith<_StepTwoError> get copyWith => __$StepTwoErrorCopyWithImpl<_StepTwoError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepTwoError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CreatePostState.stepTwoError(error: $error)';
}


}

/// @nodoc
abstract mixin class _$StepTwoErrorCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$StepTwoErrorCopyWith(_StepTwoError value, $Res Function(_StepTwoError) _then) = __$StepTwoErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class __$StepTwoErrorCopyWithImpl<$Res>
    implements _$StepTwoErrorCopyWith<$Res> {
  __$StepTwoErrorCopyWithImpl(this._self, this._then);

  final _StepTwoError _self;
  final $Res Function(_StepTwoError) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_StepTwoError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
