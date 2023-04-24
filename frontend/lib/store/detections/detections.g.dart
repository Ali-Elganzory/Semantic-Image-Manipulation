// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detections.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labelSuggestionsHash() => r'fa6e7f4d543d09f590a0c9641937d4ccb32a9e80';

/// See also [labelSuggestions].
@ProviderFor(labelSuggestions)
final labelSuggestionsProvider = AutoDisposeProvider<List<LabelModel>>.internal(
  labelSuggestions,
  name: r'labelSuggestionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$labelSuggestionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LabelSuggestionsRef = AutoDisposeProviderRef<List<LabelModel>>;
String _$detectionsHash() => r'd4db91794be6c838ec06e714174433264e0741d3';

/// See also [Detections].
@ProviderFor(Detections)
final detectionsProvider =
    AutoDisposeNotifierProvider<Detections, DetectionsState>.internal(
  Detections.new,
  name: r'detectionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$detectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Detections = AutoDisposeNotifier<DetectionsState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
