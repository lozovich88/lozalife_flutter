import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

/// Domain model of a board.
@freezed
abstract class BoardModel with _$BoardModel {
  const factory BoardModel({
    required String id,
    required String name,
    required int color,
    required bool isPinned,
    required int order,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);
}
