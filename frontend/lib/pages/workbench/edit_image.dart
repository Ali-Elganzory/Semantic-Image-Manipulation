import 'package:flutter/material.dart' hide EditableText;

import '/store/store.dart';
import '/models/models.dart';
import '/components/components.dart';
import '/third_party/third_party.dart';

import 'canvas.dart';

class EditImage extends StatefulHookConsumerWidget {
  const EditImage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditImageState();
}

class _EditImageState extends ConsumerState<EditImage> {
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
    final labelsNotifier = ref.read(detectionsProvider.notifier);
    final areLabelsLoading = ref.watch(detectionsProvider).isLoadingLabels;
    final labelSuggestions = ref.watch(labelSuggestionsProvider);
    final image = ref.watch(imagesProvider).selected;
    final tasks = ref.watch(tasksProvider).tasks;
    final areTasksLoading = ref.watch(tasksProvider).isLoading;
    final isDetectionRunning = ref.watch(isDetectionRunningProvider);

    // Actions
    void onLabelsChanged(List<LabelModel> labels) {
      labelsNotifier.selectLabels(labels);
    }

    void onSearchChanged(String query) {
      labelsNotifier.searchLabels(query);
    }

    void onNameChanged(String name) {
      ref.read(imagesProvider.notifier).updateName(name);
    }

    void onDetectPressed() {
      ref.read(tasksProvider.notifier).detect(image.id);
    }

    return Stack(
      children: [
        const Positioned(
          top: 60,
          bottom: _inputHeight + 10,
          left: 0,
          right: 0,
          child: Canvas(),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            children: [
              EditableText(
                text: image.name,
                realtimeText: true,
                tooltip: 'Edit name',
                onChanged: (value) {
                  onNameChanged(value);
                  return true;
                },
              ),
              const Expanded(
                child: SizedBox(),
              ),
              if (!areTasksLoading)
                for (final task in tasks)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TaskChip(
                      task: task,
                    ),
                  ),
              if (areTasksLoading)
                for (final _ in List.generate(2, (i) => i))
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Skeleton(
                      isLoading: true,
                      child: TaskChip(
                        task: TaskModel(
                          id: -1,
                          imageId: -1,
                          status: TaskStatus.pending,
                          type: TaskType.detection,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Skeleton(
            isLoading: areLabelsLoading,
            child: ChipsInput<LabelModel>(
              decoration: InputDecoration(
                hintText: 'What do you want to remove?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                suffixIcon: Tooltip(
                  message:
                      isDetectionRunning ? 'Detection running..' : 'Detect',
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: MaterialButton(
                      onPressed: isDetectionRunning ? null : onDetectPressed,
                      padding: const EdgeInsets.all(0),
                      disabledColor: Colors.grey,
                      child: FaIcon(
                        FontAwesomeIcons.vectorSquare,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints.tight(
                  const Size.square(_inputHeight - 10),
                ),
              ),
              chipBuilder: (context, state, label) => InputChip(
                label: Text(label.name),
                onDeleted: () => state.deleteChip(label),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              suggestionBuilder: (context, state, label) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  title: Text(label.name),
                  onTap: () => state.selectSuggestion(label),
                ),
              ),
              suggestions: labelSuggestions,
              onSearchChanged: onSearchChanged,
              onChanged: onLabelsChanged,
            ),
          ),
        ),
      ],
    );
  }
}
