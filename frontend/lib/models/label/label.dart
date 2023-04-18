import 'package:freezed_annotation/freezed_annotation.dart';

import '/constants/constants.dart';

part 'label.freezed.dart';
part 'label.g.dart';

@freezed
class Label with _$Label {
  const factory Label({
    @Default(Empty.INT) int id,
    required int index,
    required String name,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}
