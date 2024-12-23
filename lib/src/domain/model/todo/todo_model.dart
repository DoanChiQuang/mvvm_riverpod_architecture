import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    String? id,
    required String uid,
    required String title,
    required String description,
    required bool status,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, Object?> json) =>
      _$TodoModelFromJson(json);
}
