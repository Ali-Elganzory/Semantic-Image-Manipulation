// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      id: json['id'] as int,
      imageId: json['image_id'] as int,
      type: $enumDecode(_$TaskTypeEnumMap, json['type']),
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_id': instance.imageId,
      'type': _$TaskTypeEnumMap[instance.type]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
    };

const _$TaskTypeEnumMap = {
  TaskType.detection: 'detection',
  TaskType.inpainting: 'inpainting',
  TaskType.editing: 'editing',
};

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.running: 'running',
  TaskStatus.success: 'success',
  TaskStatus.error: 'error',
};
