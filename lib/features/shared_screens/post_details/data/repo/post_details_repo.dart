import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import '../models/post_details_model.dart';

class PostDetailsRepo {
  final ApiService _apiService;
  
  PostDetailsRepo(this._apiService);

  Future<ApiResult<PostDetailsModel>> getPostDetails(int id) async {
    try {
      final response = await _apiService.getPostDetails(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> acceptDriverOffer(int postId, int driverId) async {
    try {
      final response = await _apiService.chooseDriverForPost({
        'post_id': postId,
        'driver_id': driverId,
      });
      return ApiResult.success(response['message'] ?? 'تم قبول العرض بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}