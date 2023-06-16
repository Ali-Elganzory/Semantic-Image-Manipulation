class ApiUrl {
  static const String base = 'http://localhost:3002/';

  static const String getImages = 'images/';
  static const String putImage = 'images';
  static const String postImage = 'images/';

  static const String getTasks = 'tasks/image';
  static const String getTask = 'tasks';

  static const String _detections = 'detections/';
  static const String getLabels = '${_detections}labels';
  static const String detect = _detections;
  static const String getDetectionsByTask = '${_detections}task';

  static const String _editing = 'editing/';
  static const String edit = _editing;
  static const String getEditsByImage = '${_editing}image';
  static const String getEditByTask = '${_editing}task';
}
