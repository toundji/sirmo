import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/conducteur.dart';

import '../models/vehicule.dart';
import 'dio-client.service.dart';

class VehiculeService extends ChangeNotifier {
  Vehicule? vehicule;
  Map<int, List<Vehicule>> allByDriver = {};

  loadVehiculeOfConducteur(Conducteur conducteur,
      {bool refresh = false}) async {
    int id = conducteur.id!;
    if (allByDriver[id] == null || allByDriver[id]!.isEmpty || refresh) {
      await DioClient().get("vehicules/conducteurs/id").then((value) {});
    }
  }

  Future<Vehicule?> createvehicule(Vehicule vehicule) async {
    return await DioClient()
        .post("vehicules/by-conducteur", body: vehicule.toCreateMap())
        .then((value) {
      this.vehicule = Vehicule.fromMap(value);
      notifyListeners();
      return this.vehicule;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw error ??
          "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<void> updatevehiculeImage(File file) async {
    FormData body = FormData.fromMap(
      {
        'vehicule_image': await MultipartFile.fromFile(file.path),
      },
    );

    return await DioClient(headers: {'Accept': 'application/json'})
        .post("vehicules/${vehicule?.id}/images", body: body)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      throw error ?? "";
    });
  }
}
