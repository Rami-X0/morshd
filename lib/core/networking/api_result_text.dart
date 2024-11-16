abstract class ApiResultText<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  });
}

class ApiSuccessText<T> extends ApiResultText<T> {
  final T data;

  ApiSuccessText(this.data);

  @override
  R when<R>(
      {required R Function(T data) success,
      required R Function(String message) failure}) {
    return success(data);
  }
}

class ApiFailureText<T> extends ApiResultText<T> {
  final String message;

  ApiFailureText(this.message);

  @override
  R when<R>(
      {required R Function(T data) success,
      required R Function(String message) failure}) {
    return failure(message);
  }
}
