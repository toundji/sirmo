import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/appreciation.dart';
import '../models/conducteur-stat.dart';
import '../models/conducteur.dart';
import 'dio-client.service.dart';

class AppreciationService extends ChangeNotifier {
  List<Appreciation>? all;

  Future<List<Appreciation>> loadAll(Conducteur conducteur,
      {bool refresh = false}) async {
    if (all == null || all!.isEmpty || refresh) {
      await DioClient()
          .get("appreciations/conducteurs/${conducteur.id}")
          .then((value) {
        List list = value;
        all = list.map((e) {
          Appreciation appreciation = Appreciation.fromMap(e);
          appreciation.conducteur = conducteur;
          return appreciation;
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

  Future<Appreciation?> createAppreciation(
      Appreciation appreciation, File? file) async {
    dynamic body = appreciation.toCreateMap();
    log("$body");
    Appreciation appreciate = await DioClient()
        .post(
      "appreciations",
      body: body,
    )
        .then((value) {
      Appreciation app = Appreciation.fromMap(value);
      all ??= [];
      all!.add(appreciation);
      notifyListeners();
      return app;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
    if (file != null) {
      return await updateAppreciationImage(appreciate.id!, file);
    }
    return appreciate;
  }

  Future<Appreciation> updateAppreciationImage(int id, File file) async {
    FormData body = FormData.fromMap(
      {
        'image': await MultipartFile.fromFile(file.path),
      },
    );

    return await DioClient(headers: {'Accept': 'application/json'})
        .post("appreciations/$id/images", body: body)
        .then((value) {
      log("$value");
      Appreciation app = Appreciation.fromMap(value);

      return app;
    }).onError((error, stackTrace) {
      log("$error");
      throw error ?? "";
    });
  }

  Future<ConducteurStat?> loadStatistique(int conducteur_id) async {
    return await DioClient()
        .get("appreciations/conducteurs/$conducteur_id/statistiques")
        .then((value) {
      return ConducteurStat.fromMap(value);
    }).onError((error, stackTrace) {
      log("Téléchargement de ConducteurStat ",
          error: error, stackTrace: stackTrace);
      throw error ?? "Téléchargement de conducteurStat";
    });
  }
}
