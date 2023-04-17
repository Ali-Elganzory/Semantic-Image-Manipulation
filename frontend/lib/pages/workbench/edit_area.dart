import 'package:flutter/material.dart';
import 'package:frontend/pages/workbench/edit_image.dart';

import '/third_party/third_party.dart';
import '/store/store.dart';

import 'drop_zone.dart';

class EditArea extends HookConsumerWidget {
  const EditArea({super.key});

  static const double _padding = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageLoaded = ref.watch(editingProvider).isImageLoaded;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(_padding),
      child: isImageLoaded ? const EditImage() : const DropZone(),
    );
  }
}
