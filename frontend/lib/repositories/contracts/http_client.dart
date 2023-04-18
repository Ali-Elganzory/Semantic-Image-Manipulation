import 'repository_response.dart';

abstract class HttpClient {
  RepositoryResponse<Result> get<Result, Model>({
    required String path,
  });

  RepositoryResponse<Result> post<Result, Model>({
    required String path,
    Map<String, dynamic> payload = const {},
  });
}
