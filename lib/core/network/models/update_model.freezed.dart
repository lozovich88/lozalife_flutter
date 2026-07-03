// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateModel {

 int get updateId; String get entity; String get operation; Map<String, dynamic> get payload;
/// Create a copy of UpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateModelCopyWith<UpdateModel> get copyWith => _$UpdateModelCopyWithImpl<UpdateModel>(this as UpdateModel, _$identity);

  /// Serializes this UpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateModel&&(identical(other.updateId, updateId) || other.updateId == updateId)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.operation, operation) || other.operation == operation)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updateId,entity,operation,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'UpdateModel(updateId: $updateId, entity: $entity, operation: $operation, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $UpdateModelCopyWith<$Res>  {
  factory $UpdateModelCopyWith(UpdateModel value, $Res Function(UpdateModel) _then) = _$UpdateModelCopyWithImpl;
@useResult
$Res call({
 int updateId, String entity, String operation, Map<String, dynamic> payload
});




}
/// @nodoc
class _$UpdateModelCopyWithImpl<$Res>
    implements $UpdateModelCopyWith<$Res> {
  _$UpdateModelCopyWithImpl(this._self, this._then);

  final UpdateModel _self;
  final $Res Function(UpdateModel) _then;

/// Create a copy of UpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? updateId = null,Object? entity = null,Object? operation = null,Object? payload = null,}) {
  return _then(_self.copyWith(
updateId: null == updateId ? _self.updateId : updateId // ignore: cast_nullable_to_non_nullable
as int,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateModel].
extension UpdateModelPatterns on UpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _UpdateModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int updateId,  String entity,  String operation,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateModel() when $default != null:
return $default(_that.updateId,_that.entity,_that.operation,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int updateId,  String entity,  String operation,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _UpdateModel():
return $default(_that.updateId,_that.entity,_that.operation,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int updateId,  String entity,  String operation,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _UpdateModel() when $default != null:
return $default(_that.updateId,_that.entity,_that.operation,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateModel implements UpdateModel {
  const _UpdateModel({required this.updateId, required this.entity, required this.operation, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _UpdateModel.fromJson(Map<String, dynamic> json) => _$UpdateModelFromJson(json);

@override final  int updateId;
@override final  String entity;
@override final  String operation;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of UpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateModelCopyWith<_UpdateModel> get copyWith => __$UpdateModelCopyWithImpl<_UpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateModel&&(identical(other.updateId, updateId) || other.updateId == updateId)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.operation, operation) || other.operation == operation)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updateId,entity,operation,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'UpdateModel(updateId: $updateId, entity: $entity, operation: $operation, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$UpdateModelCopyWith<$Res> implements $UpdateModelCopyWith<$Res> {
  factory _$UpdateModelCopyWith(_UpdateModel value, $Res Function(_UpdateModel) _then) = __$UpdateModelCopyWithImpl;
@override @useResult
$Res call({
 int updateId, String entity, String operation, Map<String, dynamic> payload
});




}
/// @nodoc
class __$UpdateModelCopyWithImpl<$Res>
    implements _$UpdateModelCopyWith<$Res> {
  __$UpdateModelCopyWithImpl(this._self, this._then);

  final _UpdateModel _self;
  final $Res Function(_UpdateModel) _then;

/// Create a copy of UpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? updateId = null,Object? entity = null,Object? operation = null,Object? payload = null,}) {
  return _then(_UpdateModel(
updateId: null == updateId ? _self.updateId : updateId // ignore: cast_nullable_to_non_nullable
as int,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
