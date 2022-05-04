import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'arrondissement.dart';
import 'fichier.dart';
import 'fichier.dart';
import 'role.dart';

class User {
  int? id;

  String? nom;

  String? prenom;

  bool genre = true;

  String? password;

  String? email;

  DateTime? date_naiss;

  String? tel;

  String? code;

  DateTime? create_at;

  DateTime? update_at;

  List<Role>? roles;

  Arrondissement? arrondissement;

  Fichier? profile;

  List<Fichier>? profiles;
  User({
    this.id,
    this.nom,
    this.prenom,
    required this.genre,
    this.password,
    this.email,
    this.date_naiss,
    this.tel,
    this.code,
    this.create_at,
    this.update_at,
    this.roles,
    this.arrondissement,
    this.profile,
    this.profiles,
  });

  User copyWith({
    int? id,
    String? nom,
    String? prenom,
    bool? genre,
    String? password,
    String? email,
    DateTime? date_naiss,
    String? tel,
    String? code,
    DateTime? create_at,
    DateTime? update_at,
    List<Role>? roles,
    Arrondissement? arrondissement,
    Fichier? profile,
    List<Fichier>? profiles,
  }) {
    return User(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      genre: genre ?? this.genre,
      password: password ?? this.password,
      email: email ?? this.email,
      date_naiss: date_naiss ?? this.date_naiss,
      tel: tel ?? this.tel,
      code: code ?? this.code,
      create_at: create_at ?? this.create_at,
      update_at: update_at ?? this.update_at,
      roles: roles ?? this.roles,
      arrondissement: arrondissement ?? this.arrondissement,
      profile: profile ?? this.profile,
      profiles: profiles ?? this.profiles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'genre': genre,
      'password': password,
      'email': email,
      'date_naiss': date_naiss?.millisecondsSinceEpoch,
      'tel': tel,
      'code': code,
      'create_at': create_at?.millisecondsSinceEpoch,
      'update_at': update_at?.millisecondsSinceEpoch,
      'roles': roles?.map((x) => x.toMap()).toList(),
      'arrondissement': arrondissement?.toMap(),
      'profile': profile?.toMap(),
      'profiles': profiles?.map((x) => x.toMap()).toList(),
    };
  }

  static User? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return User(
      id: map['id']?.toInt(),
      nom: map['nom'],
      prenom: map['prenom'],
      genre: map['genre'] ?? false,
      password: map['password'],
      email: map['email'],
      date_naiss: map['date_naiss'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_naiss'])
          : null,
      tel: map['tel'],
      code: map['code'],
      create_at: map['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['create_at'])
          : null,
      update_at: map['update_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['update_at'])
          : null,
      roles: map['roles'] != null
          ? List<Role>.from(map['roles']?.map((x) => Role.fromMap(x)))
          : null,
      arrondissement: map['arrondissement'] != null
          ? Arrondissement.fromMap(map['arrondissement'])
          : null,
      profile: map['profile'] != null ? Fichier.fromMap(map['profile']) : null,
      profiles: map['profiles'] != null
          ? List<Fichier>.from(map['profiles']?.map((x) => Fichier.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  static User? fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, nom: $nom, prenom: $prenom, genre: $genre, password: $password, email: $email, date_naiss: $date_naiss, tel: $tel, code: $code, create_at: $create_at, update_at: $update_at, roles: $roles, arrondissement: $arrondissement, profile: $profile, profiles: $profiles)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.genre == genre &&
        other.password == password &&
        other.email == email &&
        other.date_naiss == date_naiss &&
        other.tel == tel &&
        other.code == code &&
        other.create_at == create_at &&
        other.update_at == update_at &&
        listEquals(other.roles, roles) &&
        other.arrondissement == arrondissement &&
        other.profile == profile &&
        listEquals(other.profiles, profiles);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        genre.hashCode ^
        password.hashCode ^
        email.hashCode ^
        date_naiss.hashCode ^
        tel.hashCode ^
        code.hashCode ^
        create_at.hashCode ^
        update_at.hashCode ^
        roles.hashCode ^
        arrondissement.hashCode ^
        profile.hashCode ^
        profiles.hashCode;
  }
}
