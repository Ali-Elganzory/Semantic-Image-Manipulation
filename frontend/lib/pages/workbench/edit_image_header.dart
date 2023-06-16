import 'package:flutter/material.dart' hide EditableText, Tab;

import '/store/store.dart';
import '/models/models.dart';
import '/components/components.dart';
import '/third_party/third_party.dart';

class EditImageHeader extends HookConsumerWidget {
  const EditImageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final image = ref.watch(imagesProvider).selected;
    final tabs = ref.watch(tabsProvider);
    final selectedTab = ref.watch(selectedTabProvider);
    final tasks = ref.watch(tasksProvider).tasks;
    final areTasksLoading = ref.watch(tasksProvider).isLoading;

    // Actions
    void onNameChanged(String name) {
      ref.read(imagesProvider.notifier).updateName(name);
    }

    void onTabChanged(Tab tab) {
      ref.read(tabsProvider.notifier).select(tab);
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: EditableText(
            text: image.name,
            realtimeText: true,
            tooltip: 'Edit name',
            onChanged: (value) {
              onNameChanged(value);
              return true;
            },
          ),
        ),
        Expanded(
          child: SwitchTabBar(
            tabs: tabs,
            selectedTab: selectedTab,
            onTabChanged: onTabChanged,
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
      ],
    );
  }
}

class SwitchTabBar extends HookWidget {
  const SwitchTabBar({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final List<Tab> tabs;
  final Tab selectedTab;
  final void Function(Tab) onTabChanged;

  @override
  Widget build(BuildContext context) {
    // Actions
    void onTabPressed(Tab tab) {
      if (tab.isDisabled) return;

      onTabChanged(tab);
    }

    bool isSelected(Tab tab) => tab == selectedTab;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: Wrap(
          spacing: 8,
          direction: Axis.horizontal,
          children: [
            for (final tab in tabs)
              Tooltip(
                message: tab.isDisabled ? tab.disabledTooltip : tab.label,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected(tab)
                        ? Theme.of(context).scaffoldBackgroundColor
                        : null,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  child: MaterialButton(
                    onPressed: () => onTabPressed(tab),
                    padding: const EdgeInsets.all(0),
                    disabledColor: Colors.transparent,
                    mouseCursor: tab.isDisabled
                        ? SystemMouseCursors.forbidden
                        : SystemMouseCursors.click,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          tab.icon,
                          color: isSelected(tab)
                              ? Theme.of(context).primaryColor
                              : tab.isDisabled
                                  ? Theme.of(context).disabledColor
                                  : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tab.label,
                          style: TextStyle(
                            color: isSelected(tab)
                                ? Theme.of(context).primaryColor
                                : tab.isDisabled
                                    ? Theme.of(context).disabledColor
                                    : null,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
