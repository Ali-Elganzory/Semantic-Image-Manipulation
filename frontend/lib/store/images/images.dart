import 'dart:developer';

import '/util/util.dart';
import '/store/store.dart';
import '/models/models.dart';
import '/repository/repository.dart';
import '/constants/constants.dart';
import '/third_party/third_party.dart';

part 'images.freezed.dart';
part 'images.g.dart';

@freezed
class ImagesState with _$ImagesState {
  const ImagesState._();

  const factory ImagesState({
    required List<ImageModel> images,
    required ImageModel selected,
    required String searchTerm,
    required bool isLoadingImages,
    required bool isUploadingImage,
  }) = _ImagesState;

  bool get isImageSelected => selected.id != Empty.INT;

  factory ImagesState.initial() => const ImagesState(
        images: [],
        selected: ImageModel(),
        searchTerm: Empty.STRING,
        isLoadingImages: false,
        isUploadingImage: false,
      );
}

@Riverpod(keepAlive: true)
class Images extends _$Images {
  final repository = ApiRepository();

  @override
  ImagesState build() {
    return ImagesState.initial();
  }

  Future<void> getImages() async {
    // return;
    state = state.copyWith(isLoadingImages: true);
    final response = await repository.getImages();

    response.fold(
      (failure) {
        _failed('Failed to load images');
        state = state.copyWith(
          isLoadingImages: false,
        );
      },
      (successfulResponse) => state = state.copyWith(
        isLoadingImages: false,
        images: successfulResponse.data,
      ),
    );
  }

  void select(ImageModel image) {
    state = state.copyWith(selected: image);
    ref.read(tasksProvider.notifier).getTasks(image.id);
  }

  void deselect() {
    state = state.copyWith(selected: const ImageModel());
  }

  void search(String searchTerm) {
    state = state.copyWith(searchTerm: searchTerm);
  }

  Future<void> newImage(String name, FutureOr<List<int>> bytes) async {
    state = state.copyWith(isUploadingImage: true);

    final response = await repository.postImage(
      name: name,
      bytes: await bytes,
    );
    response.fold(
      (failure) {
        _failed('Failed to upload image');
        state = state.copyWith(
          isUploadingImage: false,
        );
      },
      (successfulResponse) {
        _success('Successfully uploaded image');
        final newImage = successfulResponse.data;
        state = state.copyWith(
          isUploadingImage: false,
          selected: newImage,
          images: [
            newImage,
            ...state.images,
          ],
        );
      },
    );
  }

  Future<void> updateName(String name) async {
    final String oldName = state.selected.name;

    // Optimistically update the name
    state = state.copyWith(
      selected: state.selected.copyWith(name: name),
      images: state.images.map((e) {
        if (e.id == state.selected.id) {
          return e.copyWith(name: name);
        }
        return e;
      }).toList(),
    );

    // Update the name on the server
    final response = await repository.putImage(
      id: state.selected.id,
      name: name,
    );
    response.fold(
      (failure) {
        _failed('Failed to update image name');

        // Revert the name
        state = state.copyWith(
          selected: state.selected.copyWith(name: oldName),
          images: state.images.map((e) {
            if (e.id == state.selected.id) {
              return e.copyWith(name: oldName);
            }
            return e;
          }).toList(),
        );
      },
      (successfulResponse) {
        _success('Successfully updated image name to "$name"');
      },
    );
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
List<ImageModel> imageSearchResults(ImageSearchResultsRef ref) {
  final all = ref.watch(imagesProvider).images;
  final searchTerm = ref.watch(imagesProvider).searchTerm.toLowerCase();

  return all
      .where((e) => e.name.toLowerCase().contains(searchTerm))
      .toList(growable: false);
}
