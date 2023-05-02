import '/third_party/third_party.dart';

part 'detection.freezed.dart';
part 'detection.g.dart';

@freezed
class DetectionModel with _$DetectionModel {
  const factory DetectionModel({
    required int id,
    required int labelId,
    required String label,
    required double confidence,
    required int x,
    required int y,
    required int w,
    required int h,
    @Default(0) double xp,
    @Default(0) double yp,
    @Default(0) double wp,
    @Default(0) double hp,
  }) = _DetectionModel;

  factory DetectionModel.fromJson(Map<String, dynamic> json) =>
      _$DetectionModelFromJson(json);
}
