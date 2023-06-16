// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detections.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labelSuggestionsHash() => r'd0bccfda667a9e99f5fe613057081b5d0b47f9d5';

/// See also [labelSuggestions].
@ProviderFor(labelSuggestions)
final labelSuggestionsProvider = Provider<List<LabelModel>>.internal(
  labelSuggestions,
  name: r'labelSuggestionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$labelSuggestionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LabelSuggestionsRef = ProviderRef<List<LabelModel>>;
String _$relativeDetectionsHash() =>
    r'72b28ad3dcaf589327b430a9b06beeab2f0f5699';

/// See also [relativeDetections].
@ProviderFor(relativeDetections)
final relativeDetectionsProvider = Provider<List<DetectionModel>>.internal(
  relativeDetections,
  name: r'relativeDetectionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$relativeDetectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RelativeDetectionsRef = ProviderRef<List<DetectionModel>>;
String _$detectionsHash() => r'6056c7494199f623bfcceab1a83e7d2a69bb0373';

/// See also [Detections].
@ProviderFor(Detections)
final detectionsProvider =
    NotifierProvider<Detections, DetectionsState>.internal(
  Detections.new,
  name: r'detectionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$detectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Detections = Notifier<DetectionsState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
