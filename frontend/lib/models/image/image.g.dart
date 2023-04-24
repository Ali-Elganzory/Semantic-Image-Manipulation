// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ImageModel _$$_ImageModelFromJson(Map<String, dynamic> json) =>
    _$_ImageModel(
      id: json['id'] as int? ?? Empty.INT,
      name: json['name'] as String? ?? Empty.STRING,
      url: json['url'] as String? ?? Empty.STRING,
      inpaintedUrl: json['inpaintedUrl'] as String? ?? Empty.STRING,
    );

Map<String, dynamic> _$$_ImageModelToJson(_$_ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'inpaintedUrl': instance.inpaintedUrl,
    };
