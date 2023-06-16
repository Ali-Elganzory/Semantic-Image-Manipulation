import '/third_party/third_party.dart';
import '/constants/constants.dart';

part 'modified_image.freezed.dart';
part 'modified_image.g.dart';

@freezed
class ModifiedImageModel with _$ModifiedImageModel {
  const factory ModifiedImageModel({
    @Default(Empty.INT) int id,
    @Default(Empty.STRING) String url,
    @Default(Empty.STRING) String prompt,
  }) = _ModifiedImageModel;

  const ModifiedImageModel._();

  factory ModifiedImageModel.fromJson(Map<String, dynamic> json) =>
      _$ModifiedImageModelFromJson(json);
}
