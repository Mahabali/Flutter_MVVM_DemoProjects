enum ApiStatus { SUCCESS, ERROR }

class ApiResponse<T> {
  T? data;
  ApiStatus? status;
  String? errorMessage;
  ApiResponse(this.data, this.status, this.errorMessage);
  bool isSuccess() {
    if (status == ApiStatus.SUCCESS) {
      return true;
    }
    return false;
  }
}
