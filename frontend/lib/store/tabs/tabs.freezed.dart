// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tabs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Tab {
  IconData get icon => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  bool get isDisabled => throw _privateConstructorUsedError;
  String get disabledTooltip => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TabCopyWith<Tab> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabCopyWith<$Res> {
  factory $TabCopyWith(Tab value, $Res Function(Tab) then) =
      _$TabCopyWithImpl<$Res, Tab>;
  @useResult
  $Res call(
      {IconData icon, String label, bool isDisabled, String disabledTooltip});
}

/// @nodoc
class _$TabCopyWithImpl<$Res, $Val extends Tab> implements $TabCopyWith<$Res> {
  _$TabCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? label = null,
    Object? isDisabled = null,
    Object? disabledTooltip = null,
  }) {
    return _then(_value.copyWith(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      isDisabled: null == isDisabled
          ? _value.isDisabled
          : isDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      disabledTooltip: null == disabledTooltip
          ? _value.disabledTooltip
          : disabledTooltip // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TabCopyWith<$Res> implements $TabCopyWith<$Res> {
  factory _$$_TabCopyWith(_$_Tab value, $Res Function(_$_Tab) then) =
      __$$_TabCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IconData icon, String label, bool isDisabled, String disabledTooltip});
}

/// @nodoc
class __$$_TabCopyWithImpl<$Res> extends _$TabCopyWithImpl<$Res, _$_Tab>
    implements _$$_TabCopyWith<$Res> {
  __$$_TabCopyWithImpl(_$_Tab _value, $Res Function(_$_Tab) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? label = null,
    Object? isDisabled = null,
    Object? disabledTooltip = null,
  }) {
    return _then(_$_Tab(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      isDisabled: null == isDisabled
          ? _value.isDisabled
          : isDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      disabledTooltip: null == disabledTooltip
          ? _value.disabledTooltip
          : disabledTooltip // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Tab extends _Tab {
  const _$_Tab(
      {required this.icon,
      required this.label,
      this.isDisabled = false,
      this.disabledTooltip = Empty.STRING})
      : super._();

  @override
  final IconData icon;
  @override
  final String label;
  @override
  @JsonKey()
  final bool isDisabled;
  @override
  @JsonKey()
  final String disabledTooltip;

  @override
  String toString() {
    return 'Tab(icon: $icon, label: $label, isDisabled: $isDisabled, disabledTooltip: $disabledTooltip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Tab &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.isDisabled, isDisabled) ||
                other.isDisabled == isDisabled) &&
            (identical(other.disabledTooltip, disabledTooltip) ||
                other.disabledTooltip == disabledTooltip));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, icon, label, isDisabled, disabledTooltip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TabCopyWith<_$_Tab> get copyWith =>
      __$$_TabCopyWithImpl<_$_Tab>(this, _$identity);
}

abstract class _Tab extends Tab {
  const factory _Tab(
      {required final IconData icon,
      required final String label,
      final bool isDisabled,
      final String disabledTooltip}) = _$_Tab;
  const _Tab._() : super._();

  @override
  IconData get icon;
  @override
  String get label;
  @override
  bool get isDisabled;
  @override
  String get disabledTooltip;
  @override
  @JsonKey(ignore: true)
  _$$_TabCopyWith<_$_Tab> get copyWith => throw _privateConstructorUsedError;
}
