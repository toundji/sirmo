import 'dart:convert';

import 'package:sirmo/models/commune.dart';

class Arrondissement {
  int? id;
  String? nom;
  Commune? commune;
  Arrondissement({
    this.id,
    this.nom,
    this.commune,
  });

  Arrondissement copyWith({
    int? id,
    String? nom,
    Commune? commune,
  }) {
    return Arrondissement(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      commune: commune ?? this.commune,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'commune': commune?.toMap(),
    };
  }

  static Arrondissement? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Arrondissement(
      id: map['id']?.toInt(),
      nom: map['nom'],
      commune: map['commune'] != null ? Commune.fromMap(map['commune']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Arrondissement? fromJson(String source) =>
      Arrondissement.fromMap(json.decode(source));

  @override
  String toString() => 'Arrondissement(id: $id, nom: $nom, commune: $commune)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Arrondissement &&
        other.id == id &&
        other.nom == nom &&
        other.commune == commune;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode ^ commune.hashCode;
}
