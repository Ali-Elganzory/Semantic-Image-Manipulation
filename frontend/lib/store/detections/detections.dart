import '/util/util.dart';
import '/store/store.dart';
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
    required Set<DetectionModel> selectedDetections,
    required bool isLoadingDetections,
  }) = _DetectionsState;

  factory DetectionsState.initial() => const DetectionsState(
        labels: [],
        selectedLabels: [],
        labelsSearchTerm: Empty.STRING,
        isLoadingLabels: false,
        detections: [],
        selectedDetections: {},
        isLoadingDetections: false,
      );
}

@Riverpod(keepAlive: true)
class Detections extends _$Detections {
  final repository = ApiRepository();

  @override
  DetectionsState build() => DetectionsState.initial();

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

  void reset() {
    state = state.copyWith(
      selectedLabels: [],
      labelsSearchTerm: Empty.STRING,
      detections: [],
      selectedDetections: {},
    );
  }

  Future<void> getDetections(int taskId) async {
    if (state.isLoadingDetections) return;

    state = state.copyWith(
      isLoadingDetections: true,
      detections: [],
    );
    final response = await repository.getDetectionsByTask(taskId);

    response.fold(
      (failure) {
        ref.read(toastsProvider.notifier).show(
              "Couldn't load detections. Please try again.",
              ToastType.error,
            );
        return state = state.copyWith(
          isLoadingDetections: false,
        );
      },
      (successfulResponse) {
        return state = state.copyWith(
          detections: successfulResponse.data,
          isLoadingDetections: false,
        );
      },
    );
  }

  void toggleDetectionSelection(DetectionModel detection) {
    final isSelected = state.selectedDetections.contains(detection);
    final detections = state.selectedDetections.toSet();

    if (isSelected) {
      detections.remove(detection);
    } else {
      detections.add(detection);
    }

    state = state.copyWith(selectedDetections: detections);
  }
}

@Riverpod(keepAlive: true)
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

@Riverpod(keepAlive: true)
List<DetectionModel> relativeDetections(RelativeDetectionsRef ref) {
  final detections = ref.watch(detectionsProvider).detections;
  final image = ref.watch(imagesProvider).selected;

  return detections.relativeToImage(image).toList();
}

extension Math on DetectionModel {
  DetectionModel relativeToImage(ImageModel image) => copyWith(
        xp: x / image.width,
        yp: y / image.height,
        wp: w / image.width,
        hp: h / image.height,
      );
}

extension Math2 on Iterable<DetectionModel> {
  Iterable<DetectionModel> relativeToImage(ImageModel image) =>
      map((e) => e.relativeToImage(image));
}
