import 'contracts/parser.dart';
import 'contracts/repository_response.dart';

class ApiParser extends Parser {
  @override
  SuccessfulRepositoryResponse<Container> fromResponse<Container, Model>(
      Map<String, dynamic> json) {
    return SuccessfulRepositoryResponse(
      message: json['message'] ?? '',
      data: fromJson<Container, Model>(json['data']),
    );
  }
}