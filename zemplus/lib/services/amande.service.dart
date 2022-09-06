import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/amande.dart';
import '../models/conducteur-stat.dart';
import '../models/conducteur.dart';
import 'dio-client.service.dart';

class AmandeService extends ChangeNotifier {
  List<Amande>? all;

  Future<List<Amande>> loadAll(Conducteur conducteur,
      {bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      await DioClient()
          .get("amandes/conducteurs/${conducteur.id}")
          .then((value) {
        List list = value;
        all = list.map((e) {
          Amande amande = Amande.fromMap(e);
          amande.conducteur = conducteur;
          return amande;
        }).toList();
        notifyListeners();
        return all!;
      }).onError((error, stackTrace) {
        log("$error");
        throw error ?? "Une erreur s'est produit";
      });
    }
    return all!;
  }

  Future<List<Amande>> loadActifAmande(Conducteur conducteur,
      {bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      await DioClient()
          .get("amandes/conducteurs/${conducteur.id}/unsolve")
          .then((value) {
        List list = value;
        all = list.map((e) {
          Amande amande = Amande.fromMap(e);
          amande.conducteur = conducteur;
          return amande;
        }).toList();
        notifyListeners();
        return all!;
      }).onError((error, stackTrace) {
        log("$error");
        throw error ?? "Une erreur s'est produit";
      });
    }
    return all!;
  }

  Future<Amande?> createAmande(Amande amande) async {
    dynamic body = amande.toCreateMap();
    log("$body");
    return DioClient()
        .post(
      "amandes",
      body: body,
    )
        .then((value) {
      Amande app = Amande.fromMap(value);
      all ??= [];
      all!.add(amande);
      notifyListeners();
      return app;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<ConducteurStat?> loadStatistique(int conducteur_id) async {
    return await DioClient()
        .get("amandes/conducteurs/$conducteur_id/statistiques")
        .then((value) {
      return ConducteurStat.fromMap(value);
    }).onError((error, stackTrace) {
      log("Téléchargement de ConducteurStat ",
          error: error, stackTrace: stackTrace);
      throw error ?? "Téléchargement de conducteurStat";
    });
  }
}
