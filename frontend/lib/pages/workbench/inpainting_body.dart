import 'package:flutter/material.dart';

import '/store/store.dart';
import '/components/components.dart';
import '/third_party/third_party.dart';

import 'inpainted_image.dart';
import 'inpainting_canvas.dart';

class InpaintingBody extends StatefulHookConsumerWidget {
  const InpaintingBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InpaintingBodyState();
}

class _InpaintingBodyState extends ConsumerState<InpaintingBody> {
  static const double _inputHeight = 56.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(modifiedImagesProvider.notifier).getInpaintingImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    // State
    final carouselController =
        useState<CarouselController>(CarouselController());
    final currentIndex = useState<int>(0);
    final areModifiedImagesLoading =
        ref.watch(modifiedImagesProvider).isLoadingInpaintingImages;
    final urls =
        ref.watch(modifiedImagesProvider).inpaintingImages.map((e) => e.url);
    final isInpaintingRunning = ref.watch(isInpaintingRunningProvider);
    final readyToInpaint = ref.watch(readyToInpaintProvider);

    // Actions
    void onInpaintPressed() {
      ref.read(tasksProvider.notifier).inpaint();
    }

    void onPageChanged(int index, CarouselPageChangedReason reason) {
      currentIndex.value = index;
    }

    void onBackwardPressed() {
      carouselController.value
          .animateToPage(currentIndex.value - 1, curve: Curves.easeInOut);
    }

    void onForwardPressed() {
      carouselController.value
          .animateToPage(currentIndex.value + 1, curve: Curves.easeInOut);
    }

    void onHomePressed() {
      carouselController.value.animateToPage(0, curve: Curves.easeInOut);
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: _inputHeight + 10,
          left: 0,
          right: 0,
          child: Skeleton(
            isLoading: areModifiedImagesLoading,
            child: CarouselSlider(
              carouselController: carouselController.value,
              items: [
                const InpaintingCanvas(),
                ...urls.map(
                  (url) => InpaintedImage(url: url),
                )
              ]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: e,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: onPageChanged,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: _inputHeight,
          child: Skeleton(
            isLoading: areModifiedImagesLoading,
            child: Tooltip(
              message: isInpaintingRunning
                  ? 'Erasing..'
                  : !readyToInpaint
                      ? 'Select objects to erase'
                      : 'Erase',
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: MaterialButton(
                  onPressed: isInpaintingRunning || !readyToInpaint
                      ? null
                      : onInpaintPressed,
                  padding: const EdgeInsets.all(0),
                  disabledColor: Colors.grey,
                  child: const Text(
                    'Erase',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (currentIndex.value != 0) ...[
          Positioned(
            top: 80,
            left: 0,
            bottom: _inputHeight + 10,
            child: Center(
              child: IconButton(
                onPressed: onHomePressed,
                icon: const Icon(Icons.home_rounded),
                color: Theme.of(context).primaryColor,
                tooltip: 'Original image',
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: _inputHeight + 10,
            child: Center(
              child: IconButton(
                onPressed: onBackwardPressed,
                icon: const Icon(Icons.arrow_back_ios),
                color: Theme.of(context).primaryColor,
                tooltip: 'Previous image',
              ),
            ),
          ),
        ],
        if (currentIndex.value != urls.length)
          Positioned(
            top: 0,
            right: 0,
            bottom: _inputHeight + 10,
            child: Center(
              child: IconButton(
                onPressed: onForwardPressed,
                icon: const Icon(Icons.arrow_forward_ios),
                color: Theme.of(context).primaryColor,
                tooltip: 'Next image',
              ),
            ),
          ),
      ],
    );
  }
}
