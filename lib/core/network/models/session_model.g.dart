// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionModel _$SessionModelFromJson(Map<String, dynamic> json) =>
    _SessionModel(
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      lastUpdateId: (json['lastUpdateId'] as num).toInt(),
    );

Map<String, dynamic> _$SessionModelToJson(_SessionModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'lastUpdateId': instance.lastUpdateId,
    };
