import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/network-info.dart';
import '../utils/request.exception.dart';

class DioClient {
  Dio? _dio;
  DioClient(
      {bool auth = true, String? contentType, Map<String, dynamic>? headers}) {
    _dio = Dio();
    _dio!.options.baseUrl = "${NetworkInfo.baseUrl}";
    _dio!.options.sendTimeout = 100000;

    _dio!.options.contentType = contentType ?? "application/json";
    if (headers != null) {
      _dio!.options.headers = headers;
    }
    if (auth)
      _dio!.options.headers["Authorization"] = "Bearer ${NetworkInfo.token}";
  }

  Future<dynamic> post(
    String url, {
    dynamic body,
    dynamic param,
  }) async {
    try {
      await isConnected();
      final response =
          await _dio!.post(url, data: body, queryParameters: param);

      return response.data;
    } on DioError catch (e) {
      manageDioError(e);
    }
  }

  Future<dynamic> put(
    String url, {
    dynamic body,
    dynamic param,
  }) async {
    try {
      final response =
          await _dio!.put(url, data: body ?? {}, queryParameters: param);

      return response.data;
    } on DioError catch (e) {
      manageDioError(e);
    }
  }

  Future<dynamic> get(
    String url, {
    dynamic param,
  }) async {
    try {
      final response = await _dio!.get(url, queryParameters: param);

      return response.data;
    } on DioError catch (e) {
      manageDioError(e);
    }
  }

  Future<dynamic> delete(
    String url, {
    dynamic param,
  }) async {
    try {
      final response = await _dio!.delete(url, queryParameters: param);

      return response.data;
    } on DioError catch (e) {
      manageDioError(e);
    }
  }

  Future<dynamic> request(
    String url, {
    dynamic body,
    dynamic param,
  }) async {
    try {
      final response =
          await _dio!.request(url, data: body, queryParameters: param);

      return response.data;
    } on DioError catch (e) {
      manageDioError(e);
    }
  }

  isConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(Duration(seconds: 1));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      throw RequestException("Vous n'êtes pas connectés internet");
    }
  }

  manageDioError(DioError error) {
    log("Uri", error: error.requestOptions.uri);
    log("Response", error: error.response);
    log("mesage", error: error.message);
    log("mesage", error: error.type);

    if (error.response != null) {
      if (error.response!.statusCode != null &&
          error.response!.statusCode! >= 500) {
        throw RequestException(
          "Erreur de traitement. Les données que nous avon réçues ne sont pas celles que nous espérons. Vous pouvez contacter un administrateur si cella persiste",
        );
      }
      if (error.response!.statusCode != null &&
          error.response!.statusCode! >= 400) {
        throw RequestException(
          "Mauvaise requète. Les données que nous avon réçues ne sont pas celles que nous espérons",
        );
      } else {
        throw RequestException("${error.response}");
      }
    } else {
      if (error.type == DioErrorType.connectTimeout) {
        throw RequestException(
            "Nous ne parevenons pas à exécuter votre requète. Temps de connexion expirer");
      }
      if (error.type == DioErrorType.sendTimeout) {
        throw RequestException(
            "Le requette mets trop de temps à s'exécuter. Vérifiez votre connexion0");
      }
      if (error.type == DioErrorType.receiveTimeout) {
        throw RequestException(
            "Ereure de reception. Le temps d'exécution de la requette est espirer");
      }
      if (error.type == DioErrorType.cancel) {
        throw RequestException("Larequète estannulée");
      }
      if (error.type == DioErrorType.other) {
        throw RequestException("Erreur inconnue");
      } else {
        throw RequestException("Erreur incconu est annulée");
      }
    }
  }

  techniqueError() {
    throw RequestException(
        "Erreur de traitement de la réponse. Veillez contacter l' administrateur");
  }
}
