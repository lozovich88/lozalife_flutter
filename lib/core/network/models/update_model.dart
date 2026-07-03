import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_model.freezed.dart';
part 'update_model.g.dart';

/// Stage 2: a single incremental change coming from the server,
/// analogous to a Telegram update.
///
/// `operation` examples: TaskCreated, TaskUpdated, TaskDeleted,
/// BoardUpdated, ColumnUpdated.
@freezed
abstract class UpdateModel with _$UpdateModel {
  const factory UpdateModel({
    required int updateId,
    required String entity,
    required String operation,
    required Map<String, dynamic> payload,
  }) = _UpdateModel;

  factory UpdateModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateModelFromJson(json);
}
