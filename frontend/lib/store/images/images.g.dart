// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageSearchResultsHash() =>
    r'551524df91a08c5e8debc1f54024238eea4c3099';

/// See also [imageSearchResults].
@ProviderFor(imageSearchResults)
final imageSearchResultsProvider =
    AutoDisposeProvider<List<ImageModel>>.internal(
  imageSearchResults,
  name: r'imageSearchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageSearchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ImageSearchResultsRef = AutoDisposeProviderRef<List<ImageModel>>;
String _$imagesHash() => r'fc15c157f24ec04ea12fc4bd77afa154094ad7a3';

/// See also [Images].
@ProviderFor(Images)
final imagesProvider =
    AutoDisposeNotifierProvider<Images, ImagesState>.internal(
  Images.new,
  name: r'imagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$imagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Images = AutoDisposeNotifier<ImagesState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
