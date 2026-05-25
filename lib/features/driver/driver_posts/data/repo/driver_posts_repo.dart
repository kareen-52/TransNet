  import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';

class DriverPostsRepo {
  final ApiService _apiService;

  DriverPostsRepo(this._apiService);

  Future<ApiResult<List<PostModel>>> getSuitablePosts() async {
    try {
      final response = await _apiService.getSuitablePostsForDriver();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}