// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetectionModel _$$_DetectionModelFromJson(Map<String, dynamic> json) =>
    _$_DetectionModel(
      id: json['id'] as int,
      labelId: json['label_id'] as int,
      label: json['label'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      x: json['x'] as int,
      y: json['y'] as int,
      w: json['w'] as int,
      h: json['h'] as int,
      xp: (json['xp'] as num?)?.toDouble() ?? 0,
      yp: (json['yp'] as num?)?.toDouble() ?? 0,
      wp: (json['wp'] as num?)?.toDouble() ?? 0,
      hp: (json['hp'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_DetectionModelToJson(_$_DetectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label_id': instance.labelId,
      'label': instance.label,
      'confidence': instance.confidence,
      'x': instance.x,
      'y': instance.y,
      'w': instance.w,
      'h': instance.h,
      'xp': instance.xp,
      'yp': instance.yp,
      'wp': instance.wp,
      'hp': instance.hp,
    };
