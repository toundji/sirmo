import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sirmo/models/audit.dart';

import 'conducteur.dart';
import 'fichier.dart';
import 'conducteur.dart';

class Appreciation implements Audit {
  int? id;

  String? typeAppreciation;

  String? message;

  String? phone;

  Conducteur? conducteur;

  String? fichier;

  int? createur_id;

  int? editeur_id;

  DateTime? create_at;

  DateTime? upDateTime_at;

  @override
  DateTime? created_at;

  static String get EXCELLENT => "EXCELLENT";
  static String get TRES_BON => "TRES BON";
  static String get BON => "BON";
  static String get MAUVAISE => "MAUVAISE";
  static List<String> get STATUS_LIST =>
      ["EXCELLENT", "TRES BON", "BON", "MAUVAISE"];
  static Map<String, IconData> STATUS_ICONS = {
    Appreciation.EXCELLENT: Icons.start,
    Appreciation.TRES_BON: Icons.thumb_up,
    Appreciation.BON: Icons.check,
    Appreciation.MAUVAISE: Icons.thumb_down,
  };

  static Map<String, Color> STATUS_Colors = {
    Appreciation.EXCELLENT: Colors.blue,
    Appreciation.TRES_BON: Colors.green,
    Appreciation.BON: Colors.yellow,
    Appreciation.MAUVAISE: Colors.red,
  };

  @override
  DateTime? updated_at;
  Appreciation({
    this.id,
    this.typeAppreciation,
    this.message,
    this.phone,
    this.conducteur,
    this.fichier,
    this.createur_id,
    this.editeur_id,
    this.create_at,
    this.upDateTime_at,
    this.created_at,
    this.updated_at,
  });

  Appreciation copyWith({
    int? id,
    String? typeAppreciation,
    String? message,
    String? phone,
    Conducteur? conducteur,
    String? fichier,
    int? createur_id,
    int? editeur_id,
    DateTime? create_at,
    DateTime? upDateTime_at,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Appreciation(
      id: id ?? this.id,
      typeAppreciation: typeAppreciation ?? this.typeAppreciation,
      message: message ?? this.message,
      phone: phone ?? this.phone,
      conducteur: conducteur ?? this.conducteur,
      fichier: fichier ?? this.fichier,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      create_at: create_at ?? this.create_at,
      upDateTime_at: upDateTime_at ?? this.upDateTime_at,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typeAppreciation': typeAppreciation,
      'message': message,
      'phone': phone,
      'conducteur': conducteur?.toMap(),
      'fichier': fichier,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'create_at': create_at?.millisecondsSinceEpoch,
      'upDateTime_at': upDateTime_at?.millisecondsSinceEpoch,
      'created_at': created_at?.millisecondsSinceEpoch,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'typeAppreciation': typeAppreciation,
      if (message != null) 'message': message,
      if (phone != null) 'phone': phone,
      'conducteur_id': conducteur?.id,
    };
  }

  factory Appreciation.fromMap(Map<String, dynamic> map) {
    return Appreciation(
      id: map['id']?.toInt(),
      typeAppreciation: map['typeAppreciation'],
      message: map['message'],
      phone: map['phone'],
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
          : null,
      fichier: map['fichier'],
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      create_at:
          map['create_at'] != null ? DateTime.tryParse(map['create_at']) : null,
      upDateTime_at: map['upDateTime_at'] != null
          ? DateTime.tryParse(map['upDateTime_at'])
          : null,
      created_at: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updated_at: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appreciation.fromJson(String source) =>
      Appreciation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Appreciation(id: $id, typeAppreciation: $typeAppreciation, message: $message, phone: $phone, conducteur: $conducteur, fichier: $fichier, createur_id: $createur_id, editeur_id: $editeur_id, create_at: $create_at, upDateTime_at: $upDateTime_at, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appreciation &&
        other.id == id &&
        other.typeAppreciation == typeAppreciation &&
        other.message == message &&
        other.phone == phone &&
        other.conducteur == conducteur &&
        other.fichier == fichier &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.create_at == create_at &&
        other.upDateTime_at == upDateTime_at &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typeAppreciation.hashCode ^
        message.hashCode ^
        phone.hashCode ^
        conducteur.hashCode ^
        fichier.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        create_at.hashCode ^
        upDateTime_at.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
