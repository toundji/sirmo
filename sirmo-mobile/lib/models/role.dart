import 'dart:convert';

class Role {
  int? id;
  String? nom;
  String? description;

  Role({
    this.id,
    this.nom,
    this.description,
  });

  Role copyWith({
    int? id,
    String? nom,
    String? description,
  }) {
    return Role(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
    };
  }

  static Role? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Role(
      id: map['id']?.toInt(),
      nom: map['nom'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  static Role? fromJson(String source) => Role.fromMap(json.decode(source));

  @override
  String toString() => 'Role(id: $id, nom: $nom, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Role &&
        other.id == id &&
        other.nom == nom &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ nom.hashCode ^ description.hashCode;
}
