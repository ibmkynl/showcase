class ResponseModel {
  final int statusCode;
  Map? body;
  String? message;

  ResponseModel({required this.statusCode, this.body, this.message});
}
