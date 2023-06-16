import 'package:flutter/material.dart';

import '/util/util.dart';
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

@freezed
class TabsState with _$TabsState {
  const TabsState._();

  const factory TabsState({
    required List<Tab> tabs,
    required Tab selectedTab,
  }) = _TabsState;

  static const _initialTabs = [
    Tab(
      icon: FontAwesomeIcons.vectorSquare,
      label: 'Detect',
    ),
    Tab(
      icon: FontAwesomeIcons.eraser,
      label: 'Erase',
      isDisabled: true,
      disabledTooltip: 'Detect first!',
    ),
    Tab(
      icon: FontAwesomeIcons.brush,
      label: 'Dream',
      isDisabled: true,
      disabledTooltip: 'Coming soon!',
    ),
  ];

  factory TabsState.initial() => TabsState(
        tabs: _initialTabs,
        selectedTab: _initialTabs.first,
      );
}

@Riverpod(keepAlive: true)
class Tabs extends _$Tabs {
  @override
  TabsState build() {
    return TabsState.initial();
  }

  void select(Tab tab) {
    if (tab == state.selectedTab) {
      return;
    }

    if (!state.tabs.contains(tab)) {
      ref.read(toastsProvider.notifier).show(
            'Tab not found',
            ToastType.error,
          );
      return;
    }

    state = state.copyWith(selectedTab: tab);
  }
}
