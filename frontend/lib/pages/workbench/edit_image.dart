import 'package:flutter/material.dart' hide EditableText;

import '/models/label/label.dart';
import '/third_party/third_party.dart';
import '/store/store.dart';
import '/components/components.dart';

class EditImage extends ConsumerStatefulWidget {
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
      ref.read(labelsProvider.notifier).getLabels();
    });
  }

  @override
  Widget build(BuildContext context) {
    // State
    final labelsNotifier = ref.read(labelsProvider.notifier);
    final imageUrl = ref.watch(editingProvider).imageUrl;
    final areLabelsLoading = ref.watch(labelsProvider).isLoading;
    final suggestions = ref.watch(suggestionsProvider);

    // Actions
    void onLabelsChanged(List<Label> labels) {
      labelsNotifier.setSelected(labels);
    }

    void onSearchChanged(String query) async {
      labelsNotifier.search(query);
    }

    return Stack(
      children: [
        Positioned(
          top: 60,
          bottom: _inputHeight + 10,
          left: 0,
          right: 0,
          child: CachedNetworkImage(imageUrl: imageUrl),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            children: [
              EditableText(
                text: 'Image 1',
                onChanged: (value) {
                  return true;
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              ChipsInput<Label>(
                decoration: InputDecoration(
                  hintText: 'What do you want to remove?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
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
                suggestions: suggestions,
                onSearchChanged: onSearchChanged,
                onChanged: onLabelsChanged,
              ),
              if (areLabelsLoading)
                Positioned.fill(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
