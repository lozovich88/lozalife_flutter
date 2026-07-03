// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: json['id'] as String,
  boardId: json['boardId'] as String,
  columnId: json['columnId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  deadline: json['deadline'] == null
      ? null
      : DateTime.parse(json['deadline'] as String),
  order: (json['order'] as num).toInt(),
  parentTaskId: json['parentTaskId'] as String?,
  isArchived: json['isArchived'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardId': instance.boardId,
      'columnId': instance.columnId,
      'title': instance.title,
      'description': instance.description,
      'deadline': instance.deadline?.toIso8601String(),
      'order': instance.order,
      'parentTaskId': instance.parentTaskId,
      'isArchived': instance.isArchived,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
