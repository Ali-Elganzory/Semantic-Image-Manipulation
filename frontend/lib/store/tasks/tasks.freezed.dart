// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasksState {
  List<TaskModel> get tasks => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksStateCopyWith<TasksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksStateCopyWith<$Res> {
  factory $TasksStateCopyWith(
          TasksState value, $Res Function(TasksState) then) =
      _$TasksStateCopyWithImpl<$Res, TasksState>;
  @useResult
  $Res call({List<TaskModel> tasks, bool isLoading});
}

/// @nodoc
class _$TasksStateCopyWithImpl<$Res, $Val extends TasksState>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TasksStateCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$$_TasksStateCopyWith(
          _$_TasksState value, $Res Function(_$_TasksState) then) =
      __$$_TasksStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TaskModel> tasks, bool isLoading});
}

/// @nodoc
class __$$_TasksStateCopyWithImpl<$Res>
    extends _$TasksStateCopyWithImpl<$Res, _$_TasksState>
    implements _$$_TasksStateCopyWith<$Res> {
  __$$_TasksStateCopyWithImpl(
      _$_TasksState _value, $Res Function(_$_TasksState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? isLoading = null,
  }) {
    return _then(_$_TasksState(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TasksState extends _TasksState {
  const _$_TasksState(
      {required final List<TaskModel> tasks, required this.isLoading})
      : _tasks = tasks,
        super._();

  final List<TaskModel> _tasks;
  @override
  List<TaskModel> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'TasksState(tasks: $tasks, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TasksState &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_tasks), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TasksStateCopyWith<_$_TasksState> get copyWith =>
      __$$_TasksStateCopyWithImpl<_$_TasksState>(this, _$identity);
}

abstract class _TasksState extends TasksState {
  const factory _TasksState(
      {required final List<TaskModel> tasks,
      required final bool isLoading}) = _$_TasksState;
  const _TasksState._() : super._();

  @override
  List<TaskModel> get tasks;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_TasksStateCopyWith<_$_TasksState> get copyWith =>
      throw _privateConstructorUsedError;
}
