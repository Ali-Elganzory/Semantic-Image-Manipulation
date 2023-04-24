// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetectionModel _$$_DetectionModelFromJson(Map<String, dynamic> json) =>
    _$_DetectionModel(
      id: json['id'] as int,
      labelId: json['labelId'] as int,
      label: json['label'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      x: json['x'] as int,
      y: json['y'] as int,
      w: json['w'] as int,
      h: json['h'] as int,
    );

Map<String, dynamic> _$$_DetectionModelToJson(_$_DetectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'labelId': instance.labelId,
      'label': instance.label,
      'confidence': instance.confidence,
      'x': instance.x,
      'y': instance.y,
      'w': instance.w,
      'h': instance.h,
    };
