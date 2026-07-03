import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

/// Stage 2: authorized user session returned by the server after login.
@freezed
abstract class SessionModel with _$SessionModel {
  const factory SessionModel({
    required String sessionId,
    required String userId,
    required int lastUpdateId,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}
