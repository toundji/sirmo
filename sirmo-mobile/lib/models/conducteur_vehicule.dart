import 'dart:convert';

import 'audit.dart';
import 'vehicule.dart';
import 'conducteur.dart';

class ConducteurVehicule implements Audit {
  int? id;

  DateTime? date_debut;

  DateTime? date_fin;

  Conducteur? conducteur;

  Vehicule? vehicule;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  ConducteurVehicule({
    this.id,
    this.date_debut,
    this.date_fin,
    this.conducteur,
    this.vehicule,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  ConducteurVehicule copyWith({
    int? id,
    DateTime? date_debut,
    DateTime? date_fin,
    Conducteur? conducteur,
    Vehicule? vehicule,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return ConducteurVehicule(
      id: id ?? this.id,
      date_debut: date_debut ?? this.date_debut,
      date_fin: date_fin ?? this.date_fin,
      conducteur: conducteur ?? this.conducteur,
      vehicule: vehicule ?? this.vehicule,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date_debut': date_debut?.toIso8601String(),
      'date_fin': date_fin?.toIso8601String(),
      'conducteur': conducteur?.toMap(),
      'vehicule': vehicule?.toMap(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory ConducteurVehicule.fromMap(Map<String, dynamic> map) {
    return ConducteurVehicule(
      id: map['id']?.toInt(),
      date_debut: map['date_debut'] != null
          ? DateTime.tryParse(map['date_debut'])
          : null,
      date_fin:
          map['date_fin'] != null ? DateTime.tryParse(map['date_fin']) : null,
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
          : null,
      vehicule:
          map['vehicule'] != null ? Vehicule.fromMap(map['vehicule']) : null,
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

  factory ConducteurVehicule.fromJson(String source) =>
      ConducteurVehicule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Conducteurvehicule(id: $id, date_debut: $date_debut, date_fin: $date_fin, conducteur: $conducteur, vehicule: $vehicule, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConducteurVehicule &&
        other.id == id &&
        other.date_debut == date_debut &&
        other.date_fin == date_fin &&
        other.conducteur == conducteur &&
        other.vehicule == vehicule &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date_debut.hashCode ^
        date_fin.hashCode ^
        conducteur.hashCode ^
        vehicule.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
