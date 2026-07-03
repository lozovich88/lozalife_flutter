// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'column_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColumnModel {

 String get id; String get boardId; String get name; int get order; DateTime get createdAt; DateTime get updatedAt; DateTime? get deletedAt;
/// Create a copy of ColumnModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColumnModelCopyWith<ColumnModel> get copyWith => _$ColumnModelCopyWithImpl<ColumnModel>(this as ColumnModel, _$identity);

  /// Serializes this ColumnModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColumnModel&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,boardId,name,order,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'ColumnModel(id: $id, boardId: $boardId, name: $name, order: $order, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $ColumnModelCopyWith<$Res>  {
  factory $ColumnModelCopyWith(ColumnModel value, $Res Function(ColumnModel) _then) = _$ColumnModelCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String name, int order, DateTime createdAt, DateTime updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class _$ColumnModelCopyWithImpl<$Res>
    implements $ColumnModelCopyWith<$Res> {
  _$ColumnModelCopyWithImpl(this._self, this._then);

  final ColumnModel _self;
  final $Res Function(ColumnModel) _then;

/// Create a copy of ColumnModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? name = null,Object? order = null,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ColumnModel].
extension ColumnModelPatterns on ColumnModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColumnModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColumnModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColumnModel value)  $default,){
final _that = this;
switch (_that) {
case _ColumnModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColumnModel value)?  $default,){
final _that = this;
switch (_that) {
case _ColumnModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String name,  int order,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColumnModel() when $default != null:
return $default(_that.id,_that.boardId,_that.name,_that.order,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String name,  int order,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _ColumnModel():
return $default(_that.id,_that.boardId,_that.name,_that.order,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String name,  int order,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _ColumnModel() when $default != null:
return $default(_that.id,_that.boardId,_that.name,_that.order,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ColumnModel implements ColumnModel {
  const _ColumnModel({required this.id, required this.boardId, required this.name, required this.order, required this.createdAt, required this.updatedAt, this.deletedAt});
  factory _ColumnModel.fromJson(Map<String, dynamic> json) => _$ColumnModelFromJson(json);

@override final  String id;
@override final  String boardId;
@override final  String name;
@override final  int order;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? deletedAt;

/// Create a copy of ColumnModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColumnModelCopyWith<_ColumnModel> get copyWith => __$ColumnModelCopyWithImpl<_ColumnModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ColumnModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColumnModel&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,boardId,name,order,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'ColumnModel(id: $id, boardId: $boardId, name: $name, order: $order, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$ColumnModelCopyWith<$Res> implements $ColumnModelCopyWith<$Res> {
  factory _$ColumnModelCopyWith(_ColumnModel value, $Res Function(_ColumnModel) _then) = __$ColumnModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String name, int order, DateTime createdAt, DateTime updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class __$ColumnModelCopyWithImpl<$Res>
    implements _$ColumnModelCopyWith<$Res> {
  __$ColumnModelCopyWithImpl(this._self, this._then);

  final _ColumnModel _self;
  final $Res Function(_ColumnModel) _then;

/// Create a copy of ColumnModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? name = null,Object? order = null,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,}) {
  return _then(_ColumnModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
