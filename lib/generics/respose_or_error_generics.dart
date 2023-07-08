class ResponseOrError<T> {
  ResponseOrError.success({required this.response});
  ResponseOrError.failure({required this.errorInfo});

  T? response;
  String? errorInfo;
}
