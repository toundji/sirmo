import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/departement.dart';

import 'dio-client.service.dart';

class DepartmentService extends ChangeNotifier {
  List<Departement>? all;

  Future<List<Departement>?> loadAll({bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      return await DioClient().get("departements").then((value) {
        List<dynamic> list = value;
        all = list.map((e) => Departement.fromMap(e)).toList();
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
}
