// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageSearchResultsHash() =>
    r'9a19c96e666860d88248d40dad2e2a78e3fe6dd0';

/// See also [imageSearchResults].
@ProviderFor(imageSearchResults)
final imageSearchResultsProvider = Provider<List<ImageModel>>.internal(
  imageSearchResults,
  name: r'imageSearchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageSearchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ImageSearchResultsRef = ProviderRef<List<ImageModel>>;
String _$imagesHash() => r'b9b75431c0a8c5d97d784e97795825ee9cddc045';

/// See also [Images].
@ProviderFor(Images)
final imagesProvider = NotifierProvider<Images, ImagesState>.internal(
  Images.new,
  name: r'imagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$imagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Images = Notifier<ImagesState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
