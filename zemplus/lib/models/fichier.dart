import 'dart:convert';

class Fichier {
  int? id;

  String? nom;

  String? path;

  String? mimetype;

  String? size;

  String? entity;

  int? entityId;

  int? createur_id;

  int? editeur_id;

  DateTime? create_at;

  DateTime? upDateTime_at;
  Fichier({
    this.id,
    this.nom,
    this.path,
    this.mimetype,
    this.size,
    this.entity,
    this.entityId,
    this.createur_id,
    this.editeur_id,
    this.create_at,
    this.upDateTime_at,
  });

  Fichier copyWith({
    int? id,
    String? nom,
    String? path,
    String? mimetype,
    String? size,
    String? entity,
    int? entityId,
    int? createur_id,
    int? editeur_id,
    DateTime? create_at,
    DateTime? upDateTime_at,
  }) {
    return Fichier(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      path: path ?? this.path,
      mimetype: mimetype ?? this.mimetype,
      size: size ?? this.size,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      create_at: create_at ?? this.create_at,
      upDateTime_at: upDateTime_at ?? this.upDateTime_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'path': path,
      'mimetype': mimetype,
      'size': size,
      'entity': entity,
      'entityId': entityId,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'create_at': create_at?.millisecondsSinceEpoch,
      'upDateTime_at': upDateTime_at?.millisecondsSinceEpoch,
    };
  }

  static Fichier? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Fichier(
      id: map['id']?.toInt(),
      nom: map['nom'],
      path: map['path'],
      mimetype: map['mimetype'],
      size: map['size'],
      entity: map['entity'],
      entityId: map['entityId']?.toInt(),
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      create_at: map['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['create_at'])
          : null,
      upDateTime_at: map['upDateTime_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['upDateTime_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Fichier? fromJson(String source) =>
      Fichier.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fichier(id: $id, nom: $nom, path: $path, mimetype: $mimetype, size: $size, entity: $entity, entityId: $entityId, createur_id: $createur_id, editeur_id: $editeur_id, create_at: $create_at, upDateTime_at: $upDateTime_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fichier &&
        other.id == id &&
        other.nom == nom &&
        other.path == path &&
        other.mimetype == mimetype &&
        other.size == size &&
        other.entity == entity &&
        other.entityId == entityId &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.create_at == create_at &&
        other.upDateTime_at == upDateTime_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        path.hashCode ^
        mimetype.hashCode ^
        size.hashCode ^
        entity.hashCode ^
        entityId.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        create_at.hashCode ^
        upDateTime_at.hashCode;
  }
}
