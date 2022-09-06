import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/departement.dart';

import '../models/commune.dart';
import 'dio-client.service.dart';

class CommuneService extends ChangeNotifier {
  List<Commune>? all;

  Future<List<Commune>?> loadAll({bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      return await DioClient().get("departements").then((value) {
        List<dynamic> list = value;
        all = list.map((e) => Commune.fromMap(e)).toList();
        notifyListeners();
        return all;
      }).onError((error, stackTrace) {
        log("Erreur de recupération des communess",
            error: error, stackTrace: stackTrace);
        throw "Erreur de recupération des communess: $error";
      });
    } else
      return all;
  }
}
