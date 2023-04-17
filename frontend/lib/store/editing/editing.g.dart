// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editing.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$suggestionsHash() => r'90e99fb8cf7e5e3c26e4b8a636e297656c189e5a';

/// See also [suggestions].
@ProviderFor(suggestions)
final suggestionsProvider = AutoDisposeProvider<List<String>>.internal(
  suggestions,
  name: r'suggestionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$suggestionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SuggestionsRef = AutoDisposeProviderRef<List<String>>;
String _$editingHash() => r'3ce76817004709e7e076178602c2e1d3b5ba9162';

/// See also [Editing].
@ProviderFor(Editing)
final editingProvider =
    AutoDisposeNotifierProvider<Editing, EditingState>.internal(
  Editing.new,
  name: r'editingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$editingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Editing = AutoDisposeNotifier<EditingState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
