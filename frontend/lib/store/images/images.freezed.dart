// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'images.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImagesState {
  List<ImageModel> get images => throw _privateConstructorUsedError;
  ImageModel get selected => throw _privateConstructorUsedError;
  String get searchTerm => throw _privateConstructorUsedError;
  bool get isLoadingImages => throw _privateConstructorUsedError;
  bool get isUploadingImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImagesStateCopyWith<ImagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesStateCopyWith<$Res> {
  factory $ImagesStateCopyWith(
          ImagesState value, $Res Function(ImagesState) then) =
      _$ImagesStateCopyWithImpl<$Res, ImagesState>;
  @useResult
  $Res call(
      {List<ImageModel> images,
      ImageModel selected,
      String searchTerm,
      bool isLoadingImages,
      bool isUploadingImage});

  $ImageModelCopyWith<$Res> get selected;
}

/// @nodoc
class _$ImagesStateCopyWithImpl<$Res, $Val extends ImagesState>
    implements $ImagesStateCopyWith<$Res> {
  _$ImagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? selected = null,
    Object? searchTerm = null,
    Object? isLoadingImages = null,
    Object? isUploadingImage = null,
  }) {
    return _then(_value.copyWith(
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as ImageModel,
      searchTerm: null == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      isLoadingImages: null == isLoadingImages
          ? _value.isLoadingImages
          : isLoadingImages // ignore: cast_nullable_to_non_nullable
              as bool,
      isUploadingImage: null == isUploadingImage
          ? _value.isUploadingImage
          : isUploadingImage // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageModelCopyWith<$Res> get selected {
    return $ImageModelCopyWith<$Res>(_value.selected, (value) {
      return _then(_value.copyWith(selected: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ImagesStateCopyWith<$Res>
    implements $ImagesStateCopyWith<$Res> {
  factory _$$_ImagesStateCopyWith(
          _$_ImagesState value, $Res Function(_$_ImagesState) then) =
      __$$_ImagesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ImageModel> images,
      ImageModel selected,
      String searchTerm,
      bool isLoadingImages,
      bool isUploadingImage});

  @override
  $ImageModelCopyWith<$Res> get selected;
}

/// @nodoc
class __$$_ImagesStateCopyWithImpl<$Res>
    extends _$ImagesStateCopyWithImpl<$Res, _$_ImagesState>
    implements _$$_ImagesStateCopyWith<$Res> {
  __$$_ImagesStateCopyWithImpl(
      _$_ImagesState _value, $Res Function(_$_ImagesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? selected = null,
    Object? searchTerm = null,
    Object? isLoadingImages = null,
    Object? isUploadingImage = null,
  }) {
    return _then(_$_ImagesState(
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as ImageModel,
      searchTerm: null == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      isLoadingImages: null == isLoadingImages
          ? _value.isLoadingImages
          : isLoadingImages // ignore: cast_nullable_to_non_nullable
              as bool,
      isUploadingImage: null == isUploadingImage
          ? _value.isUploadingImage
          : isUploadingImage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ImagesState extends _ImagesState {
  const _$_ImagesState(
      {required final List<ImageModel> images,
      required this.selected,
      required this.searchTerm,
      required this.isLoadingImages,
      required this.isUploadingImage})
      : _images = images,
        super._();

  final List<ImageModel> _images;
  @override
  List<ImageModel> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final ImageModel selected;
  @override
  final String searchTerm;
  @override
  final bool isLoadingImages;
  @override
  final bool isUploadingImage;

  @override
  String toString() {
    return 'ImagesState(images: $images, selected: $selected, searchTerm: $searchTerm, isLoadingImages: $isLoadingImages, isUploadingImage: $isUploadingImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImagesState &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.searchTerm, searchTerm) ||
                other.searchTerm == searchTerm) &&
            (identical(other.isLoadingImages, isLoadingImages) ||
                other.isLoadingImages == isLoadingImages) &&
            (identical(other.isUploadingImage, isUploadingImage) ||
                other.isUploadingImage == isUploadingImage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_images),
      selected,
      searchTerm,
      isLoadingImages,
      isUploadingImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImagesStateCopyWith<_$_ImagesState> get copyWith =>
      __$$_ImagesStateCopyWithImpl<_$_ImagesState>(this, _$identity);
}

abstract class _ImagesState extends ImagesState {
  const factory _ImagesState(
      {required final List<ImageModel> images,
      required final ImageModel selected,
      required final String searchTerm,
      required final bool isLoadingImages,
      required final bool isUploadingImage}) = _$_ImagesState;
  const _ImagesState._() : super._();

  @override
  List<ImageModel> get images;
  @override
  ImageModel get selected;
  @override
  String get searchTerm;
  @override
  bool get isLoadingImages;
  @override
  bool get isUploadingImage;
  @override
  @JsonKey(ignore: true)
  _$$_ImagesStateCopyWith<_$_ImagesState> get copyWith =>
      throw _privateConstructorUsedError;
}
