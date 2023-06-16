import 'package:flutter/material.dart';

import '/store/store.dart';
import '/components/components.dart';
import '/third_party/third_party.dart';

import 'editing_canvas.dart';

class EditingBody extends StatefulHookConsumerWidget {
  const EditingBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditingBodyState();
}

class _EditingBodyState extends ConsumerState<EditingBody> {
  static const double _inputHeight = 56.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(detectionsProvider.notifier).getLabels();
    });
  }

  @override
  Widget build(BuildContext context) {
    // State
    final areModifiedImagesLoading =
        ref.watch(modifiedImagesProvider).isLoadingEditingImages;
    final isEditingRunning = ref.watch(isEditingRunningProvider);
    final textFieldController = useTextEditingController();

    // Actions
    void onDreamPressed() {
      ref.read(tasksProvider.notifier).edit(textFieldController.text);
    }

    return Stack(
      children: [
        const Positioned(
          top: 0,
          bottom: _inputHeight + 10,
          left: 0,
          right: 0,
          child: EditingCanvas(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Skeleton(
            isLoading: areModifiedImagesLoading,
            child: TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                hintText:
                    'Describe what you want the image to look like.. Maybe a Van Gogh style?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                suffixIcon: Tooltip(
                  message: isEditingRunning ? 'Dreaming..' : 'Dream',
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: MaterialButton(
                      onPressed: isEditingRunning ? null : onDreamPressed,
                      padding: const EdgeInsets.all(0),
                      disabledColor: Colors.grey,
                      child: FaIcon(
                        FontAwesomeIcons.paperPlane,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints.tight(
                  const Size.square(_inputHeight - 10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
