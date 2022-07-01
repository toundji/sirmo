import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sirmo/utils/request-exception.dart';

import '../models/zem.dart';
import '../models/zem.dart';
import '../utils/network-info.dart';
import 'dio-client.service.dart';

class ZemService extends ChangeNotifier {
  Zem? zem;
  List<Zem>? all;

  setZem(Zem zem) {
    this.zem = zem;
    notifyListeners();
  }

  Future<Zem?> becomeZem(Zem zem, Map<String, File?> files) async {
    if (this.zem != null) {
      throw "Vous êtes déjà un Zem";
    }
    var body = {
      "ifu": zem.ifu,
      "cip": zem.cip,
      "nip": zem.nip,
      "idCarde": zem.idCarde,
      "certificatRoute": zem.certificatRoute,
      "ancienIdentifiant": zem.ancienIdentifiant,
      "userId": 1,
    };
    await DioClient().post("zems/request/by/user", body: body).then((value) {
      this.zem = Zem.fromMap(value);
      notifyListeners();
      return this.zem;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      if (error is RequestExcept) {
        throw error;
      } else if (error is String) {
        throw error;
      }
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
    await sendZemDoc(files);
    return this.zem;
  }

  Future sendZemDoc(Map<String, File?> files) async {
    FormData body = FormData.fromMap(
      {
        'ifu': await MultipartFile.fromFile(files["ifu"]!.path),
        'cip': await MultipartFile.fromFile(files["cip"]!.path),
        'nip': await MultipartFile.fromFile(files["nip"]!.path),
        'idCarde': await MultipartFile.fromFile(files["idCarde"]!.path),
        'certificatRoute':
            await MultipartFile.fromFile(files["certificatRoute"]!.path),
      },
    );

    await DioClient(headers: {'Accept': 'application/json'})
        .post("fichiers/zems/${zem?.id}/files", body: body)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error ?? "";
    });
  }
}
