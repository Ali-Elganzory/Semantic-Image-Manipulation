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

  RepositoryResponse<List<TaskModel>> getTasks(int imageId) {
    return _apiHttpClient.get<List<TaskModel>, TaskModel>(
      path: '${ApiUrl.getTasks}/$imageId',
    );
  }

  RepositoryResponse<TaskModel> getTask(int taskId) {
    return _apiHttpClient.get<TaskModel, TaskModel>(
      path: '${ApiUrl.getTask}/$taskId',
    );
  }

  RepositoryResponse<List<DetectionModel>> getDetectionsByTask(int taskId) {
    return _apiHttpClient.get<List<DetectionModel>, DetectionModel>(
      path: '${ApiUrl.getDetectionsByTask}/$taskId',
    );
  }

  RepositoryResponse<TaskModel> detect(
    int imageId,
    List<int> labelIds,
  ) {
    return _apiHttpClient.post<TaskModel, TaskModel>(
      path: ApiUrl.detect,
      payload: {
        'image_id': imageId,
        'label_ids': labelIds,
      },
    );
  }

  RepositoryResponse<TaskModel> inpaint(
    int imageId,
    List<int> detectionIds,
    bool extremeMode,
  ) {
    return _apiHttpClient.post<TaskModel, TaskModel>(
      path: ApiUrl.inpaint,
      payload: {
        'image_id': imageId,
        'detection_ids': detectionIds,
        'extreme_mode': extremeMode,
      },
    );
  }

  RepositoryResponse<ModifiedImageModel> getInpaintByTask(int taskId) {
    return _apiHttpClient.get<ModifiedImageModel, ModifiedImageModel>(
      path: '${ApiUrl.getInpaintByTask}/$taskId',
    );
  }

  RepositoryResponse<List<ModifiedImageModel>> getInpaintsByImage(
    int imageId,
  ) {
    return _apiHttpClient.get<List<ModifiedImageModel>, ModifiedImageModel>(
      path: '${ApiUrl.getInpaintsByImage}/$imageId',
    );
  }

  RepositoryResponse<List<ModifiedImageModel>> getEditsByImage(int imageId) {
    return _apiHttpClient.get<List<ModifiedImageModel>, ModifiedImageModel>(
      path: '${ApiUrl.getEditsByImage}/$imageId',
    );
  }

  RepositoryResponse<ModifiedImageModel> getEditByTask(int taskId) {
    return _apiHttpClient.get<ModifiedImageModel, ModifiedImageModel>(
      path: '${ApiUrl.getEditByTask}/$taskId',
    );
  }

  RepositoryResponse<TaskModel> edit(
    int imageId,
    String prompt,
  ) {
    return _apiHttpClient.post<TaskModel, TaskModel>(
      path: ApiUrl.edit,
      payload: {
        'image_id': imageId,
        'prompt': prompt,
      },
    );
  }
}
