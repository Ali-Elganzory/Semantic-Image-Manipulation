import '/third_party/third_party.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskType {
  detection,
  inpainting,
  editing,
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
    required int imageId,
    required TaskType type,
    required TaskStatus status,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

extension TaskTypeString on TaskType {
  String get string {
    switch (this) {
      case TaskType.detection:
        return 'Detection';
      case TaskType.inpainting:
        return 'Inpainting';
      case TaskType.editing:
        return 'Dream';
    }
  }
}

extension TaskStatusString on TaskStatus {
  String get string {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.running:
        return 'Running';
      case TaskStatus.success:
        return 'Completed';
      case TaskStatus.error:
        return 'Error';
    }
  }
}
