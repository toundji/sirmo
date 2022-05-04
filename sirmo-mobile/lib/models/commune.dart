import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/arrondissement.dart';
import 'package:sirmo/models/departement.dart';

class Commune {
  int? id;
  String? nom;
  Departement? departement;
  List<Arrondissement> arrondissement = [];
  Commune({
    this.id,
    this.nom,
    this.departement,
    required this.arrondissement,
  });

  Commune copyWith({
    int? id,
    String? nom,
    Departement? departement,
    List<Arrondissement>? arrondissement,
  }) {
    return Commune(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      departement: departement ?? this.departement,
      arrondissement: arrondissement ?? this.arrondissement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'departement': departement?.toMap(),
      'arrondissement': arrondissement.map((x) => x.toMap()).toList(),
    };
  }

  static Commune? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Commune(
      id: map['id']?.toInt(),
      nom: map['nom'],
      departement: map['departement'] != null
          ? Departement.fromMap(map['departement'])
          : null,
      arrondissement: List<Arrondissement>.from(
          map['arrondissement']?.map((x) => Arrondissement.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Commune? fromJson(String source) =>
      Commune.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Commune(id: $id, nom: $nom, departement: $departement, arrondissement: $arrondissement)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Commune &&
        other.id == id &&
        other.nom == nom &&
        other.departement == departement &&
        listEquals(other.arrondissement, arrondissement);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        departement.hashCode ^
        arrondissement.hashCode;
  }
}
