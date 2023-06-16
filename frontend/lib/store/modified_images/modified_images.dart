import '/util/util.dart';
import '/store/store.dart';
import '/models/models.dart';
import '/repository/repository.dart';
import '/third_party/third_party.dart';

part 'modified_images.freezed.dart';
part 'modified_images.g.dart';

@freezed
class ModifiedImagesState with _$ModifiedImagesState {
  const factory ModifiedImagesState({
    required List<ModifiedImageModel> inpaintingImages,
    required bool isLoadingInpaintingImages,
    required bool isLoadingInpaintingTaskImage,
    required List<ModifiedImageModel> editingImages,
    required bool isLoadingEditingImages,
    required bool isLoadingEditingTaskImage,
  }) = _ModifiedImagesState;

  factory ModifiedImagesState.initial() => const ModifiedImagesState(
        inpaintingImages: [],
        isLoadingInpaintingImages: false,
        isLoadingInpaintingTaskImage: false,
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

  Future<void> getInpaintingImages() async {
    if (state.isLoadingInpaintingImages) return;

    final imageId = ref.read(imagesProvider).selected.id;

    state = state.copyWith(
      isLoadingInpaintingImages: true,
      inpaintingImages: [],
    );
    final response = await repository.getInpaintsByImage(imageId);

    response.fold(
      (failure) {
        ref.read(toastsProvider.notifier).show(
              "Couldn't load inpaintings. Please refresh the page and try again.",
              ToastType.error,
            );
        return state = state.copyWith(
          isLoadingInpaintingImages: false,
        );
      },
      (successfulResponse) {
        return state = state.copyWith(
          inpaintingImages: successfulResponse.data,
          isLoadingInpaintingImages: false,
        );
      },
    );
  }

  Future<void> getInpaintingTaskImage(int taskId) async {
    if (state.isLoadingInpaintingTaskImage) return;

    state = state.copyWith(
      isLoadingInpaintingTaskImage: true,
    );
    final response = await repository.getInpaintByTask(taskId);

    response.fold(
      (failure) {
        ref.read(toastsProvider.notifier).show(
              "Couldn't load the inpainted image. Please refresh the page and try again.",
              ToastType.error,
            );
        return state = state.copyWith(
          isLoadingInpaintingTaskImage: false,
        );
      },
      (successfulResponse) {
        final inpaintingImages = state.inpaintingImages
            .where((element) => element.id != successfulResponse.data.id)
            .toList();

        return state = state.copyWith(
          inpaintingImages: inpaintingImages + [successfulResponse.data],
          isLoadingInpaintingTaskImage: false,
        );
      },
    );
  }

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
