import 'dart:convert';

import 'package:sirmo/models/audit.dart';

import 'user.dart';
import 'conducteur.dart';

class Compte implements Audit {
  int? id;

  int? montant;

  User? user;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Compte({
    this.id,
    this.montant,
    this.user,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Compte copyWith({
    int? id,
    int? montant,
    User? user,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Compte(
      id: id ?? this.id,
      montant: montant ?? this.montant,
      user: user ?? this.user,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'user': user?.toMap(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory Compte.fromMap(Map<String, dynamic> map) {
    return Compte(
      id: map['id']?.toInt(),
      montant: map['montant']?.toInt(),
      user: map['user'] != null ? User.fromMap(map['user']) : null,
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

  factory Compte.fromJson(String source) => Compte.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Compte(id: $id, montant: $montant, user: $user, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Compte &&
        other.id == id &&
        other.montant == montant &&
        other.user == user &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        montant.hashCode ^
        user.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
