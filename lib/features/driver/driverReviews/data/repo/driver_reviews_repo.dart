import 'package:graduation_progect/connectivity_helper.dart';
import 'package:graduation_progect/core/networking/api_error_handler.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/networking/api_service.dart';
import 'package:graduation_progect/features/driver/driverReviews/data/model/review_response.dart';
import 'package:graduation_progect/hive_cache_service.dart';

class DriverReviewsRepo {
  final ApiService _apiService;

  DriverReviewsRepo(this._apiService);

  Future<ApiResult<ReviewResponse>> getDriverReviews(int driverId) async {
    final online =  ConnectivityHelper.isOnline;

    if (!online) {
      return _returnFromCache(driverId) ??
          ApiResult.failure(
            ApiErrorModel(
              message: 'لا يوجد اتصال بالإنترنت ولا توجد تقييمات محفوظة',
            ),
          );
    }

    try {
      final response = await _apiService.getDriverReviews(driverId);
      final rawMap = _reviewToJson(response);

      if (HiveCacheService.driverReviewsChanged(driverId, rawMap)) {
        await HiveCacheService.cacheDriverReviews(driverId, rawMap);
      }

      return ApiResult.success(response);
    } catch (error) {
      return _returnFromCache(driverId) ??
          ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  ApiResult<ReviewResponse>? _returnFromCache(int driverId) {
    final cached = HiveCacheService.getCachedDriverReviews(driverId);
    if (cached == null) return null;
    return ApiResult.success(ReviewResponse.fromJson(cached));
  }

  Map<String, dynamic> _reviewToJson(ReviewResponse r) {
    final data = r.data;
    return {
      'data': data == null
          ? null
          : {
              'average_rate': data.averageRate,
              'reviews_count': data.reviewsCount,
              'reviews': data.reviews
                      ?.map(
                        (rv) => {
                          'id': rv.id,
                          'user_id': rv.userId,
                          'driver_id': rv.driverId,
                          'rate': rv.rate,
                          'review': rv.review,
                          'created_at': rv.createdAt,
                          'updated_at': rv.updatedAt,
                          'user': rv.user == null
                              ? null
                              : {
                                  'id': rv.user!.id,
                                  'first_name': rv.user!.firstName,
                                  'last_name': rv.user!.lastName,
                                  'user_number': rv.user!.userNumber,
                                },
                        },
                      )
                      .toList() ??
                  [],
            },
    };
  }
}