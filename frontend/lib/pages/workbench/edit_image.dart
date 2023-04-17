import 'package:flutter/material.dart' hide EditableText;

import '/third_party/third_party.dart';
import '/store/store.dart';
import '/components/components.dart';

class EditImage extends HookConsumerWidget {
  const EditImage({super.key});

  static const double _inputHeight = 56;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingNotifier = ref.read(editingProvider.notifier);

    void onChanged(List<String> data) {
      editingNotifier.setSelectedObjectNames(data);
    }

    void onSearchChanged(String query) async {
      editingNotifier.setObjectNameQuery(query);
    }

    final imageUrl = ref.watch(editingProvider).imageUrl;
    final suggestions = ref.watch(suggestionsProvider);

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
          child: ChipsInput<String>(
            decoration: InputDecoration(
              hintText: 'What do you want to remove?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            chipBuilder: (context, state, data) => InputChip(
              label: Text(data),
              onDeleted: () => state.deleteChip(data),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            suggestionBuilder: (context, state, data) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                title: Text(data),
                onTap: () => state.selectSuggestion(data),
              ),
            ),
            suggestions: suggestions,
            onSearchChanged: onSearchChanged,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
