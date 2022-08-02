import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/audit.dart';

import '../utils/network-info.dart';
import 'arrondissement.dart';
import 'fichier.dart';
import 'fichier.dart';
import 'role.dart';

class User implements Audit {
  int? id;

  String? nom;

  String? prenom;

  String? genre;

  String? password;

  String? email;

  DateTime? date_naiss;

  String? phone;

  String? code;

  List<String>? roles;

  Arrondissement? arrondissement;

  String? profile_image;

  String? idCarde_image;
  String? idCarde;

  List<Fichier>? profiles;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  static const String MASCULIN = "MASCULIN";
  static const String FEMININ = "FEMININ";

  bool hasRole(String name) {
    return roles?.contains(name.trim().toUpperCase()) ?? false;
  }

  @override
  DateTime? updated_at;
  User({
    this.id,
    this.nom,
    this.prenom,
    this.genre = User.MASCULIN,
    this.password,
    this.email,
    this.date_naiss,
    this.phone,
    this.code,
    this.roles,
    this.arrondissement,
    this.profile_image,
    this.idCarde_image,
    this.idCarde,
    this.profiles,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  static String get imageProfile =>
      "${NetworkInfo.baseUrl}/users/profile/image";

  User copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? genre,
    String? password,
    String? email,
    DateTime? date_naiss,
    String? tel,
    String? code,
    List<String>? roles,
    Arrondissement? arrondissement,
    String? profile_image,
    String? idCarde_image,
    String? idCarde,
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
      profile_image: profile_image ?? this.profile_image,
      idCarde: idCarde ?? this.idCarde,
      idCarde_image: idCarde_image ?? this.idCarde_image,
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
      'date_naiss': date_naiss?.toIso8601String(),
      'phone': phone,
      'code': code,
      'roles': roles,
      'arrondissement': arrondissement?.toMap(),
      'idCarde_image': idCarde_image,
      'profile_image': profile_image,
      'idCarde': idCarde,
      'profiles': profiles?.map((x) => x.toMap()).toList(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
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
      if (idCarde != null) 'idCarde': idCarde,
      'arrondissement_id': arrondissement?.id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      nom: map['nom'],
      prenom: map['prenom'],
      genre: map['genre'],
      password: map['password'],
      email: map['email'],
      idCarde: map['idCarde'],
      idCarde_image: map['idCarde_image'],
      date_naiss: map['date_naiss'] != null
          ? DateTime.tryParse(map['date_naiss'])
          : null,
      phone: map['phone'],
      code: map['code'],
      roles: List<String>.from(map['roles']),
      arrondissement: map['arrondissement'] != null
          ? Arrondissement.fromMap(map['arrondissement'])
          : null,
      profile_image: map['profile_image'],
      profiles: map['profiles'] != null
          ? List<Fichier>.from(map['profiles']?.map((x) => Fichier.fromMap(x)))
          : null,
      created_at: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      updated_at: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, nom: $nom, prenom: $prenom, genre: $genre, password: $password, email: $email, date_naiss: $date_naiss, tel: $phone, code: $code, roles: $roles, arrondissement: $arrondissement, profile_image: $profile_image, profiles: $profiles, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
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
        other.profile_image == profile_image &&
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
        profile_image.hashCode ^
        profiles.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
