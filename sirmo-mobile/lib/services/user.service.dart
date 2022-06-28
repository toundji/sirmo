import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import '../utils/network-info.dart';
import 'dio-client.service.dart';

class UserService extends ChangeNotifier {
  User? user;
  List<User>? all = [];

  setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  Future<dynamic> login(String phone, String password) async {
    var body = {
      "username": phone,
      "password": password,
    };
    return await DioClient(auth: false)
        .post("auth/login", body: body)
        .then((value) {
      NetworkInfo.token = value["token"];

      user = User.fromMap(value["user"]);

      return user;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<dynamic> resetPassword(String old, String nevel) async {
    var body = {
      "old": old,
      "nevel": nevel,
    };
    return await DioClient()
        .put("users/change/password", body: body)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<dynamic> changePhone(String nevel) async {
    var body = {
      "nevel": nevel,
    };
    return await DioClient()
        .put("users/change/phone", body: body)
        .then((value) {
      user?.phone = nevel;
      notifyListeners();
      return value;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<dynamic> changeEmail(String nevel) async {
    var body = {
      "nevel": nevel,
    };
    return await DioClient()
        .put("users/change/email", body: body)
        .then((value) {
      user?.email = nevel;
      notifyListeners();
      return value;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<void> updateProfile(File profile) async {
    FormData body = FormData.fromMap(
      {
        'profile': await MultipartFile.fromFile(profile.path),
      },
    );

    await DioClient(headers: {'Accept': 'application/json'})
        .post("users/profile/image", body: body)
        .then((value) {
      log("$value");
      return value;
    }).onError((error, stackTrace) {
      log("Erreure lors de la mise à jour du logo",
          error: error, stackTrace: stackTrace);
      throw error ?? "";
    });
  }
}
