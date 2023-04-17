import '/constants/constants.dart';

import '/third_party/third_party.dart';

part 'editing.freezed.dart';
part 'editing.g.dart';

@freezed
class EditingState with _$EditingState {
  const EditingState._();

  const factory EditingState({
    required bool isLoading,
    required String imageUrl,
    required List<String> objectNames,
    required List<String> selectedObjectNames,
    required String objectNameQuery,
  }) = _EditingState;

  factory EditingState.initial() => const EditingState(
        isLoading: false,
        imageUrl: Empty.STRING,
        objectNames: [
          'cat',
          'dog',
          'bird',
          'fish',
          'horse',
          'cow',
          'sheep',
          'pig',
          'elephant',
        ],
        selectedObjectNames: [],
        objectNameQuery: Empty.STRING,
      );

  bool get isImageLoaded => imageUrl != Empty.STRING;
}

@riverpod
class Editing extends _$Editing {
  @override
  EditingState build() {
    return EditingState.initial();
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setImageUrl(String url) {
    state = state.copyWith(imageUrl: url);
  }

  void setSelectedObjectNames(List<String> names) {
    state = state.copyWith(selectedObjectNames: names);
  }

  void setObjectNameQuery(String query) {
    state = state.copyWith(objectNameQuery: query);
  }
}

@riverpod
List<String> suggestions(SuggestionsRef ref) {
  final all = ref.watch(editingProvider).objectNames;
  final selected = ref.watch(editingProvider).selectedObjectNames;
  final query = ref.watch(editingProvider).objectNameQuery;

  if (query.isNotEmpty) {
    final lowercaseQuery = query.toLowerCase();
    return all
        .where((e) => !selected.contains(e))
        .where((e) => e.toLowerCase().contains(lowercaseQuery))
        .toList(growable: false);
  }
  return const [];
}
