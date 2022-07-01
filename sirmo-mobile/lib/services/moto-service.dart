import 'dart:developer';

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
}
