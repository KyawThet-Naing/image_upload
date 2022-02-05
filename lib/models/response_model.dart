class ResponseModel {
  num status;
  dynamic data;
  bool success;

  ResponseModel({
    required this.status,
    required this.data,
    required this.success,
  });
}
