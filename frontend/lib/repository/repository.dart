import '/third_party/third_party.dart';
import '/repository/api_url.dart';
import '/repository/contracts/repository_response.dart';
import '/models/models.dart';
import 'api_http_client.dart';

class ApiRepository {
  final ApiHttpClient _apiHttpClient = ApiHttpClient();

  RepositoryResponse<List<LabelModel>> getLabels() {
    return _apiHttpClient.get<List<LabelModel>, LabelModel>(
      path: ApiUrl.getLabels,
    );
  }

  RepositoryResponse<List<ImageModel>> getImages() {
    return _apiHttpClient.get<List<ImageModel>, ImageModel>(
      path: ApiUrl.getImages,
    );
  }

  RepositoryResponse<VoidModel> putImage({
    required int id,
    required String name,
  }) {
    return _apiHttpClient.put<VoidModel, VoidModel>(
      path: '${ApiUrl.putImage}/$id',
      payload: {
        'name': name,
      },
    );
  }

  RepositoryResponse<ImageModel> postImage({
    required String name,
    required List<int> bytes,
  }) {
    return _apiHttpClient.post<ImageModel, ImageModel>(
      path: ApiUrl.postImage,
      payload: FormData.fromMap({
        'file': [
          MultipartFile.fromBytes(
            bytes,
            contentType: MediaType('image', 'jpg'),
            filename: name,
          ),
        ]
      }),
      isFile: true,
    );
  }
}
