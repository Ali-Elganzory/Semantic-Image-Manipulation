import 'package:flutter/material.dart';

import '/util/util.dart';
import '/store/store.dart';
import '/third_party/third_party.dart';
import '/components/components.dart';

class DropZone extends HookConsumerWidget {
  const DropZone({super.key});

  static const double _dropzoneInnerPadding = 6;
  static const double _dropzoneRadius = 5;

  static const Set<String> _supportedMimeTypes = {
    'image/jpeg',
    'image/png',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final isHovering = useState(false);
    final fileController = useState<DropzoneViewController?>(null);
    final isUploadingImage = ref.watch(imagesProvider).isUploadingImage;

    // Actions
    void onDrop(event) async {
      if (isUploadingImage) return;

      final mime = await fileController.value!.getFileMIME(event);
      if (!_supportedMimeTypes.contains(mime)) {
        if (context.mounted) {
          context.showSnackBar(
              'Unsupported file type. Please upload a JPEG or PNG image.');
        }
      } else {
        final name = await fileController.value!.getFilename(event);
        final bytes = fileController.value!.getFileData(event);
        ref.read(imagesProvider.notifier).newImage(name, bytes);
      }

      isHovering.value = false;
    }

    return Stack(
      children: [
        DottedBorder(
          radius: const Radius.circular(_dropzoneRadius),
          borderType: BorderType.RRect,
          dashPattern: const [6, 4],
          strokeCap: StrokeCap.round,
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(_dropzoneInnerPadding),
          child: Container(
            decoration: BoxDecoration(
              color: isHovering.value
                  ? Theme.of(context).primaryColor.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(
                Radius.circular(_dropzoneRadius),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isUploadingImage)
                    AnimatedUpDown(
                      duration: const Duration(milliseconds: 600),
                      extraSpace: 24,
                      child: FaIcon(
                        FontAwesomeIcons.cloudArrowUp,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                    ),
                  Text(
                    isUploadingImage ? 'Uploading...' : 'Drop a photo here',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: isHovering.value
                              ? Colors.white
                              : Theme.of(context).primaryColorDark,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isUploadingImage)
          DropzoneView(
            onCreated: (controller) => fileController.value = controller,
            onHover: () => isHovering.value = true,
            onLeave: () => isHovering.value = false,
            onDrop: onDrop,
          ),
      ],
    );
  }
}
