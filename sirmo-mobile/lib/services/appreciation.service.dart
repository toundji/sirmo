import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/appreciation.dart';
import 'dio-client.service.dart';

class AppreciationService extends ChangeNotifier {
  List<Appreciation>? all;

  Future<Appreciation?> createAppreciation(
      Appreciation appreciation, File? file) async {
    dynamic body = appreciation.toCreateMap();
    log("$body");
    Appreciation appreciate = await DioClient()
        .post(
      "appreciations",
      body: body,
    )
        .then((value) {
      Appreciation app = Appreciation.fromMap(value);
      all ??= [];
      all!.add(appreciation);
      notifyListeners();
      return app;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
    if (file != null) {
      return await updateAppreciationImage(appreciate.id!, file);
    }
    return appreciate;
  }

  Future<Appreciation> updateAppreciationImage(int id, File file) async {
    FormData body = FormData.fromMap(
      {
        'image': await MultipartFile.fromFile(file.path),
      },
    );

    return await DioClient(headers: {'Accept': 'application/json'})
        .post("appreciations/$id/images", body: body)
        .then((value) {
      Appreciation app = Appreciation.fromMap(value);

      return value;
    }).onError((error, stackTrace) {
      throw error ?? "";
    });
  }
}
