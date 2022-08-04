import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sirmo/models/licence_vehicule.dart';
import 'package:sirmo/services/dio-client.service.dart';

class LicenceService extends ChangeNotifier {
  LicenceVehicule? licence;
  List<LicenceVehicule>? all;

  Future<LicenceVehicule?> pay(int vehiculeId, String translationId) async {
    var body = {
      "vehicule_id": vehiculeId,
      "transaction_id": translationId,
    };
    return DioClient().post("licences/fedapay", body: body).then((value) {
      licence = LicenceVehicule.fromMap(value);
      notifyListeners();
      return licence;
    }).onError((error, stackTrace) {
      log("$error");
      throw error ?? "";
    });
  }
}
