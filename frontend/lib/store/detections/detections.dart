import '/util/util.dart';
import '/models/models.dart';
import '/repository/repository.dart';
import '/constants/constants.dart';
import '/third_party/third_party.dart';

part 'detections.freezed.dart';
part 'detections.g.dart';

@freezed
class DetectionsState with _$DetectionsState {
  const factory DetectionsState({
    required List<LabelModel> labels,
    required List<LabelModel> selectedLabels,
    required String labelsSearchTerm,
    required bool isLoadingLabels,
    required List<DetectionModel> detections,
    required List<DetectionModel> selectedDetectionss,
    required bool isLoadingDetectionss,
  }) = _DetectionsState;

  factory DetectionsState.initial() => const DetectionsState(
        labels: [],
        selectedLabels: [],
        labelsSearchTerm: Empty.STRING,
        isLoadingLabels: false,
        detections: [],
        selectedDetectionss: [],
        isLoadingDetectionss: false,
      );
}

@riverpod
class Detections extends _$Detections {
  final repository = ApiRepository();

  @override
  DetectionsState build() {
    return DetectionsState.initial();
  }

  Future<void> getLabels() async {
    if (state.isLoadingLabels) return;
    if (state.labels.isNotEmpty) return;

    state = state.copyWith(isLoadingLabels: true);
    final response = await repository.getLabels();

    response.fold(
      (failure) {
        ref.read(toastsProvider.notifier).show(
              "Couldn't load labels. Please try again.",
              ToastType.error,
            );
        return state = state.copyWith(
          isLoadingLabels: false,
        );
      },
      (successfulResponse) {
        ref.read(toastsProvider.notifier).show(
              'Labels loaded successfully. Start typing!',
              ToastType.success,
            );
        return state = state.copyWith(
          labels: successfulResponse.data,
          isLoadingLabels: false,
        );
      },
    );
  }

  void selectLabels(List<LabelModel> labels) {
    state = state.copyWith(selectedLabels: labels);
  }

  void searchLabels(String searchTerm) {
    state = state.copyWith(labelsSearchTerm: searchTerm);
  }
}

@riverpod
List<LabelModel> labelSuggestions(LabelSuggestionsRef ref) {
  final all = ref.watch(detectionsProvider).labels;
  final selectedIds =
      ref.watch(detectionsProvider).selectedLabels.map((e) => e.id).toSet();
  final searchTerm =
      ref.watch(detectionsProvider).labelsSearchTerm.toLowerCase();

  if (searchTerm.isNotEmpty) {
    return all
        .where((e) => !selectedIds.contains(e.id))
        .where((e) => e.name.toLowerCase().contains(searchTerm))
        .toList(growable: false);
  }
  return const [];
}
