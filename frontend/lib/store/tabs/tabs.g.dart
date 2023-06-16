// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedTabHash() => r'10c7dc5601bf7b452a3a9842453ed9aa48be442b';

/// See also [selectedTab].
@ProviderFor(selectedTab)
final selectedTabProvider = Provider<Tab>.internal(
  selectedTab,
  name: r'selectedTabProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedTabHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedTabRef = ProviderRef<Tab>;
String _$tabIndexHash() => r'c8dedce0e969c625539a95afcdc2e28bb2dd3e54';

/// See also [TabIndex].
@ProviderFor(TabIndex)
final tabIndexProvider = NotifierProvider<TabIndex, int>.internal(
  TabIndex.new,
  name: r'tabIndexProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tabIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabIndex = Notifier<int>;
String _$tabsHash() => r'c8957782f6cf94fd071c173d0ffae1e88e973b39';

/// See also [Tabs].
@ProviderFor(Tabs)
final tabsProvider = NotifierProvider<Tabs, List<Tab>>.internal(
  Tabs.new,
  name: r'tabsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tabsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Tabs = Notifier<List<Tab>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
