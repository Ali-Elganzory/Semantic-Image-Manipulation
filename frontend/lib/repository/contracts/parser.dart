import '/models/models.dart';
import '/exceptions/exceptions.dart';

import 'repository_response.dart';

/// Parses json into models.
///
/// Can act as a model reviver.
abstract class Parser {
  /// Parses the response from the API.
  SuccessfulRepositoryResponse<Container> fromResponse<Container, Model>(
      Map<String, dynamic> json);

  /// Maps model type to its factory.
  final factories = <Type, Function(Map<String, dynamic>)>{
    ImageModel: (json) => ImageModel.fromJson(json),
    LabelModel: (json) => LabelModel.fromJson(json),
    TaskModel: (json) => TaskModel.fromJson(json),
    DetectionModel: (json) => DetectionModel.fromJson(json),
    VoidModel: (json) => VoidModel.fromJson(json),
  };

  /// Parses the [Model] contained in the
  /// [Container] from [json].
  ///
  /// The [Container] maybe the same as the [Model].
  /// In which case, the is no actual container but
  /// the [Model] itself.
  Container fromJson<Container, Model>(Object json) {
    // In case the factory for this model doesn't
    // exist, throw a failure.
    if (factories[Model] == null) {
      throw Failure(
        "The factory for the model ($Model) doesn't exist.\nAdd the model factory to [factories] in the [ParserBase].",
      );
    }

    // If the [Container] doesn't match the [json],
    // throw an exception.
    if (_isList(Container) ^ (json is List)) {
      throw Failure(
        "Model (${_isList(Container) ? 'List' : 'Not List'}) doesn't match"
        " incoming data (${json is List ? 'List' : 'Not List'}).",
      );
    }

    // Else, parse the [json] normally.
    if (_isList(Container)) {
      return (json as List).map<Model>((e) => factories[Model]!(e)).toList()
          as Container;
    } else {
      return factories[Model]!(json as Map<String, dynamic>) as Container;
    }
  }

  /// Checks whether [t] is a subtype
  /// of [List] or not.
  bool _isList(Type t) {
    return t.toString().startsWith('List');
  }
}
