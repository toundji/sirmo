import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../models/compte.dart';
import 'dio-client.service.dart';

class CompteService extends ChangeNotifier {
  Compte? compte;

  Future<Compte?> creditAcount(String transactionId, int amount) async {
    var body = {
      "transactionId": transactionId,
      "amount": amount,
    };
    return await DioClient(auth: false)
        .post("compte/recharger", body: body)
        .then((value) {
      compte = Compte.fromMap(value["user"]);

      return compte;
    }).onError((error, stackTrace) {
      log("Error de rechargement de compte ",
          error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }
}
