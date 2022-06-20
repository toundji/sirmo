import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/audit.dart';

import 'arrondissement.dart';
import 'fichier.dart';
import 'fichier.dart';
import 'role.dart';

class User implements Audit {
  int? id;

  String? nom;

  String? prenom;

  bool genre = true;

  String? password;

  String? email;

  DateTime? date_naiss;

  String? phone;

  String? code;

  List<Role>? roles;

  Arrondissement? arrondissement;

  Fichier? profile;

  List<Fichier>? profiles;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  User({
    this.id,
    this.nom,
    this.prenom,
    this.genre = true,
    this.password,
    this.email,
    this.date_naiss,
    this.phone,
    this.code,
    this.roles,
    this.arrondissement,
    this.profile,
    this.profiles,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
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
    List<Role>? roles,
    Arrondissement? arrondissement,
    Fichier? profile,
    List<Fichier>? profiles,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return User(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      genre: genre ?? this.genre,
      password: password ?? this.password,
      email: email ?? this.email,
      date_naiss: date_naiss ?? this.date_naiss,
      phone: tel ?? this.phone,
      code: code ?? this.code,
      roles: roles ?? this.roles,
      arrondissement: arrondissement ?? this.arrondissement,
      profile: profile ?? this.profile,
      profiles: profiles ?? this.profiles,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
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
      'phone': phone,
      'code': code,
      'roles': roles?.map((x) => x?.toMap())?.toList(),
      'arrondissement': arrondissement?.toMap(),
      'profile': profile?.toMap(),
      'profiles': profiles?.map((x) => x?.toMap())?.toList(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'genre': genre,
      'password': password,
      'email': email,
      'date_naiss': date_naiss?.toIso8601String(),
      'phone': phone,
      'arrondissement': arrondissement?.id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
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
      phone: map['tel'],
      code: map['code'],
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
      created_at: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'])
          : null,
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      updated_at: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, nom: $nom, prenom: $prenom, genre: $genre, password: $password, email: $email, date_naiss: $date_naiss, tel: $phone, code: $code, roles: $roles, arrondissement: $arrondissement, profile: $profile, profiles: $profiles, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
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
        other.phone == phone &&
        other.code == code &&
        listEquals(other.roles, roles) &&
        other.arrondissement == arrondissement &&
        other.profile == profile &&
        listEquals(other.profiles, profiles) &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
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
        phone.hashCode ^
        code.hashCode ^
        roles.hashCode ^
        arrondissement.hashCode ^
        profile.hashCode ^
        profiles.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
