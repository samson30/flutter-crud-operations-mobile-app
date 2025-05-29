//this is where I generate the response. For realtime cloud database we can extend upon this furthermore.
class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final String? errorMessage;

  ApiResponse.success(this.data) : statusCode = 200, errorMessage = null;

  ApiResponse.error(this.errorMessage, {this.statusCode = 500}) : data = null;
}
