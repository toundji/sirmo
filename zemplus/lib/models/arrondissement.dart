import 'dart:convert';

import 'package:sirmo/models/audit.dart';
import 'package:sirmo/models/commune.dart';

class Arrondissement implements Audit {
  int? id;
  String? nom;
  Commune? commune;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Arrondissement({
    this.id,
    this.nom,
    this.commune,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Arrondissement copyWith({
    int? id,
    String? nom,
    Commune? commune,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Arrondissement(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      commune: commune ?? this.commune,
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
      'commune': commune?.toMap(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Arrondissement.fromMap(Map<String, dynamic> map) {
    return Arrondissement(
      id: map['id']?.toInt(),
      nom: map['nom'],
      commune: map['commune'] != null ? Commune.fromMap(map['commune']) : null,
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

  factory Arrondissement.fromJson(String source) =>
      Arrondissement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Arrondissement(id: $id, nom: $nom, commune: $commune, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Arrondissement &&
        other.id == id &&
        other.nom == nom &&
        other.commune == commune &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        commune.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
