// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'labels.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LabelsState {
  List<Label> get labels => throw _privateConstructorUsedError;
  List<Label> get selected => throw _privateConstructorUsedError;
  String get searchTerm => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LabelsStateCopyWith<LabelsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelsStateCopyWith<$Res> {
  factory $LabelsStateCopyWith(
          LabelsState value, $Res Function(LabelsState) then) =
      _$LabelsStateCopyWithImpl<$Res, LabelsState>;
  @useResult
  $Res call(
      {List<Label> labels,
      List<Label> selected,
      String searchTerm,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class _$LabelsStateCopyWithImpl<$Res, $Val extends LabelsState>
    implements $LabelsStateCopyWith<$Res> {
  _$LabelsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? selected = null,
    Object? searchTerm = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<Label>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as List<Label>,
      searchTerm: null == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LabelsStateCopyWith<$Res>
    implements $LabelsStateCopyWith<$Res> {
  factory _$$_LabelsStateCopyWith(
          _$_LabelsState value, $Res Function(_$_LabelsState) then) =
      __$$_LabelsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Label> labels,
      List<Label> selected,
      String searchTerm,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class __$$_LabelsStateCopyWithImpl<$Res>
    extends _$LabelsStateCopyWithImpl<$Res, _$_LabelsState>
    implements _$$_LabelsStateCopyWith<$Res> {
  __$$_LabelsStateCopyWithImpl(
      _$_LabelsState _value, $Res Function(_$_LabelsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? selected = null,
    Object? searchTerm = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_LabelsState(
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<Label>,
      selected: null == selected
          ? _value._selected
          : selected // ignore: cast_nullable_to_non_nullable
              as List<Label>,
      searchTerm: null == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LabelsState extends _LabelsState {
  const _$_LabelsState(
      {required final List<Label> labels,
      required final List<Label> selected,
      required this.searchTerm,
      required this.isLoading,
      required this.errorMessage})
      : _labels = labels,
        _selected = selected,
        super._();

  final List<Label> _labels;
  @override
  List<Label> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  final List<Label> _selected;
  @override
  List<Label> get selected {
    if (_selected is EqualUnmodifiableListView) return _selected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selected);
  }

  @override
  final String searchTerm;
  @override
  final bool isLoading;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'LabelsState(labels: $labels, selected: $selected, searchTerm: $searchTerm, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LabelsState &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            const DeepCollectionEquality().equals(other._selected, _selected) &&
            (identical(other.searchTerm, searchTerm) ||
                other.searchTerm == searchTerm) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_labels),
      const DeepCollectionEquality().hash(_selected),
      searchTerm,
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LabelsStateCopyWith<_$_LabelsState> get copyWith =>
      __$$_LabelsStateCopyWithImpl<_$_LabelsState>(this, _$identity);
}

abstract class _LabelsState extends LabelsState {
  const factory _LabelsState(
      {required final List<Label> labels,
      required final List<Label> selected,
      required final String searchTerm,
      required final bool isLoading,
      required final String errorMessage}) = _$_LabelsState;
  const _LabelsState._() : super._();

  @override
  List<Label> get labels;
  @override
  List<Label> get selected;
  @override
  String get searchTerm;
  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_LabelsStateCopyWith<_$_LabelsState> get copyWith =>
      throw _privateConstructorUsedError;
}
