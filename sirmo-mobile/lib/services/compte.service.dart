import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/conducteur.dart';
import 'package:sirmo/models/payement.dart';

import '../models/compte.dart';
import 'dio-client.service.dart';

class CompteService extends ChangeNotifier {
  Compte? compte;

  List<Payement>? histories;

  Future<Compte?> loadCompte({bool refresh = false}) async {
    if (compte == null || refresh) {
      return await DioClient().get("comptes/of-me").then((value) {
        compte = Compte.fromMap(value);
        notifyListeners();
        return compte;
      }).onError((error, stackTrace) {
        log("Téléchargement de Compte ", error: error, stackTrace: stackTrace);
        throw error ?? "Téléchargement de compte";
      });
    }
    return compte;
  }

  Future<List<Payement>?> loadHistory({bool refresh = false}) async {
    if (histories == null || histories!.isEmpty || refresh) {
      return await DioClient().get("comptes/of-me/history").then((value) {
        List list = value;
        histories = list.map((e) => Payement.fromMap(e)).toList();
        notifyListeners();
        return histories;
      }).onError((error, stackTrace) {
        log("Historique de compte ", error: error, stackTrace: stackTrace);
        throw error ?? "Historique de compte";
      });
    }
    return histories;
  }

  Future<Compte?> creditAcount(String transactionId, int amount) async {
    var body = {
      "transactionId": transactionId,
      "montant": amount,
    };
    log("$body");
    return await DioClient()
        .post("comptes/of-me/recharger-par-kikiapay", body: body)
        .then((value) {
      Payement payement = Payement.fromMap(value);
      compte = compte?.copyWith(
          montant: payement.compte?.montant,
          updated_at: payement.compte?.updated_at,
          editeur_id: payement.compte?.editeur_id);
      histories ??= [];
      histories!.add(payement);
      notifyListeners();
      return compte;
    }).onError((error, stackTrace) {
      log("Error de rechargement de compte ",
          error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<Compte?> payDriver(Conducteur conducteur, int amount) async {
    var body = {
      "conducteur_id": conducteur.id,
      "montant": amount,
    };
    return await DioClient()
        .post("payements/conducteur", body: body)
        .then((value) {
      Payement payement = Payement.fromMap(value);
      compte = compte?.copyWith(
          montant: payement.compte?.montant,
          updated_at: payement.compte?.updated_at,
          editeur_id: payement.compte?.editeur_id);
      histories ??= [];
      histories!.add(payement);
      notifyListeners();
      return compte;
    }).onError((error, stackTrace) {
      log("Error de rechargement de compte ",
          error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }
}
