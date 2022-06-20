import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/audit.dart';
import 'package:sirmo/models/commune.dart';

class Departement implements Audit {
  int? id;
  String? nom;
  List<Commune>? communes;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Departement({
    this.id,
    this.nom,
    this.communes,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Departement copyWith({
    int? id,
    String? nom,
    List<Commune>? communes,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Departement(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      communes: communes ?? this.communes,
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
      'communes': communes?.map((x) => x?.toMap())?.toList(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Departement.fromMap(Map<String, dynamic> map) {
    return Departement(
      id: map['id']?.toInt(),
      nom: map['nom'],
      communes: map['communes'] != null
          ? List<Commune>.from(map['communes']?.map((x) => Commune.fromMap(x)))
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

  factory Departement.fromJson(String source) =>
      Departement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Departement(id: $id, nom: $nom, communes: $communes, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Departement &&
        other.id == id &&
        other.nom == nom &&
        listEquals(other.communes, communes) &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        communes.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
