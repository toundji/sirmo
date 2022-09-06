class RequestException implements Exception {
  late String _message;

  RequestException(
      [String message = 'Nous ne parvenons pas à exécuter votre requête']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
