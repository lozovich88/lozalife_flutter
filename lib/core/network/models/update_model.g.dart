// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateModel _$UpdateModelFromJson(Map<String, dynamic> json) => _UpdateModel(
  updateId: (json['updateId'] as num).toInt(),
  entity: json['entity'] as String,
  operation: json['operation'] as String,
  payload: json['payload'] as Map<String, dynamic>,
);

Map<String, dynamic> _$UpdateModelToJson(_UpdateModel instance) =>
    <String, dynamic>{
      'updateId': instance.updateId,
      'entity': instance.entity,
      'operation': instance.operation,
      'payload': instance.payload,
    };
