
import '/third_party/third_party.dart';
import '/constants/constants.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
class ImageModel with _$ImageModel {
  const factory ImageModel({
    @Default(Empty.INT) int id,
    @Default(Empty.STRING) String name,
    @Default(Empty.STRING) String url,
    @Default(Empty.STRING) String inpaintedUrl,
  }) = _ImageModel;

  const ImageModel._();

  bool get isUploaded => this.id != Empty.INT;

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);
}
