class VoidModel {
  VoidModel();

  factory VoidModel.fromJson(Map<String, dynamic> json) {
    return VoidModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}