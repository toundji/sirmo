import 'dart:convert';

class RequestExcept implements Exception {
  String? type;
  int? statusCode;
  String? error;
  String? message;
  Map<String, dynamic>? validations;
  String? path;
  RequestExcept({
    this.type,
    this.statusCode,
    this.error,
    this.message,
    this.validations,
    this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'statusCode': statusCode,
      'error': error,
      'message': message,
      'validations': validations,
      'path': path,
    };
  }

  factory RequestExcept.fromMap(Map<String, dynamic> map) {
    return RequestExcept(
      type: map['type'],
      statusCode: map['statusCode']?.toInt(),
      error: map['error'],
      message: map['message'],
      validations: Map<String, dynamic>.from(map['validations']),
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestExcept.fromJson(String source) =>
      RequestExcept.fromMap(json.decode(source));
}
