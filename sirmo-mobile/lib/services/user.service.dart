import 'dart:developer';

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
        .post("users/auth/signin", body: body)
        .then((value) {
      NetworkInfo.token = value["access_token"];

      user = User.fromMap(value["user_data"]);
      // log("$value");
      // log("${NetworkInfo.token}");
      // log("$user");

      return user;
    }).onError((error, stackTrace) {
      log("Error de conexion ", error: error, stackTrace: stackTrace);
      throw "Les données que nous avons récues ne sont pas celle que nous espérons";
    });
  }
}
