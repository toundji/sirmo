import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

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
    var body = {
      "ifu": zem.ifu,
      "cip": zem.cip,
      "nip": zem.nip,
      "certificatRoute": zem.certificatRoute,
      "ancienIdentifiant": zem.ancienIdentifiant,
    };
    return await DioClient(auth: false)
        .post("zem/login", body: body)
        .then((value) {
      NetworkInfo.token = value["token"];

      zem = Zem.fromMap(value["zem"]);

      return zem;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }
}
