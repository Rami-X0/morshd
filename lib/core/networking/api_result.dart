import 'package:morshd/core/networking/api_error_model.dart';

abstract class ApiResult<T> {
  R when<R>(
      {required R Function(T data) success,
      required R Function(T error) failure});
}

class ApiResultSuccess<T> extends ApiResult<T> {
  final T data;

  ApiResultSuccess({required this.data});

  @override
  R when<R>(
      {required R Function(T data) success,
      required R Function(T error) failure}) {
    return success(data);
  }
}

class ApiResultFailure<T> extends ApiResult<T> {
  final T failure;

  ApiResultFailure({required this.failure});

  @override
  R when<R>(
      {required R Function(T data) success,
      required R Function(T error) failure}) {
    return failure(this.failure);
  }
}
