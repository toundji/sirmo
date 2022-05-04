import 'dart:convert';

class Login {
  String? username;
  String? password;

  Login({
    this.username,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
