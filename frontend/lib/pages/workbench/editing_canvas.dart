import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '/store/store.dart';
import '/components/components.dart';
import '/third_party/third_party.dart';

class EditingCanvas extends HookConsumerWidget {
  const EditingCanvas({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final image = ref.watch(imagesProvider).selected;
    final modifiedImages = ref.watch(modifiedImagesProvider).editingImages;

    final urls = [
      image.url,
      ...modifiedImages.map((e) => e.url),
    ];

    return CarouselSlider.builder(
      itemCount: urls.length,
      itemBuilder: (context, index, realIndex) {
        final url = urls[index];

        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.contain,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
          placeholder: (context, url) => Skeleton(
            isLoading: true,
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              clipBehavior: Clip.antiAlias,
            ),
          ),
        );
      },
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
      ),
    );
  }
}
