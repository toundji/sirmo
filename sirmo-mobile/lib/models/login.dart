import 'dart:convert';

class Login {
  String? username;
  String? password;
  String? token;

  Login({
    this.username,
    this.password,
    this.token
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'token': token,
    };
  }
}
