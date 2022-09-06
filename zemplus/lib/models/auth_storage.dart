import 'dart:convert';

import 'package:flutter/foundation.dart';

class AuthStorage {
  String? token;
  List<String>? roles;

  AuthStorage({
    this.token,
    this.roles,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'roles': roles,
    };
  }

  factory AuthStorage.fromMap(Map<String, dynamic> map) {
    return AuthStorage(
      token: map['token'],
      roles: List<String>.from(map['roles']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthStorage.fromJson(String source) =>
      AuthStorage.fromMap(json.decode(source));
}
