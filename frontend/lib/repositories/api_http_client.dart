import '/models/models.dart';
import '/exceptions/failure.dart';
import '/third_party/third_party.dart';
import 'contracts/repository_response.dart';
import 'contracts/http_client.dart';
import 'contracts/parser.dart';
import 'api_parser.dart';
import 'dio_proxy.dart';

class ApiHttpClient implements HttpClient {
  final DioProxy _dio = DioProxy();
  final Parser _parser = ApiParser();

  @override
  RepositoryResponse<Result> get<Result, Model>({
    required String path,
  }) async {
    return _handleApiResponse<Result, Model>(
      () => _dio.get(
        url: path,
      ),
    );
  }

  @override
  RepositoryResponse<Result> post<Result, Model>({
    required String path,
    Map<String, dynamic> payload = const {},
  }) async {
    return _handleApiResponse<Result, Model>(
      () => _dio.post(
        url: path,
        data: payload,
      ),
    );
  }

  RepositoryResponse<Result> _handleApiResponse<Result, Model>(
    Future<Response<dynamic>> Function() apiCall,
  ) async {
    try {
      final Response<dynamic> response = await apiCall();

      var data = response.data;

      if (data['data'] != null) {
        return Right(_parser.fromResponse<Result, Model>(data));
      } else if (Model == VoidModel) {
        data['data'] = <String, dynamic>{};
        return Right(_parser.fromResponse<Result, Model>(data));
      } else {
        throw Failure(data['message'] ?? 'Something went wrong');
      }
    } on Failure catch (failure, stackTrace) {
      return Left(
        Failure(
          failure.message,
          failure.exception,
          stackTrace,
        ),
      );
    } catch (error, stackTrace) {
      return Left(
        Failure(
          'Something went wrong',
          Exception(error),
          stackTrace,
        ),
      );
    }
  }
}
