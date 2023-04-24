import 'package:flutter/material.dart';

import '/store/store.dart';
import '/models/image/image.dart';
import '/third_party/third_party.dart';
import '/components/components.dart';

class Images extends HookConsumerWidget {
  const Images({super.key});

  static const double _sidePadding = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final images = ref.watch(imageSearchResultsProvider);
    final selectedImage = ref.watch(imagesProvider).selected;
    final isLoadingImages = ref.watch(imagesProvider).isLoadingImages;

    // Actions
    void onSearchChanged(String query) {
      ref.read(imagesProvider.notifier).search(query);
    }

    void onImageTileClicked(ImageModel image) {
      ref.read(imagesProvider.notifier).select(image);
    }

    void onNewImageClicked() {
      ref.read(imagesProvider.notifier).deselect();
    }

    useEffect(() {
      Future.microtask(() => ref.read(imagesProvider.notifier).getImages());
      return null;
    }, []);

    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: _sidePadding),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search',
                ),
                onChanged: onSearchChanged,
              ),
            ),
            const SizedBox(height: 0.5 * _sidePadding),
            OutlinedButton.icon(
              onPressed: onNewImageClicked,
              icon: const Icon(Icons.add_rounded),
              label: const Text('New Image'),
            ),
            const SizedBox(height: _sidePadding),
            Expanded(
              child: Skeleton(
                isLoading: isLoadingImages,
                placeholder: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: _sidePadding),
                  itemBuilder: (context, index) => Container(
                    width: double.maxFinite,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                ),
                child: ListView.separated(
                  itemCount: images.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: _sidePadding),
                  padding: const EdgeInsets.only(bottom: _sidePadding),
                  itemBuilder: (context, index) {
                    final image = images[index];
                    final isSelected = selectedImage.id == image.id;

                    return Container(
                      height: 42,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        onPressed: () => {
                          if (!isSelected) {onImageTileClicked(image)}
                        },
                        color: isSelected
                            ? Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.2)
                            : Theme.of(context).primaryColor,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: CachedNetworkImage(
                                  imageUrl: image.url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: _sidePadding),
                            Text(
                              image.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
