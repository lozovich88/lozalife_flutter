// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'column_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColumnModel _$ColumnModelFromJson(Map<String, dynamic> json) => _ColumnModel(
  id: json['id'] as String,
  boardId: json['boardId'] as String,
  name: json['name'] as String,
  order: (json['order'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ColumnModelToJson(_ColumnModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardId': instance.boardId,
      'name': instance.name,
      'order': instance.order,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
