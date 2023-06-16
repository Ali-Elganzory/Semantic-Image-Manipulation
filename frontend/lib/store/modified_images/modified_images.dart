import '/util/util.dart';
import '/models/models.dart';
import '/repository/repository.dart';
import '/third_party/third_party.dart';

part 'modified_images.freezed.dart';
part 'modified_images.g.dart';

@freezed
class ModifiedImagesState with _$ModifiedImagesState {
  const factory ModifiedImagesState({
    required List<ModifiedImageModel> editingImages,
    required bool isLoadingEditingImages,
    required bool isLoadingEditingTaskImage,
  }) = _ModifiedImagesState;

  factory ModifiedImagesState.initial() => const ModifiedImagesState(
        editingImages: [],
        isLoadingEditingImages: false,
        isLoadingEditingTaskImage: false,
      );
}

@Riverpod(keepAlive: true)
class ModifiedImages extends _$ModifiedImages {
  final repository = ApiRepository();

  @override
  ModifiedImagesState build() => ModifiedImagesState.initial();

  Future<void> getEditingImages(int imageId) async {
    if (state.isLoadingEditingImages) return;

    state = state.copyWith(
      isLoadingEditingImages: true,
      editingImages: [],
    );
    final response = await repository.getEditsByImage(imageId);

    response.fold(
      (failure) {
        ref.read(toastsProvider.notifier).show(
              "Couldn't load detections. Please try again.",
              ToastType.error,
            );
        return state = state.copyWith(
          isLoadingEditingImages: false,
        );
      },
      (successfulResponse) {
        return state = state.copyWith(
          editingImages: successfulResponse.data,
          isLoadingEditingImages: false,
        );
      },
    );
  }

  Future<void> getEditingTaskImage(int taskId) async {
    if (state.isLoadingEditingTaskImage) return;

    state = state.copyWith(
      isLoadingEditingTaskImage: true,
    );
    final response = await repository.getEditByTask(taskId);

    response.fold(
      (failure) {
        ref.read(toastsProvider.notifier).show(
              "Couldn't load the edited image. Please refresh the page and try again.",
              ToastType.error,
            );
        return state = state.copyWith(
          isLoadingEditingTaskImage: false,
        );
      },
      (successfulResponse) {
        final editingImages = state.editingImages
            .where((element) => element.id != successfulResponse.data.id)
            .toList();

        return state = state.copyWith(
          editingImages: editingImages + [successfulResponse.data],
          isLoadingEditingTaskImage: false,
        );
      },
    );
  }
}
