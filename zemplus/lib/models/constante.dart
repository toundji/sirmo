import 'dart:convert';

import 'package:sirmo/models/audit.dart';

class Constante implements Audit {
  @override
  int? id;

  String? nom;

  String? valeur;

  String? visibilite;

  bool? status;

  String? description;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Constante({
    this.id,
    this.nom,
    this.valeur,
    this.visibilite,
    this.status,
    this.description,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Constante copyWith({
    int? id,
    String? nom,
    String? valeur,
    String? visibilite,
    bool? status,
    String? description,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Constante(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      valeur: valeur ?? this.valeur,
      visibilite: visibilite ?? this.visibilite,
      status: status ?? this.status,
      description: description ?? this.description,
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
      'valeur': valeur,
      'visibilite': visibilite,
      'status': status,
      'description': description,
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory Constante.fromMap(Map<String, dynamic> map) {
    return Constante(
      id: map['id']?.toInt(),
      nom: map['nom'],
      valeur: map['valeur'],
      visibilite: map['visibilite'],
      status: map['status'],
      description: map['description'],
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

  factory Constante.fromJson(String source) =>
      Constante.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Constante(id: $id, nom: $nom, valeur: $valeur, visibilite: $visibilite, status: $status, description: $description, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Constante &&
        other.id == id &&
        other.nom == nom &&
        other.valeur == valeur &&
        other.visibilite == visibilite &&
        other.status == status &&
        other.description == description &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        valeur.hashCode ^
        visibilite.hashCode ^
        status.hashCode ^
        description.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
