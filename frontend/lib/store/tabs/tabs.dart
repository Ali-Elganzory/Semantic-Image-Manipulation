import 'package:flutter/material.dart';

import '/util/util.dart';
import '/store/store.dart';
import '/constants/constants.dart';
import '/third_party/third_party.dart';

part 'tabs.freezed.dart';
part 'tabs.g.dart';

@freezed
class Tab with _$Tab {
  const Tab._();

  const factory Tab({
    required IconData icon,
    required String label,
    @Default(false) bool isDisabled,
    @Default(Empty.STRING) String disabledTooltip,
  }) = _Tab;
}

@Riverpod(keepAlive: true)
class TabIndex extends _$TabIndex {
  @override
  int build() {
    return 0;
  }

  void set(int index) {
    state = index;
  }
}

@Riverpod(keepAlive: true)
class Tabs extends _$Tabs {
  @override
  List<Tab> build() {
    final isInpaintingEnabled = ref.watch(isInpaintingEnabledProvider);

    return [
      const Tab(
        icon: FontAwesomeIcons.vectorSquare,
        label: 'Detect',
      ),
      Tab(
        icon: FontAwesomeIcons.eraser,
        label: 'Erase',
        isDisabled: !isInpaintingEnabled,
        disabledTooltip: 'Detect first!',
      ),
      const Tab(
        icon: FontAwesomeIcons.brush,
        label: 'Dream',
        isDisabled: true,
        disabledTooltip: 'Coming soon!',
      ),
    ];
  }

  void select(Tab tab) {
    if (!state.contains(tab)) {
      ref.read(toastsProvider.notifier).show(
            'Tab not found',
            ToastType.error,
          );
      return;
    }

    ref.read(tabIndexProvider.notifier).set(state.indexOf(tab));
  }
}

@Riverpod(keepAlive: true)
Tab selectedTab(SelectedTabRef ref) {
  final tabs = ref.watch(tabsProvider);
  final index = ref.watch(tabIndexProvider);

  return tabs[index];
}
