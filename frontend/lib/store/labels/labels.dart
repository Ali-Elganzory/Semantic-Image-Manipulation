
import '/models/label/label.dart';
import '/repositories/repository.dart';
import '/constants/constants.dart';
import '/third_party/third_party.dart';

part 'labels.freezed.dart';
part 'labels.g.dart';

@freezed
class LabelsState with _$LabelsState {
  const LabelsState._();

  const factory LabelsState({
    required List<Label> labels,
    required List<Label> selected,
    required String searchTerm,
    required bool isLoading,
    required String errorMessage,
  }) = _LabelsState;

  factory LabelsState.initial() => const LabelsState(
        isLoading: false,
        labels: [],
        selected: [],
        searchTerm: Empty.STRING,
        errorMessage: Empty.STRING,
      );

  bool get labelsLoaded => labels.isNotEmpty;
  bool get hasError => errorMessage.isNotEmpty;
}

@riverpod
class Labels extends _$Labels {
  @override
  LabelsState build() {
    return LabelsState.initial();
  }

  Future<void> getLabels() async {
    state = state.copyWith(isLoading: true);
    final response = await ApiRepository().getLabels();

    response.fold(
      (failure) => state = state.copyWith(
        errorMessage: failure.message,
        isLoading: false,
      ),
      (successfulResponse) => state = state.copyWith(
        labels: successfulResponse.data,
        isLoading: false,
      ),
    );
  }

  void setSelected(List<Label> labels) {
    state = state.copyWith(selected: labels);
  }

  void search(String term) {
    state = state.copyWith(searchTerm: term);
  }
}

@riverpod
List<Label> suggestions(SuggestionsRef ref) {
  final all = ref.watch(labelsProvider).labels;
  final selectedIds =
      ref.watch(labelsProvider).selected.map((e) => e.id).toSet();
  final searchTerm = ref.watch(labelsProvider).searchTerm.toLowerCase();

  if (searchTerm.isNotEmpty) {
    return all
        .where((e) => !selectedIds.contains(e.id))
        .where((e) => e.name.toLowerCase().contains(searchTerm))
        .toList(growable: false);
  }
  return const [];
}
