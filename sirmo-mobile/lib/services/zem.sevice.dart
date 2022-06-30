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

  Future<dynamic> becomeZem(Zem zem) async {
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
    return await DioClient()
        .post("zems/request/by/user", body: body)
        .then((value) {
      zem = Zem.fromMap(value);
      notifyListeners();
      return zem;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      if (error is RequestExcept) {
        throw error;
      } else if (error is String) {
        throw error;
      }
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }
}
