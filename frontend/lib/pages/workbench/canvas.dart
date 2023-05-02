import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';

import '/store/store.dart';
import '/components/components.dart';
import '/third_party/third_party.dart';

class Canvas extends HookConsumerWidget {
  const Canvas({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final image = ref.watch(imagesProvider).selected;
    final detections = ref.watch(relativeDetectionsProvider);
    final selectedDetections = ref.watch(detectionsProvider).selectedDetections;

    // Actions
    void onDetectionPressed(DetectionModel detection) {
      ref.read(detectionsProvider.notifier).toggleDetectionSelection(detection);
    }

    // Helpers
    bool isSelected(DetectionModel detection) =>
        selectedDetections.contains(detection);

    return CachedNetworkImage(
      imageUrl: image.url,
      imageBuilder: (context, imageProvider) => LayoutBuilder(
        builder: (context, constraints) {
          final childAspectRatio = image.width / image.height;
          final constAspectRatio = constraints.maxWidth / constraints.maxHeight;

          double width = 0, height = 0;
          if (childAspectRatio > constAspectRatio) {
            width = constraints.maxWidth;
            height = width / childAspectRatio;
          } else {
            height = constraints.maxHeight;
            width = height * childAspectRatio;
          }

          return Container(
            alignment: Alignment.center,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: imageProvider,
                    ),
                  ),
                  for (final detection in detections)
                    Positioned(
                      left: detection.xp * width,
                      top: detection.yp * height,
                      width: detection.wp * width,
                      height: detection.hp * height,
                      child: OutlinedButton(
                        onPressed: () => onDetectionPressed(detection),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(isSelected(detection) ? 0.5 : 0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              width: 4,
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        child: const SizedBox(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
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
  }
}
