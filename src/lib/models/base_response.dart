class BaseResponse<T> {
  String? exceptionMessage;
  bool? success;
  T? data;
  String? successMessage;

  BaseResponse(String exceptionMessage, bool success, T data) {
    this.exceptionMessage = exceptionMessage;
    this.success = success;
    this.data = data;
    this.successMessage = successMessage;
  }

  BaseResponse.fromJson(Map json) {
    exceptionMessage = json["exceptionMessage"];
    success = json["success"];
    data = json["data"];
    successMessage = json["successMessage"];
  }
}
