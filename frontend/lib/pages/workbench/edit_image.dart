import 'package:flutter/material.dart' hide EditableText;

import '/models/label/label.dart';
import '/third_party/third_party.dart';
import '/store/store.dart';
import '/components/components.dart';

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

    // Actions
    void onLabelsChanged(List<LabelModel> labels) {
      labelsNotifier.selectLabels(labels);
    }

    void onSearchChanged(String query) async {
      labelsNotifier.searchLabels(query);
    }

    void onNameChanged(String name) {
      ref.read(imagesProvider.notifier).updateName(name);
    }

    return Stack(
      children: [
        Positioned(
          top: 60,
          bottom: _inputHeight + 10,
          left: 0,
          right: 0,
          child: CachedNetworkImage(
            imageUrl: image.url,
            fit: BoxFit.contain,
            imageBuilder: (context, imageProvider) => FittedBox(
              fit: BoxFit.contain,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: imageProvider,
                ),
              ),
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
          ),
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
                  message: 'Detect',
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        print('TODO: Detect button');
                      },
                      padding: const EdgeInsets.all(0),
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
