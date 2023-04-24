import 'package:flutter/material.dart';

import '/store/store.dart';
import '/third_party/third_party.dart';

import 'drop_zone.dart';
import 'edit_image.dart';

class EditArea extends HookConsumerWidget {
  const EditArea({super.key});

  static const double _padding = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageSelected = ref.watch(imagesProvider).isImageSelected;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(_padding),
      child: isImageSelected ? const EditImage() : const DropZone(),
    );
  }
}
