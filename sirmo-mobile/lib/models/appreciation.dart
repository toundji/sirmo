import 'dart:convert';

import 'package:sirmo/models/audit.dart';

import 'fichier.dart';
import 'zem.dart';

class Appreciation implements Audit {
  int? id;

  String? typeAppreciation;

  String? message;

  String? tel;

  Zem? zem;

  Fichier? fichier;

  int? createur_id;

  int? editeur_id;

  DateTime? create_at;

  DateTime? upDateTime_at;

  @override
  DateTime? created_at;

  @override
  DateTime? updated_at;
  Appreciation({
    this.id,
    this.typeAppreciation,
    this.message,
    this.tel,
    this.zem,
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
    String? tel,
    Zem? zem,
    Fichier? fichier,
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
      tel: tel ?? this.tel,
      zem: zem ?? this.zem,
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
      'tel': tel,
      'zem': zem?.toMap(),
      'fichier': fichier?.toMap(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'create_at': create_at?.millisecondsSinceEpoch,
      'upDateTime_at': upDateTime_at?.millisecondsSinceEpoch,
      'created_at': created_at?.millisecondsSinceEpoch,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Appreciation.fromMap(Map<String, dynamic> map) {
    return Appreciation(
      id: map['id']?.toInt(),
      typeAppreciation: map['typeAppreciation'],
      message: map['message'],
      tel: map['tel'],
      zem: map['zem'] != null ? Zem.fromMap(map['zem']) : null,
      fichier: map['fichier'] != null ? Fichier.fromMap(map['fichier']) : null,
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      create_at: map['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['create_at'])
          : null,
      upDateTime_at: map['upDateTime_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['upDateTime_at'])
          : null,
      created_at: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'])
          : null,
      updated_at: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appreciation.fromJson(String source) =>
      Appreciation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Appreciation(id: $id, typeAppreciation: $typeAppreciation, message: $message, tel: $tel, zem: $zem, fichier: $fichier, createur_id: $createur_id, editeur_id: $editeur_id, create_at: $create_at, upDateTime_at: $upDateTime_at, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appreciation &&
        other.id == id &&
        other.typeAppreciation == typeAppreciation &&
        other.message == message &&
        other.tel == tel &&
        other.zem == zem &&
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
        tel.hashCode ^
        zem.hashCode ^
        fichier.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        create_at.hashCode ^
        upDateTime_at.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
