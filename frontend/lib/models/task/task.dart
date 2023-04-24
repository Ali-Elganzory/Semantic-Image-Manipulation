import '/third_party/third_party.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskType {
  detection,
  classification,
}

enum TaskStatus {
  pending,
  running,
  success,
  error,
}

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required int id,
    required TaskType type,
    required TaskStatus status,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}