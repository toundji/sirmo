import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sirmo/models/user.dart';
import 'package:sirmo/services/dio-client.dart';
import 'package:sirmo/utils/network-info.dart';
import 'package:sirmo/utils/request.exception.dart';

import '../models/login.dart';

class AuthService extends ChangeNotifier {
  User? user;

  Future<User?> login(Login login) async {
    return await DioClient(dio: new Dio())
        .post("auth/login", body: login.toMap())
        .then((value) {
      log("$value");
      User? user = User.fromMap(value['user']);
      NetworkInfo.token = value["token"];
      FlutterSecureStorage storage = new FlutterSecureStorage();
      storage.write(key: "token", value: NetworkInfo.token);
      this.user = user;
      return user;
    }).onError((error, stackTrace) {
      log("Erreur de récupération de l'utilisateur courant",
          error: error, stackTrace: stackTrace);

      throw error ?? "";
    });
  }

  loadUserInfo() async {
    await DioClient().get("auth/me").then((value) {
      User? user = User.fromMap(value);
      if (user != null) {
        this.user = user;
      } else {
        throw RequestException("Problème de réception de donnée");
      }
    }).onError((error, stackTrace) {
      log("Erreur de récupération de l'utilisateur courant",
          error: error, stackTrace: stackTrace);
    });
  }
}
