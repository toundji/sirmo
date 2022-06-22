class RequestException implements Exception {
  String? type;
  int? statusCode;
  String? error;
  String? message;
  String? path;
}

class ExecptionTarget {
  dynamic target;
  String? property;
  List<dynamic>? children;
  Map<String, String>? constraints;

  ok() {
    constraints!.values;
  }
}
