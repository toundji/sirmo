import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sirmo/models/auth_storage.dart';

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

  Future<User> login(String phone, String password) async {
    String? token = await FirebaseMessaging.instance.getToken();

    var body = {
      "username": phone,
      "password": password,
      "token": token
    };
    return await DioClient(auth: false)
        .post("auth/login", body: body)
        .then((value) async {
      NetworkInfo.token = value["token"];
      user = User.fromMap(value["user"]);

      FlutterSecureStorage storage = FlutterSecureStorage();
      AuthStorage auth =
          AuthStorage(token: NetworkInfo.token, roles: user?.roles);
      await storage.write(key: "authStorage", value: auth.toJson());

      return user!;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }

  Future<dynamic>  resetToken()async {
        String? token = await FirebaseMessaging.instance.getToken();
      if(user.token == token){
        return "";
      }
      var body = { "token": token };
    return await DioClient().put("users/reset/token", body: body)
        .then((value) { return value; }).onError((error, stackTrace) {
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

  Future<User?> profile() async {
    return await DioClient().get("users/my/info").then((value) {
      user = User.fromMap(value);
      log("$value");
      notifyListeners();
      return user!;
    }).onError((error, stackTrace) {
      log("Erreure lors de la mise à jour du logo",
          error: error, stackTrace: stackTrace);
      throw error ?? "";
    });
  }
}
