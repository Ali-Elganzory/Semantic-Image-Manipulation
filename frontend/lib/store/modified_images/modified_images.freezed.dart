// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modified_images.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModifiedImagesState {
  List<ModifiedImageModel> get editingImages =>
      throw _privateConstructorUsedError;
  bool get isLoadingEditingImages => throw _privateConstructorUsedError;
  bool get isLoadingEditingTaskImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModifiedImagesStateCopyWith<ModifiedImagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModifiedImagesStateCopyWith<$Res> {
  factory $ModifiedImagesStateCopyWith(
          ModifiedImagesState value, $Res Function(ModifiedImagesState) then) =
      _$ModifiedImagesStateCopyWithImpl<$Res, ModifiedImagesState>;
  @useResult
  $Res call(
      {List<ModifiedImageModel> editingImages,
      bool isLoadingEditingImages,
      bool isLoadingEditingTaskImage});
}

/// @nodoc
class _$ModifiedImagesStateCopyWithImpl<$Res, $Val extends ModifiedImagesState>
    implements $ModifiedImagesStateCopyWith<$Res> {
  _$ModifiedImagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editingImages = null,
    Object? isLoadingEditingImages = null,
    Object? isLoadingEditingTaskImage = null,
  }) {
    return _then(_value.copyWith(
      editingImages: null == editingImages
          ? _value.editingImages
          : editingImages // ignore: cast_nullable_to_non_nullable
              as List<ModifiedImageModel>,
      isLoadingEditingImages: null == isLoadingEditingImages
          ? _value.isLoadingEditingImages
          : isLoadingEditingImages // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingEditingTaskImage: null == isLoadingEditingTaskImage
          ? _value.isLoadingEditingTaskImage
          : isLoadingEditingTaskImage // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModifiedImagesStateCopyWith<$Res>
    implements $ModifiedImagesStateCopyWith<$Res> {
  factory _$$_ModifiedImagesStateCopyWith(_$_ModifiedImagesState value,
          $Res Function(_$_ModifiedImagesState) then) =
      __$$_ModifiedImagesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ModifiedImageModel> editingImages,
      bool isLoadingEditingImages,
      bool isLoadingEditingTaskImage});
}

/// @nodoc
class __$$_ModifiedImagesStateCopyWithImpl<$Res>
    extends _$ModifiedImagesStateCopyWithImpl<$Res, _$_ModifiedImagesState>
    implements _$$_ModifiedImagesStateCopyWith<$Res> {
  __$$_ModifiedImagesStateCopyWithImpl(_$_ModifiedImagesState _value,
      $Res Function(_$_ModifiedImagesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editingImages = null,
    Object? isLoadingEditingImages = null,
    Object? isLoadingEditingTaskImage = null,
  }) {
    return _then(_$_ModifiedImagesState(
      editingImages: null == editingImages
          ? _value._editingImages
          : editingImages // ignore: cast_nullable_to_non_nullable
              as List<ModifiedImageModel>,
      isLoadingEditingImages: null == isLoadingEditingImages
          ? _value.isLoadingEditingImages
          : isLoadingEditingImages // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingEditingTaskImage: null == isLoadingEditingTaskImage
          ? _value.isLoadingEditingTaskImage
          : isLoadingEditingTaskImage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ModifiedImagesState implements _ModifiedImagesState {
  const _$_ModifiedImagesState(
      {required final List<ModifiedImageModel> editingImages,
      required this.isLoadingEditingImages,
      required this.isLoadingEditingTaskImage})
      : _editingImages = editingImages;

  final List<ModifiedImageModel> _editingImages;
  @override
  List<ModifiedImageModel> get editingImages {
    if (_editingImages is EqualUnmodifiableListView) return _editingImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editingImages);
  }

  @override
  final bool isLoadingEditingImages;
  @override
  final bool isLoadingEditingTaskImage;

  @override
  String toString() {
    return 'ModifiedImagesState(editingImages: $editingImages, isLoadingEditingImages: $isLoadingEditingImages, isLoadingEditingTaskImage: $isLoadingEditingTaskImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModifiedImagesState &&
            const DeepCollectionEquality()
                .equals(other._editingImages, _editingImages) &&
            (identical(other.isLoadingEditingImages, isLoadingEditingImages) ||
                other.isLoadingEditingImages == isLoadingEditingImages) &&
            (identical(other.isLoadingEditingTaskImage,
                    isLoadingEditingTaskImage) ||
                other.isLoadingEditingTaskImage == isLoadingEditingTaskImage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_editingImages),
      isLoadingEditingImages,
      isLoadingEditingTaskImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModifiedImagesStateCopyWith<_$_ModifiedImagesState> get copyWith =>
      __$$_ModifiedImagesStateCopyWithImpl<_$_ModifiedImagesState>(
          this, _$identity);
}

abstract class _ModifiedImagesState implements ModifiedImagesState {
  const factory _ModifiedImagesState(
      {required final List<ModifiedImageModel> editingImages,
      required final bool isLoadingEditingImages,
      required final bool isLoadingEditingTaskImage}) = _$_ModifiedImagesState;

  @override
  List<ModifiedImageModel> get editingImages;
  @override
  bool get isLoadingEditingImages;
  @override
  bool get isLoadingEditingTaskImage;
  @override
  @JsonKey(ignore: true)
  _$$_ModifiedImagesStateCopyWith<_$_ModifiedImagesState> get copyWith =>
      throw _privateConstructorUsedError;
}
