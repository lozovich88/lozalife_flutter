import 'package:freezed_annotation/freezed_annotation.dart';

part 'column_model.freezed.dart';
part 'column_model.g.dart';

/// Domain model of a board column.
@freezed
abstract class ColumnModel with _$ColumnModel {
  const factory ColumnModel({
    required String id,
    required String boardId,
    required String name,
    required int order,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _ColumnModel;

  factory ColumnModel.fromJson(Map<String, dynamic> json) =>
      _$ColumnModelFromJson(json);
}
