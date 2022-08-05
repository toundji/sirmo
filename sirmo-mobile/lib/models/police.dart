import 'dart:convert';

import 'package:sirmo/models/audit.dart';

import 'user.dart';

class Police implements Audit {
  int? id;

  String? ifu;

  String? identifiant;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;

  User? user;

  Police({
    this.id,
    this.ifu,
    this.identifiant,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
    this.user,
  });

  Police copyWith({
    int? id,
    String? ifu,
    String? identifiant,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
    User? user,
  }) {
    return Police(
      id: id ?? this.id,
      ifu: ifu ?? this.ifu,
      identifiant: identifiant ?? this.identifiant,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ifu': ifu,
      'identifiant': identifiant,
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
      'user': user?.toMap(),
    };
  }

  factory Police.fromMap(Map<String, dynamic> map) {
    return Police(
      id: map['id']?.toInt(),
      ifu: map['ifu'],
      identifiant: map['identifiant'],
      created_at: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      updated_at: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Police.fromJson(String source) => Police.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Police(id: $id, ifu: $ifu, identifiant: $identifiant, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Police &&
        other.id == id &&
        other.ifu == ifu &&
        other.identifiant == identifiant &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ifu.hashCode ^
        identifiant.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode ^
        user.hashCode;
  }
}
