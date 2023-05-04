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

    // Optimistically add a task to the list
    final task = TaskModel(
      id: Empty.INT,
      imageId: imageId,
      type: TaskType.detection,
      status: TaskStatus.pending,
    );
    state = state.copyWith(
      tasks: [
        ...state.tasks.where((e) => e.type != TaskType.detection),
        task,
      ],
    );

    // Send request
    final response = await repository.detect(
      imageId,
      labelIds,
    );
    response.fold(
      (failure) {
        _failed('Failed to detect');
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
      } else {
        // TODO: implement inpainting
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
bool isDetectionRunning(IsDetectionRunningRef ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.any((task) =>
      task.type == TaskType.detection && task.status == TaskStatus.running);
}
