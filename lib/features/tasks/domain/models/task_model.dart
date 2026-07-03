import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// Domain model of a task.
///
/// `parentTaskId` (subtasks) and `isArchived` (archive) are reserved for
/// Stage 3 and are not surfaced in the MVP UI.
@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String boardId,
    required String columnId,
    required String title,
    String? description,
    DateTime? deadline,
    required int order,
    String? parentTaskId,
    required bool isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
