// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modified_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ModifiedImageModel _$ModifiedImageModelFromJson(Map<String, dynamic> json) {
  return _ModifiedImageModel.fromJson(json);
}

/// @nodoc
mixin _$ModifiedImageModel {
  int get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModifiedImageModelCopyWith<ModifiedImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModifiedImageModelCopyWith<$Res> {
  factory $ModifiedImageModelCopyWith(
          ModifiedImageModel value, $Res Function(ModifiedImageModel) then) =
      _$ModifiedImageModelCopyWithImpl<$Res, ModifiedImageModel>;
  @useResult
  $Res call({int id, String url, String prompt});
}

/// @nodoc
class _$ModifiedImageModelCopyWithImpl<$Res, $Val extends ModifiedImageModel>
    implements $ModifiedImageModelCopyWith<$Res> {
  _$ModifiedImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? prompt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModifiedImageModelCopyWith<$Res>
    implements $ModifiedImageModelCopyWith<$Res> {
  factory _$$_ModifiedImageModelCopyWith(_$_ModifiedImageModel value,
          $Res Function(_$_ModifiedImageModel) then) =
      __$$_ModifiedImageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String url, String prompt});
}

/// @nodoc
class __$$_ModifiedImageModelCopyWithImpl<$Res>
    extends _$ModifiedImageModelCopyWithImpl<$Res, _$_ModifiedImageModel>
    implements _$$_ModifiedImageModelCopyWith<$Res> {
  __$$_ModifiedImageModelCopyWithImpl(
      _$_ModifiedImageModel _value, $Res Function(_$_ModifiedImageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? prompt = null,
  }) {
    return _then(_$_ModifiedImageModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ModifiedImageModel extends _ModifiedImageModel {
  const _$_ModifiedImageModel(
      {this.id = Empty.INT,
      this.url = Empty.STRING,
      this.prompt = Empty.STRING})
      : super._();

  factory _$_ModifiedImageModel.fromJson(Map<String, dynamic> json) =>
      _$$_ModifiedImageModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final String prompt;

  @override
  String toString() {
    return 'ModifiedImageModel(id: $id, url: $url, prompt: $prompt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModifiedImageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, prompt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModifiedImageModelCopyWith<_$_ModifiedImageModel> get copyWith =>
      __$$_ModifiedImageModelCopyWithImpl<_$_ModifiedImageModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ModifiedImageModelToJson(
      this,
    );
  }
}

abstract class _ModifiedImageModel extends ModifiedImageModel {
  const factory _ModifiedImageModel(
      {final int id,
      final String url,
      final String prompt}) = _$_ModifiedImageModel;
  const _ModifiedImageModel._() : super._();

  factory _ModifiedImageModel.fromJson(Map<String, dynamic> json) =
      _$_ModifiedImageModel.fromJson;

  @override
  int get id;
  @override
  String get url;
  @override
  String get prompt;
  @override
  @JsonKey(ignore: true)
  _$$_ModifiedImageModelCopyWith<_$_ModifiedImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
