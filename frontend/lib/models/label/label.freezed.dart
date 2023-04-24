// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LabelModel _$LabelModelFromJson(Map<String, dynamic> json) {
  return _LabelModel.fromJson(json);
}

/// @nodoc
mixin _$LabelModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LabelModelCopyWith<LabelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelModelCopyWith<$Res> {
  factory $LabelModelCopyWith(
          LabelModel value, $Res Function(LabelModel) then) =
      _$LabelModelCopyWithImpl<$Res, LabelModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$LabelModelCopyWithImpl<$Res, $Val extends LabelModel>
    implements $LabelModelCopyWith<$Res> {
  _$LabelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LabelModelCopyWith<$Res>
    implements $LabelModelCopyWith<$Res> {
  factory _$$_LabelModelCopyWith(
          _$_LabelModel value, $Res Function(_$_LabelModel) then) =
      __$$_LabelModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$_LabelModelCopyWithImpl<$Res>
    extends _$LabelModelCopyWithImpl<$Res, _$_LabelModel>
    implements _$$_LabelModelCopyWith<$Res> {
  __$$_LabelModelCopyWithImpl(
      _$_LabelModel _value, $Res Function(_$_LabelModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_LabelModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LabelModel implements _LabelModel {
  const _$_LabelModel({required this.id, required this.name});

  factory _$_LabelModel.fromJson(Map<String, dynamic> json) =>
      _$$_LabelModelFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'LabelModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LabelModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LabelModelCopyWith<_$_LabelModel> get copyWith =>
      __$$_LabelModelCopyWithImpl<_$_LabelModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LabelModelToJson(
      this,
    );
  }
}

abstract class _LabelModel implements LabelModel {
  const factory _LabelModel(
      {required final int id, required final String name}) = _$_LabelModel;

  factory _LabelModel.fromJson(Map<String, dynamic> json) =
      _$_LabelModel.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_LabelModelCopyWith<_$_LabelModel> get copyWith =>
      throw _privateConstructorUsedError;
}
