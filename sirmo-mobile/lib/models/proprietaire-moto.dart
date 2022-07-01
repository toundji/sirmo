import 'dart:convert';

import 'audit.dart';
import 'moto.dart';
import 'user.dart';

class ProprietaireMoto implements Audit {
  int? id;

  User? proprietaire;

  Moto? moto;

  DateTime? date_debut;

  DateTime? date_fin;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  ProprietaireMoto({
    this.id,
    this.proprietaire,
    this.moto,
    this.date_debut,
    this.date_fin,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  ProprietaireMoto copyWith({
    int? id,
    User? proprietaire,
    Moto? moto,
    DateTime? date_debut,
    DateTime? date_fin,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return ProprietaireMoto(
      id: id ?? this.id,
      proprietaire: proprietaire ?? this.proprietaire,
      moto: moto ?? this.moto,
      date_debut: date_debut ?? this.date_debut,
      date_fin: date_fin ?? this.date_fin,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proprietaire': proprietaire?.toMap(),
      'moto': moto?.toMap(),
      'date_debut': date_debut?.toIso8601String(),
      'date_fin': date_fin?.toIso8601String(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory ProprietaireMoto.fromMap(Map<String, dynamic> map) {
    return ProprietaireMoto(
      id: map['id']?.toInt(),
      proprietaire: map['proprietaire'] != null
          ? User.fromMap(map['proprietaire'])
          : null,
      moto: map['moto'] != null ? Moto.fromMap(map['moto']) : null,
      date_debut: map['date_debut'] != null
          ? DateTime.tryParse(map['date_debut'])
          : null,
      date_fin:
          map['date_fin'] != null ? DateTime.tryParse(map['date_fin']) : null,
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

  factory ProprietaireMoto.fromJson(String source) =>
      ProprietaireMoto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProprietaireMoto(id: $id, proprietaire: $proprietaire, moto: $moto, date_debut: $date_debut, date_fin: $date_fin, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProprietaireMoto &&
        other.id == id &&
        other.proprietaire == proprietaire &&
        other.moto == moto &&
        other.date_debut == date_debut &&
        other.date_fin == date_fin &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        proprietaire.hashCode ^
        moto.hashCode ^
        date_debut.hashCode ^
        date_fin.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
