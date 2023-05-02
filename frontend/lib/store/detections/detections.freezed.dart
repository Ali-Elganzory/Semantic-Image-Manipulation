// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detections.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DetectionsState {
  List<LabelModel> get labels => throw _privateConstructorUsedError;
  List<LabelModel> get selectedLabels => throw _privateConstructorUsedError;
  String get labelsSearchTerm => throw _privateConstructorUsedError;
  bool get isLoadingLabels => throw _privateConstructorUsedError;
  List<DetectionModel> get detections => throw _privateConstructorUsedError;
  Set<DetectionModel> get selectedDetections =>
      throw _privateConstructorUsedError;
  bool get isLoadingDetections => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetectionsStateCopyWith<DetectionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectionsStateCopyWith<$Res> {
  factory $DetectionsStateCopyWith(
          DetectionsState value, $Res Function(DetectionsState) then) =
      _$DetectionsStateCopyWithImpl<$Res, DetectionsState>;
  @useResult
  $Res call(
      {List<LabelModel> labels,
      List<LabelModel> selectedLabels,
      String labelsSearchTerm,
      bool isLoadingLabels,
      List<DetectionModel> detections,
      Set<DetectionModel> selectedDetections,
      bool isLoadingDetections});
}

/// @nodoc
class _$DetectionsStateCopyWithImpl<$Res, $Val extends DetectionsState>
    implements $DetectionsStateCopyWith<$Res> {
  _$DetectionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? selectedLabels = null,
    Object? labelsSearchTerm = null,
    Object? isLoadingLabels = null,
    Object? detections = null,
    Object? selectedDetections = null,
    Object? isLoadingDetections = null,
  }) {
    return _then(_value.copyWith(
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<LabelModel>,
      selectedLabels: null == selectedLabels
          ? _value.selectedLabels
          : selectedLabels // ignore: cast_nullable_to_non_nullable
              as List<LabelModel>,
      labelsSearchTerm: null == labelsSearchTerm
          ? _value.labelsSearchTerm
          : labelsSearchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      isLoadingLabels: null == isLoadingLabels
          ? _value.isLoadingLabels
          : isLoadingLabels // ignore: cast_nullable_to_non_nullable
              as bool,
      detections: null == detections
          ? _value.detections
          : detections // ignore: cast_nullable_to_non_nullable
              as List<DetectionModel>,
      selectedDetections: null == selectedDetections
          ? _value.selectedDetections
          : selectedDetections // ignore: cast_nullable_to_non_nullable
              as Set<DetectionModel>,
      isLoadingDetections: null == isLoadingDetections
          ? _value.isLoadingDetections
          : isLoadingDetections // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DetectionsStateCopyWith<$Res>
    implements $DetectionsStateCopyWith<$Res> {
  factory _$$_DetectionsStateCopyWith(
          _$_DetectionsState value, $Res Function(_$_DetectionsState) then) =
      __$$_DetectionsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LabelModel> labels,
      List<LabelModel> selectedLabels,
      String labelsSearchTerm,
      bool isLoadingLabels,
      List<DetectionModel> detections,
      Set<DetectionModel> selectedDetections,
      bool isLoadingDetections});
}

/// @nodoc
class __$$_DetectionsStateCopyWithImpl<$Res>
    extends _$DetectionsStateCopyWithImpl<$Res, _$_DetectionsState>
    implements _$$_DetectionsStateCopyWith<$Res> {
  __$$_DetectionsStateCopyWithImpl(
      _$_DetectionsState _value, $Res Function(_$_DetectionsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? selectedLabels = null,
    Object? labelsSearchTerm = null,
    Object? isLoadingLabels = null,
    Object? detections = null,
    Object? selectedDetections = null,
    Object? isLoadingDetections = null,
  }) {
    return _then(_$_DetectionsState(
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<LabelModel>,
      selectedLabels: null == selectedLabels
          ? _value._selectedLabels
          : selectedLabels // ignore: cast_nullable_to_non_nullable
              as List<LabelModel>,
      labelsSearchTerm: null == labelsSearchTerm
          ? _value.labelsSearchTerm
          : labelsSearchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      isLoadingLabels: null == isLoadingLabels
          ? _value.isLoadingLabels
          : isLoadingLabels // ignore: cast_nullable_to_non_nullable
              as bool,
      detections: null == detections
          ? _value._detections
          : detections // ignore: cast_nullable_to_non_nullable
              as List<DetectionModel>,
      selectedDetections: null == selectedDetections
          ? _value._selectedDetections
          : selectedDetections // ignore: cast_nullable_to_non_nullable
              as Set<DetectionModel>,
      isLoadingDetections: null == isLoadingDetections
          ? _value.isLoadingDetections
          : isLoadingDetections // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DetectionsState implements _DetectionsState {
  const _$_DetectionsState(
      {required final List<LabelModel> labels,
      required final List<LabelModel> selectedLabels,
      required this.labelsSearchTerm,
      required this.isLoadingLabels,
      required final List<DetectionModel> detections,
      required final Set<DetectionModel> selectedDetections,
      required this.isLoadingDetections})
      : _labels = labels,
        _selectedLabels = selectedLabels,
        _detections = detections,
        _selectedDetections = selectedDetections;

  final List<LabelModel> _labels;
  @override
  List<LabelModel> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  final List<LabelModel> _selectedLabels;
  @override
  List<LabelModel> get selectedLabels {
    if (_selectedLabels is EqualUnmodifiableListView) return _selectedLabels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedLabels);
  }

  @override
  final String labelsSearchTerm;
  @override
  final bool isLoadingLabels;
  final List<DetectionModel> _detections;
  @override
  List<DetectionModel> get detections {
    if (_detections is EqualUnmodifiableListView) return _detections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detections);
  }

  final Set<DetectionModel> _selectedDetections;
  @override
  Set<DetectionModel> get selectedDetections {
    if (_selectedDetections is EqualUnmodifiableSetView)
      return _selectedDetections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedDetections);
  }

  @override
  final bool isLoadingDetections;

  @override
  String toString() {
    return 'DetectionsState(labels: $labels, selectedLabels: $selectedLabels, labelsSearchTerm: $labelsSearchTerm, isLoadingLabels: $isLoadingLabels, detections: $detections, selectedDetections: $selectedDetections, isLoadingDetections: $isLoadingDetections)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetectionsState &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            const DeepCollectionEquality()
                .equals(other._selectedLabels, _selectedLabels) &&
            (identical(other.labelsSearchTerm, labelsSearchTerm) ||
                other.labelsSearchTerm == labelsSearchTerm) &&
            (identical(other.isLoadingLabels, isLoadingLabels) ||
                other.isLoadingLabels == isLoadingLabels) &&
            const DeepCollectionEquality()
                .equals(other._detections, _detections) &&
            const DeepCollectionEquality()
                .equals(other._selectedDetections, _selectedDetections) &&
            (identical(other.isLoadingDetections, isLoadingDetections) ||
                other.isLoadingDetections == isLoadingDetections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_labels),
      const DeepCollectionEquality().hash(_selectedLabels),
      labelsSearchTerm,
      isLoadingLabels,
      const DeepCollectionEquality().hash(_detections),
      const DeepCollectionEquality().hash(_selectedDetections),
      isLoadingDetections);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetectionsStateCopyWith<_$_DetectionsState> get copyWith =>
      __$$_DetectionsStateCopyWithImpl<_$_DetectionsState>(this, _$identity);
}

abstract class _DetectionsState implements DetectionsState {
  const factory _DetectionsState(
      {required final List<LabelModel> labels,
      required final List<LabelModel> selectedLabels,
      required final String labelsSearchTerm,
      required final bool isLoadingLabels,
      required final List<DetectionModel> detections,
      required final Set<DetectionModel> selectedDetections,
      required final bool isLoadingDetections}) = _$_DetectionsState;

  @override
  List<LabelModel> get labels;
  @override
  List<LabelModel> get selectedLabels;
  @override
  String get labelsSearchTerm;
  @override
  bool get isLoadingLabels;
  @override
  List<DetectionModel> get detections;
  @override
  Set<DetectionModel> get selectedDetections;
  @override
  bool get isLoadingDetections;
  @override
  @JsonKey(ignore: true)
  _$$_DetectionsStateCopyWith<_$_DetectionsState> get copyWith =>
      throw _privateConstructorUsedError;
}
