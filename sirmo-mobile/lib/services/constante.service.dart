import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/constante.dart';

import 'dio-client.service.dart';

class DepartmentService extends ChangeNotifier {
  List<Constante>? all;
  Map<String, Constante> allByName = {};

  Future<List<Constante>?> loadAll({bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      return await DioClient(auth: false).get("constantes").then((value) {
        List<dynamic> list = value;
        all ??= [];

        list.forEach((element) {
          Constante data = Constante.fromMap(element);
          all!.add(value);
          allByName[data.nom!] = data;
        });
        notifyListeners();
        return all;
      }).onError((error, stackTrace) {
        log("Erreur de recupération des départements",
            error: error, stackTrace: stackTrace);
        throw "Erreur de recupération des départements: $error";
      });
    } else
      return all;
  }

  Future<Map<String, Constante>?> loadAllByName({bool refresh = false}) async {
    if (allByName.isEmpty || refresh) {
      return await DioClient(auth: false).get("constantes").then((value) {
        List<dynamic> list = value;
        all ??= [];

        list.forEach((element) {
          Constante data = Constante.fromMap(element);
          all!.add(value);
          allByName[data.nom!] = data;
        });
        notifyListeners();
        return allByName;
      }).onError((error, stackTrace) {
        log("Erreur de recupération des départements",
            error: error, stackTrace: stackTrace);
        throw "Erreur de recupération des départements: $error";
      });
    } else
      return allByName;
  }
}
