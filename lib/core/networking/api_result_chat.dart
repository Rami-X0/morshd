abstract class ApiResultChat<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  });
}

class ApiSuccessChat<T> extends ApiResultChat<T> {
  final T data;

  ApiSuccessChat(this.data);

  @override
  R when<R>(
      {required R Function(T data) success,
        required R Function(String message) failure}) {
    return success(data);
  }
}

class ApiFailureChat<T> extends ApiResultChat<T> {
  final String message;

  ApiFailureChat(this.message);

  @override
  R when<R>(
      {required R Function(T data) success,
        required R Function(String message) failure}) {
    return failure(message);
  }
}
