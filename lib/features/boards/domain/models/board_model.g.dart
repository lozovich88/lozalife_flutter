// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => _BoardModel(
  id: json['id'] as String,
  name: json['name'] as String,
  color: (json['color'] as num).toInt(),
  isPinned: json['isPinned'] as bool,
  order: (json['order'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$BoardModelToJson(_BoardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'isPinned': instance.isPinned,
      'order': instance.order,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
