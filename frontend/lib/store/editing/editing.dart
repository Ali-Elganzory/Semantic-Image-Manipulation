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
  }) = _EditingState;

  factory EditingState.initial() => const EditingState(
        isLoading: false,
        imageUrl: Empty.STRING,
      );

  bool get isImageLoaded => imageUrl != Empty.STRING;
}

@Riverpod(keepAlive: true)
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
}
