import 'dart:convert';

import 'package:sirmo/models/audit.dart';

class Localisation implements Audit {
  int? id;

  int? longitude;

  int? latitude;

  int? altitude;

  String? info;

  String? adresse;

  String? entity;

  int? entityId;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Localisation({
    this.id,
    this.longitude,
    this.latitude,
    this.altitude,
    this.info,
    this.adresse,
    this.entity,
    this.entityId,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Localisation copyWith({
    int? id,
    int? longitude,
    int? latitude,
    int? altitude,
    String? info,
    String? adresse,
    String? entity,
    int? entityId,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Localisation(
      id: id ?? this.id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      altitude: altitude ?? this.altitude,
      info: info ?? this.info,
      adresse: adresse ?? this.adresse,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
      'altitude': altitude,
      'info': info,
      'adresse': adresse,
      'entity': entity,
      'entityId': entityId,
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Localisation.fromMap(Map<String, dynamic> map) {
    return Localisation(
      id: map['id']?.toInt(),
      longitude: map['longitude']?.toInt(),
      latitude: map['latitude']?.toInt(),
      altitude: map['altitude']?.toInt(),
      info: map['info'],
      adresse: map['adresse'],
      entity: map['entity'],
      entityId: map['entityId']?.toInt(),
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

  factory Localisation.fromJson(String source) =>
      Localisation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Localisation(id: $id, longitude: $longitude, latitude: $latitude, altitude: $altitude, info: $info, adresse: $adresse, entity: $entity, entityId: $entityId, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Localisation &&
        other.id == id &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.altitude == altitude &&
        other.info == info &&
        other.adresse == adresse &&
        other.entity == entity &&
        other.entityId == entityId &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        altitude.hashCode ^
        info.hashCode ^
        adresse.hashCode ^
        entity.hashCode ^
        entityId.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
