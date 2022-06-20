import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/arrondissement.dart';
import 'package:sirmo/models/audit.dart';
import 'package:sirmo/models/departement.dart';

class Commune implements Audit {
  int? id;
  String? nom;
  Departement? departement;
  List<Arrondissement>? arrondissement;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Commune({
    this.id,
    this.nom,
    this.departement,
    this.arrondissement,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Commune copyWith({
    int? id,
    String? nom,
    Departement? departement,
    List<Arrondissement>? arrondissement,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Commune(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      departement: departement ?? this.departement,
      arrondissement: arrondissement ?? this.arrondissement,
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
      'departement': departement?.toMap(),
      'arrondissement': arrondissement?.map((x) => x.toMap()).toList(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Commune.fromMap(Map<String, dynamic> map) {
    return Commune(
      id: map['id']?.toInt(),
      nom: map['nom'],
      departement: map['departement'] != null
          ? Departement.fromMap(map['departement'])
          : null,
      arrondissement: map['arrondissement'] != null
          ? List<Arrondissement>.from(
              map['arrondissement']?.map((x) => Arrondissement.fromMap(x)))
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

  factory Commune.fromJson(String source) =>
      Commune.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Commune(id: $id, nom: $nom, departement: $departement, arrondissement: $arrondissement, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Commune &&
        other.id == id &&
        other.nom == nom &&
        other.departement == departement &&
        listEquals(other.arrondissement, arrondissement) &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        departement.hashCode ^
        arrondissement.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
