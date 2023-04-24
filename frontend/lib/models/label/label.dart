import '/third_party/third_party.dart';

part 'label.freezed.dart';
part 'label.g.dart';

@freezed
class LabelModel with _$LabelModel {
  const factory LabelModel({
    required int id,
    required String name,
  }) = _LabelModel;

  factory LabelModel.fromJson(Map<String, dynamic> json) => _$LabelModelFromJson(json);
}
