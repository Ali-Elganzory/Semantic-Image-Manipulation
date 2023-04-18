// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditingState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditingStateCopyWith<EditingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditingStateCopyWith<$Res> {
  factory $EditingStateCopyWith(
          EditingState value, $Res Function(EditingState) then) =
      _$EditingStateCopyWithImpl<$Res, EditingState>;
  @useResult
  $Res call({bool isLoading, String imageUrl});
}

/// @nodoc
class _$EditingStateCopyWithImpl<$Res, $Val extends EditingState>
    implements $EditingStateCopyWith<$Res> {
  _$EditingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditingStateCopyWith<$Res>
    implements $EditingStateCopyWith<$Res> {
  factory _$$_EditingStateCopyWith(
          _$_EditingState value, $Res Function(_$_EditingState) then) =
      __$$_EditingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String imageUrl});
}

/// @nodoc
class __$$_EditingStateCopyWithImpl<$Res>
    extends _$EditingStateCopyWithImpl<$Res, _$_EditingState>
    implements _$$_EditingStateCopyWith<$Res> {
  __$$_EditingStateCopyWithImpl(
      _$_EditingState _value, $Res Function(_$_EditingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_EditingState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_EditingState extends _EditingState {
  const _$_EditingState({required this.isLoading, required this.imageUrl})
      : super._();

  @override
  final bool isLoading;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'EditingState(isLoading: $isLoading, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditingState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditingStateCopyWith<_$_EditingState> get copyWith =>
      __$$_EditingStateCopyWithImpl<_$_EditingState>(this, _$identity);
}

abstract class _EditingState extends EditingState {
  const factory _EditingState(
      {required final bool isLoading,
      required final String imageUrl}) = _$_EditingState;
  const _EditingState._() : super._();

  @override
  bool get isLoading;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_EditingStateCopyWith<_$_EditingState> get copyWith =>
      throw _privateConstructorUsedError;
}
