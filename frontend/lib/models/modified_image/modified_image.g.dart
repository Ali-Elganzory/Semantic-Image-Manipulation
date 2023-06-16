// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modified_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ModifiedImageModel _$$_ModifiedImageModelFromJson(
        Map<String, dynamic> json) =>
    _$_ModifiedImageModel(
      id: json['id'] as int? ?? Empty.INT,
      url: json['url'] as String? ?? Empty.STRING,
      prompt: json['prompt'] as String? ?? Empty.STRING,
    );

Map<String, dynamic> _$$_ModifiedImageModelToJson(
        _$_ModifiedImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'prompt': instance.prompt,
    };
