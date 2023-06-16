import 'package:flutter/material.dart';

import '/store/store.dart';
import '/third_party/third_party.dart';

import 'edit_image_header.dart';
import 'detection_body.dart';
import 'inpainting_body.dart';
import 'editing_body.dart';

class EditImage extends HookConsumerWidget {
  const EditImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final tabs = ref.watch(tabsProvider);
    final selectedTab = ref.watch(selectedTabProvider);

    final body = {
      tabs[0]: const DetectionBody(),
      tabs[1]: const InpaintingBody(),
      tabs[2]: const EditingBody(),
    }[selectedTab]!;

    return Stack(
      children: [
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: EditImageHeader(),
        ),
        Positioned(
          top: 60,
          bottom: 0,
          left: 0,
          right: 0,
          child: body,
        ),
      ],
    );
  }
}
