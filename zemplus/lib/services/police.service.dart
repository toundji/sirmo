import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/licence_vehicule.dart';

import '../models/police.dart';
import 'dio-client.service.dart';

class PoliceService extends ChangeNotifier {
  Police? police;
  List<Police>? all;

  setPolice(Police police) {
    this.police = police;
    notifyListeners();
  }

  Future<Police> myInfo({bool refresh = false}) async {
    return await DioClient().get("polices/my/info").then((value) {
      police = Police.fromMap(value);
      notifyListeners();
      return police!;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }
}
