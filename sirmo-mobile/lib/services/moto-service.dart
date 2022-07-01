import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/moto.dart';
import 'dio-client.service.dart';

class MotoService extends ChangeNotifier {
  Moto? moto;

  Future<Moto?> createMoto(Moto moto) async {
    return await DioClient()
        .post("motos/by-zem", body: moto.toCreateMap())
        .then((value) {
      this.moto = Moto.fromMap(value);
      notifyListeners();
      return this.moto;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<void> updateMotoImage(File file) async {
    FormData body = FormData.fromMap(
      {
        'moto_image': await MultipartFile.fromFile(file.path),
      },
    );

    return await DioClient(headers: {'Accept': 'application/json'})
        .post("motos/${moto?.id}/images", body: body)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error ?? "";
    });
  }
}
