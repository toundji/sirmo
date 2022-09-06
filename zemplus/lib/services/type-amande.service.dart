import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/type-amande.dart';

import '../models/type-amande.dart';
import 'dio-client.service.dart';

class TypeAmandeService extends ChangeNotifier {
  List<TypeAmande>? all;

  Future<List<TypeAmande>?> loadAll({bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      return await DioClient().get("type-amandes").then((value) {
        List<dynamic> list = value;
        all = list.map((e) => TypeAmande.fromMap(e)).toList();
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
