// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {

 String get id; String get boardId; String get columnId; String get title; String? get description; DateTime? get deadline; int get order; String? get parentTaskId; bool get isArchived; DateTime get createdAt; DateTime get updatedAt; DateTime? get deletedAt;
/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskModelCopyWith<TaskModel> get copyWith => _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.columnId, columnId) || other.columnId == columnId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.order, order) || other.order == order)&&(identical(other.parentTaskId, parentTaskId) || other.parentTaskId == parentTaskId)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,boardId,columnId,title,description,deadline,order,parentTaskId,isArchived,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'TaskModel(id: $id, boardId: $boardId, columnId: $columnId, title: $title, description: $description, deadline: $deadline, order: $order, parentTaskId: $parentTaskId, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res>  {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) = _$TaskModelCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String columnId, String title, String? description, DateTime? deadline, int order, String? parentTaskId, bool isArchived, DateTime createdAt, DateTime updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class _$TaskModelCopyWithImpl<$Res>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? columnId = null,Object? title = null,Object? description = freezed,Object? deadline = freezed,Object? order = null,Object? parentTaskId = freezed,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,columnId: null == columnId ? _self.columnId : columnId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,parentTaskId: freezed == parentTaskId ? _self.parentTaskId : parentTaskId // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskModel].
extension TaskModelPatterns on TaskModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String columnId,  String title,  String? description,  DateTime? deadline,  int order,  String? parentTaskId,  bool isArchived,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.boardId,_that.columnId,_that.title,_that.description,_that.deadline,_that.order,_that.parentTaskId,_that.isArchived,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String columnId,  String title,  String? description,  DateTime? deadline,  int order,  String? parentTaskId,  bool isArchived,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that.id,_that.boardId,_that.columnId,_that.title,_that.description,_that.deadline,_that.order,_that.parentTaskId,_that.isArchived,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String columnId,  String title,  String? description,  DateTime? deadline,  int order,  String? parentTaskId,  bool isArchived,  DateTime createdAt,  DateTime updatedAt,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.boardId,_that.columnId,_that.title,_that.description,_that.deadline,_that.order,_that.parentTaskId,_that.isArchived,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskModel implements TaskModel {
  const _TaskModel({required this.id, required this.boardId, required this.columnId, required this.title, this.description, this.deadline, required this.order, this.parentTaskId, required this.isArchived, required this.createdAt, required this.updatedAt, this.deletedAt});
  factory _TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

@override final  String id;
@override final  String boardId;
@override final  String columnId;
@override final  String title;
@override final  String? description;
@override final  DateTime? deadline;
@override final  int order;
@override final  String? parentTaskId;
@override final  bool isArchived;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? deletedAt;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskModelCopyWith<_TaskModel> get copyWith => __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.columnId, columnId) || other.columnId == columnId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.order, order) || other.order == order)&&(identical(other.parentTaskId, parentTaskId) || other.parentTaskId == parentTaskId)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,boardId,columnId,title,description,deadline,order,parentTaskId,isArchived,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'TaskModel(id: $id, boardId: $boardId, columnId: $columnId, title: $title, description: $description, deadline: $deadline, order: $order, parentTaskId: $parentTaskId, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(_TaskModel value, $Res Function(_TaskModel) _then) = __$TaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String columnId, String title, String? description, DateTime? deadline, int order, String? parentTaskId, bool isArchived, DateTime createdAt, DateTime updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class __$TaskModelCopyWithImpl<$Res>
    implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? columnId = null,Object? title = null,Object? description = freezed,Object? deadline = freezed,Object? order = null,Object? parentTaskId = freezed,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = null,Object? deletedAt = freezed,}) {
  return _then(_TaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,columnId: null == columnId ? _self.columnId : columnId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,parentTaskId: freezed == parentTaskId ? _self.parentTaskId : parentTaskId // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
