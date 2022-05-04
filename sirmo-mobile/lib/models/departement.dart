import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/commune.dart';

class Departement {
  int? id;
  String? nom;
  List<Commune> communes = [];
  Departement({
    this.id,
    this.nom,
    required this.communes,
  });

  Departement copyWith({
    int? id,
    String? nom,
    List<Commune>? communes,
  }) {
    return Departement(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      communes: communes ?? this.communes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'communes': communes.map((x) => x.toMap()).toList(),
    };
  }

  static Departement? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Departement(
      id: map['id']?.toInt(),
      nom: map['nom'],
      communes:
          List<Commune>.from(map['communes']?.map((x) => Commune.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Departement? fromJson(String source) =>
      Departement.fromMap(json.decode(source));

  @override
  String toString() => 'Departement(id: $id, nom: $nom, communes: $communes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Departement &&
        other.id == id &&
        other.nom == nom &&
        listEquals(other.communes, communes);
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode ^ communes.hashCode;
}
