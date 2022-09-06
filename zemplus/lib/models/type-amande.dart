import 'dart:convert';

import 'audit.dart';
import 'fichier.dart';

class TypeAmande implements Audit {
  int? id;

  String? nom;

  int? montant;

  String? description;

  Fichier? document;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  TypeAmande({
    this.id,
    this.nom,
    this.montant,
    this.description,
    this.document,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  TypeAmande copyWith({
    int? id,
    String? nom,
    int? montant,
    String? description,
    Fichier? document,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return TypeAmande(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      montant: montant ?? this.montant,
      description: description ?? this.description,
      document: document ?? this.document,
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
      'montant': montant,
      'description': description,
      'document': document?.toMap(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory TypeAmande.fromMap(Map<String, dynamic> map) {
    return TypeAmande(
      id: int.tryParse("${map['id']}"),
      nom: map['nom'],
      montant: int.tryParse("${map['montant']}"),
      description: map['description'],
      document:
          map['document'] != null ? Fichier.fromMap(map['document']) : null,
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

  factory TypeAmande.fromJson(String source) =>
      TypeAmande.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TypeAmande(id: $id, nom: $nom, montant: $montant, description: $description, document: $document, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeAmande &&
        other.id == id &&
        other.nom == nom &&
        other.montant == montant &&
        other.description == description &&
        other.document == document &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        montant.hashCode ^
        description.hashCode ^
        document.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
