import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/client_post_model.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';

class CreatePostRepo {
  final ApiService _apiService;
  CreatePostRepo(this._apiService);

  // الخطوة الأولى: إنشاء الإعلان وجلب الأسعار المقترحة
  Future<ApiResult<ClientPostModel>> createPost(Map<String, dynamic> requestBody) async {
    try {
      final response = await _apiService.createPost(requestBody);
      // الباك إند يعيد البيانات داخل مفتاح 'data'
      final post = ClientPostModel.fromJson(response['data']);
      return ApiResult.success(post);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // الخطوة الثانية: تأكيد أو تعديل الأسعار
  Future<ApiResult<String>> updatePrices({
    required int postId,
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      final response = await _apiService.updatePostPrices({
        'post_id': postId,
        'min_price': minPrice,
        'max_price': maxPrice,
      });
      return ApiResult.success(response['message'] ?? 'تم نشر الإعلان بنجاح');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  Future<ApiResult<List<GovernorateModel>>> getGovernorates() async {
    try {
      final response = await _apiService.getGovernorates();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}