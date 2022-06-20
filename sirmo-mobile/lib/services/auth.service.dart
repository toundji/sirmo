import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sirmo/models/user.dart';
import 'package:sirmo/utils/network-info.dart';
import 'package:sirmo/utils/request.exception.dart';

import '../models/login.dart';
import 'dio-client.service.dart';

class AuthService extends ChangeNotifier {
  User user = User();
  PhoneNumber? phone;
  File? profile;

  setImageProfile(File? profil) {
    profile = profil;
    notifyListeners();
  }

  setEmailPhoneAndPass(PhoneNumber phone, String password, String? email) {
    user.phone = phone.toString();
    user.password = password;
    user.email = email;
  }

  Future<User?> login(Login login) async {
    return await DioClient(auth: false)
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

  Future<User> create(User data) async {
    user = data;
    var body = user.toCreateMap();
    return await DioClient(auth: false)
        .post("users/register", body: body)
        .then((value) {
      NetworkInfo.token = value["token"];
      user = User.fromMap(value["user"]);
      return user;
    }).onError((error, stackTrace) {
      log("", error: error, stackTrace: stackTrace);
      throw error ??
          "Une erreur s'est produit pendant l'enrégisterement des données";
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

  Future<String> checkAvailableEmail() async {
    if (user.email == null || user.email!.isEmpty) return "";
    return await DioClient(auth: false)
        .get("users/check/available-email/${user.email}")
        .then((value) {
      return "L'adresse email est disponible";
    }).onError((error, stackTrace) {
      throw error ?? "L'adresse email n'est pas disponible";
    });
  }

  Future<String> checkAvailablePhone() async {
    if (user.email == null || user.email!.isEmpty) return "";
    return await DioClient(auth: false)
        .get("users/check/available-phone/${user.phone}")
        .then((value) {
      return "Le numéro de téléphone est disponible";
    }).onError((error, stackTrace) {
      throw error ?? "Le numéro de téléphone n'est pas disponible";
    });
  }
}
