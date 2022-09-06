import 'dart:convert';

import 'audit.dart';
import 'vehicule.dart';
import 'user.dart';

class ProprietaireVehicule implements Audit {
  int? id;

  User? proprietaire;

  Vehicule? vehicule;

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
  ProprietaireVehicule({
    this.id,
    this.proprietaire,
    this.vehicule,
    this.date_debut,
    this.date_fin,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  ProprietaireVehicule copyWith({
    int? id,
    User? proprietaire,
    Vehicule? vehicule,
    DateTime? date_debut,
    DateTime? date_fin,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return ProprietaireVehicule(
      id: id ?? this.id,
      proprietaire: proprietaire ?? this.proprietaire,
      vehicule: vehicule ?? this.vehicule,
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
      'vehicule': vehicule?.toMap(),
      'date_debut': date_debut?.toIso8601String(),
      'date_fin': date_fin?.toIso8601String(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory ProprietaireVehicule.fromMap(Map<String, dynamic> map) {
    return ProprietaireVehicule(
      id: map['id']?.toInt(),
      proprietaire: map['proprietaire'] != null
          ? User.fromMap(map['proprietaire'])
          : null,
      vehicule:
          map['vehicule'] != null ? Vehicule.fromMap(map['vehicule']) : null,
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

  factory ProprietaireVehicule.fromJson(String source) =>
      ProprietaireVehicule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Proprietairevehicule(id: $id, proprietaire: $proprietaire, vehicule: $vehicule, date_debut: $date_debut, date_fin: $date_fin, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProprietaireVehicule &&
        other.id == id &&
        other.proprietaire == proprietaire &&
        other.vehicule == vehicule &&
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
        vehicule.hashCode ^
        date_debut.hashCode ^
        date_fin.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
