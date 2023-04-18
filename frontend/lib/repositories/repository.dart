import 'package:frontend/repositories/api_url.dart';
import 'package:frontend/repositories/contracts/repository_response.dart';

import 'api_http_client.dart';
import '/models/models.dart';

class ApiRepository {
  final ApiHttpClient _apiHttpClient = ApiHttpClient();

  RepositoryResponse<List<Label>> getLabels() async {
    return _apiHttpClient.get<List<Label>, Label>(
      path: ApiUrl.labels,
    );
  }
}