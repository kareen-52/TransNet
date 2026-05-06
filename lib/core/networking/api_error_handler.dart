import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: "فشل الاتصال بالخادم - تأكد من اتصال الإنترنت",
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "تم إلغاء الطلب");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "انتهت مهلة الاتصال بالخادم");
        case DioExceptionType.unknown:
          final errorMsg = error.error?.toString() ?? 'خطأ غير معروف';
          print('Unknown Dio Error: $errorMsg');
          return ApiErrorModel(message: "فشل الاتصال بالخادم: $errorMsg");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: "انتهت مهلة استلام البيانات");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data, error.response?.statusCode);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: "انتهت مهلة إرسال البيانات");
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: "شهادة SSL غير صالحة");
        // default:
        //   return ApiErrorModel(message: "حدث خطأ في الشبكة: ${error.type}");
      }
    } else {
      print('Non-Dio Error: $error');
      return ApiErrorModel(message: "حدث خطأ غير متوقع: ${error.toString()}");
    }
  }


  static ApiErrorModel _handleError(dynamic data, int? statusCode) {
    print('API Error - Status: $statusCode, Data: $data');

    if (data != null && data is Map<String, dynamic>) {
      if (data.containsKey('message') || data.containsKey('exception') || data.containsKey('errors')) {
         return ApiErrorModel.fromJson(data);
      }
    }

    if (statusCode == 500) {
      return ApiErrorModel(message: "خطأ في الخادم الداخلي");
    }

    if (data is Map<String, dynamic>) {
      return ApiErrorModel.fromJson(data);
    } else if (data is String) {
      return ApiErrorModel(
        message: data.isNotEmpty ? data : "حدث خطأ من الخادم",
      );
    } else {
      return ApiErrorModel(
        message: "الخادم لا يستجيب - الرجاء المحاولة لاحقاً",
      );
    }
  }
}
