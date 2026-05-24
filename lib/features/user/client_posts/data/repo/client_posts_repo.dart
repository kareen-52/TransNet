import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/client_post_model.dart';

class ClientPostsRepo {
  final ApiService _apiService;

  ClientPostsRepo(this._apiService);

  Future<ApiResult<List<ClientPostModel>>> getMyPosts() async {
    try {
      final response = await _apiService.getClientPosts();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}