import 'package:dio/dio.dart';
import 'package:morshd/core/networking/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(code: "Connection to server failed");
        case DioExceptionType.cancel:
          return ApiErrorModel(code: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(code: "Connection timeout with the server");
        case DioExceptionType.unknown:
          return ApiErrorModel(
              code:
                  "Connection to the server failed due to internet connection");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              code: "Receive timeout in connection with the server");
        case DioExceptionType.badResponse:
          return _handlerError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              code: "Send timeout in connection with the server");
        default:
          return ApiErrorModel(code: "Something went wrong");
      }
    } else {
      return ApiErrorModel(code: "Unexpected error occurred");
    }
  }

  static ApiErrorModel _handlerError(dynamic data) {
    if (data != null && data is List) {
      return ApiErrorModel.fromList(data);
    }

    return ApiErrorModel(
      code: data['code'],
      description: data['description'],
    );
  }
}
