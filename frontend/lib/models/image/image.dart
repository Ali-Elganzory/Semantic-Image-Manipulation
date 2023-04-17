import '/third_party/third_party.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
class Image with _$Image {
  const factory Image({
    required String id,
    required String name,
    required String url,
    required String editedUrl,
    required String thumbnailUrl,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
