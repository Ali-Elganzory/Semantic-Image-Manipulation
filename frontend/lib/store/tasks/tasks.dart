import 'package:frontend/repository/contracts/repository_response.dart';

import '/util/util.dart';
import '/store/store.dart';
import '/models/models.dart';
import '/constants/constants.dart';
import '/repository/repository.dart';
import '/third_party/third_party.dart';

part 'tasks.freezed.dart';
part 'tasks.g.dart';

@freezed
class TasksState with _$TasksState {
  const TasksState._();

  const factory TasksState({
    required List<TaskModel> tasks,
    required bool isLoading,
  }) = _TasksState;

  factory TasksState.initial() => const TasksState(
        tasks: [],
        isLoading: false,
      );
}

@Riverpod(keepAlive: true)
class Tasks extends _$Tasks {
  final repository = ApiRepository();

  @override
  TasksState build() => TasksState.initial();

  static const _unfinishedStatuses = [
    TaskStatus.pending,
    TaskStatus.running,
  ];

  static const _pollingInterval = Duration(seconds: 1);

  Future<void> detect() async {
    final imageId = ref.read(imagesProvider).selected.id;
    final labelIds =
        ref.read(detectionsProvider).selectedLabels.map((e) => e.id).toList();

    final taskFuture = repository.detect(
      imageId,
      labelIds,
    );

    _handleNewTask(TaskType.detection, taskFuture);
  }

  Future<void> inpaint() async {
    final imageId = ref.read(imagesProvider).selected.id;
    final detectionIds = ref
        .read(detectionsProvider)
        .selectedDetections
        .map((e) => e.id)
        .toList();

    final taskFuture = repository.inpaint(
      imageId,
      detectionIds,
    );

    _handleNewTask(TaskType.inpainting, taskFuture);
  }

  Future<void> edit(String prompt) async {
    final imageId = ref.read(imagesProvider).selected.id;

    final taskFuture = repository.edit(
      imageId,
      prompt,
    );

    _handleNewTask(TaskType.editing, taskFuture);
  }

  Future<void> _handleNewTask(
    TaskType type,
    RepositoryResponse<TaskModel> taskFuture,
  ) async {
    final imageId = ref.read(imagesProvider).selected.id;

    // Optimistically add a task to the list
    final task = TaskModel(
      id: Empty.INT,
      imageId: imageId,
      type: type,
      status: TaskStatus.pending,
    );
    state = state.copyWith(
      tasks: [
        ...state.tasks.where((e) => e.type != type),
        task,
      ],
    );

    // Send request
    final response = await taskFuture;
    response.fold(
      (failure) {
        _failed('Failed to dream');
        state = state.copyWith(
          tasks: [...state.tasks.where((t) => t.id != task.id)],
        );
      },
      (successfulResponse) {
        state = state.copyWith(
          tasks: [
            ...state.tasks.where((t) => t.id != task.id),
            successfulResponse.data,
          ],
        );
        _pollTask(successfulResponse.data.id);
      },
    );
  }

  Future<void> getTasks(int imageId) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final response = await repository.getTasks(imageId);

    response.fold(
      (failure) {
        _failed('Failed to load tasks');
        state = state.copyWith(
          isLoading: false,
        );
      },
      (successfulResponse) {
        state = state.copyWith(
          isLoading: false,
          tasks: [...successfulResponse.data],
        );

        for (final task in successfulResponse.data) {
          if (_unfinishedStatuses.contains(task.status)) {
            _pollTask(task.id);
          } else {
            _getTaskResult(task);
          }
        }
      },
    );
  }

  Future<void> _pollTask(int taskId) async {
    await Future.delayed(_pollingInterval);
    final response = await repository.getTask(taskId);

    response.fold(
      (failure) {
        _failed('Failed to load task');
        return;
      },
      (successfulResponse) {
        final task = successfulResponse.data;
        // Update state
        state = state.copyWith(
          tasks: [
            ...state.tasks.where((t) => t.id != task.id),
            task,
          ],
        );

        // Stop polling if task is finished
        if (!_unfinishedStatuses.contains(task.status)) {
          _success('${task.type.string} is finished');
          _getTaskResult(task);
          return;
        }

        // Poll again
        _pollTask(task.id);
      },
    );
  }

  void _getTaskResult(TaskModel task) {
    if (task.status == TaskStatus.success) {
      if (task.type == TaskType.detection) {
        ref.read(detectionsProvider.notifier).getDetections(task.id);
      } else if (task.type == TaskType.editing) {
        ref.read(modifiedImagesProvider.notifier).getEditingImages(task.id);
      } else if (task.type == TaskType.inpainting) {
        ref
            .read(modifiedImagesProvider.notifier)
            .getInpaintingTaskImage(task.id);
      }
    } else {
      _failed('${task.type.string} failed');
    }
  }

  void _failed(String message) {
    ref.read(toastsProvider.notifier).show(
          message,
          ToastType.error,
        );
  }

  void _success(String message) {
    ref.read(toastsProvider.notifier).show(
          message,
          ToastType.success,
        );
  }
}

@Riverpod(keepAlive: true)
bool isInpaintingEnabled(IsInpaintingEnabledRef ref) {
  final detections = ref.watch(detectionsProvider).detections;
  return detections.isNotEmpty;
}

@Riverpod(keepAlive: true)
bool readyToInpaint(ReadyToInpaintRef ref) {
  final detections = ref.watch(detectionsProvider).selectedDetections;
  return detections.isNotEmpty;
}

@Riverpod(keepAlive: true)
bool isDetectionRunning(IsDetectionRunningRef ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.any((task) =>
      task.type == TaskType.detection && task.status == TaskStatus.running);
}

@Riverpod(keepAlive: true)
bool isInpaintingRunning(IsInpaintingRunningRef ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.any((task) =>
      task.type == TaskType.inpainting && task.status == TaskStatus.running);
}

@Riverpod(keepAlive: true)
bool isEditingRunning(IsEditingRunningRef ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.any((task) =>
      task.type == TaskType.editing && task.status == TaskStatus.running);
}
