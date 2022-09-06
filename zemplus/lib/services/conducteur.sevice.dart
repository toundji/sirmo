import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/licence_vehicule.dart';

import '../models/conducteur.dart';
import 'dio-client.service.dart';

class ConducteurService extends ChangeNotifier {
  Conducteur? conducteur;
  List<Conducteur>? all;

  setConducteur(Conducteur conducteur) {
    this.conducteur = conducteur;
    notifyListeners();
  }

  payLicenece(LicenceVehicule licenceVehicule) {
    conducteur?.vehicule?.licence = licenceVehicule;
    conducteur!.vehicule!.licences ??= [];
    conducteur!.vehicule!.licences!.add(licenceVehicule);
    notifyListeners();
  }

  Future<Conducteur> myInfo({bool refresh = false}) async {
    return await DioClient().get("conducteurs/my/info").then((value) {
      conducteur = Conducteur.fromMap(value);
      notifyListeners();
      return conducteur!;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "$error";
    });
  }

  Future<List<Conducteur>?> loadMyConducteurList(int user_id,
      {bool refresh = false}) async {
    if (conducteur == null || refresh) {
      return await DioClient().get("conducteurs/my/list").then((value) {
        List list = value;

        all = list.map((e) => Conducteur.fromMap(e)).toList();
        if (all!.length > 0) {
          conducteur = all!.firstWhere(
              (element) => element.statut == Conducteur.ACTIF,
              orElse: () => all!.first);
        }
        notifyListeners();
        return all;
      }).onError((error, stackTrace) {
        log("Error de conexion ", error: error, stackTrace: stackTrace);
        throw "Les données que nous avons récues ne sont pas celle que nous espérons";
      });
    }
    return all;
  }

  Future<Conducteur?> loadConducteurByCip(String nic,
      {bool refresh = false}) async {
    return await DioClient().get("conducteurs/nic-or-nip/$nic").then((value) {
      Conducteur driver = Conducteur.fromMap(value);
      notifyListeners();
      return driver;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<Conducteur?> becomeConducteur(
      Conducteur conducteur, Map<String, File?> files) async {
    if (this.conducteur != null) {
      throw "Vous êtes déjà un Conducteur";
    }
    var body = {
      "ifu": conducteur.ifu,
      "cip": conducteur.cip,
      "nip": conducteur.nip,
      "permis": conducteur.permis,
      "ancienIdentifiant": conducteur.ancienIdentifiant,
      "userId": 1,
    };
    await DioClient()
        .post("conducteurs/request/by/user", body: body)
        .then((value) {
      this.conducteur = Conducteur.fromMap(value);
      notifyListeners();
      return this.conducteur;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);

      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
    await sendConducteurDoc(files);
    return this.conducteur;
  }

  Future sendConducteurDoc(Map<String, File?> files) async {
    FormData body = FormData.fromMap(
      {
        'ifu': await MultipartFile.fromFile(files["ifu"]!.path),
        'cip': await MultipartFile.fromFile(files["cip"]!.path),
        'nip': await MultipartFile.fromFile(files["nip"]!.path),
        'idCarde': await MultipartFile.fromFile(files["idCarde"]!.path),
        'permis': await MultipartFile.fromFile(files["permis"]!.path),
      },
    );

    await DioClient(headers: {'Accept': 'application/json'})
        .post("fichiers/conducteurs/${conducteur?.id}/files", body: body)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error ?? "";
    });
  }
}
