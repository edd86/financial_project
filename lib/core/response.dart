class Response<T> {
  final bool success;
  final T? data;
  final String message;

  Response({required this.success, this.data, this.message = ''});

  factory Response.success(T data, {String message = ''}) =>
      Response<T>(success: true, data: data, message: message);
  factory Response.error(String message) =>
      Response<T>(success: false, message: message);
}
