import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/departement.dart';

import '../models/arrondissement.dart';
import '../models/commune.dart';
import 'dio-client.service.dart';

class ArrondissementService extends ChangeNotifier {
  List<Arrondissement>? all;

  Future<List<Arrondissement>?> loadAll({bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      return await DioClient().get("departements").then((value) {
        List<dynamic> list = value;
        all = list.map((e) => Arrondissement.fromMap(e)).toList();
        notifyListeners();
        return all;
      }).onError((error, stackTrace) {
        log("Erreur de recupération des arrondissements",
            error: error, stackTrace: stackTrace);
        throw "Erreur de recupération des arrondissements: $error";
      });
    } else
      return all;
  }
}
