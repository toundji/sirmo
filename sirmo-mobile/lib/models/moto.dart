import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'audit.dart';
import 'fichier.dart';
import 'proprietaire-moto.dart';
import 'user.dart';
import 'zem.dart';
import 'zem_moto.dart';

class Moto implements Audit {
  int? id;

  String? matricule;

  String? carteGrise;

  String? chassis;

  String? serie;

  String? etat;

  User? proprietaire;

  Zem? zem;

  List<ZemMoto>? zemMotos;

  List<ProprietaireMoto>? proprietaireMotos;

  Fichier? image;

  List<Fichier>? images;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Moto({
    this.id,
    this.matricule,
    this.carteGrise,
    this.chassis,
    this.serie,
    this.etat,
    this.proprietaire,
    this.zem,
    this.zemMotos,
    this.proprietaireMotos,
    this.image,
    this.images,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Moto copyWith({
    int? id,
    String? matricule,
    String? carteGrise,
    String? chassis,
    String? serie,
    String? etat,
    User? proprietaire,
    Zem? zem,
    List<ZemMoto>? zemMotos,
    List<ProprietaireMoto>? proprietaireMotos,
    Fichier? image,
    List<Fichier>? images,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Moto(
      id: id ?? this.id,
      matricule: matricule ?? this.matricule,
      carteGrise: carteGrise ?? this.carteGrise,
      chassis: chassis ?? this.chassis,
      serie: serie ?? this.serie,
      etat: etat ?? this.etat,
      proprietaire: proprietaire ?? this.proprietaire,
      zem: zem ?? this.zem,
      zemMotos: zemMotos ?? this.zemMotos,
      proprietaireMotos: proprietaireMotos ?? this.proprietaireMotos,
      image: image ?? this.image,
      images: images ?? this.images,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matricule': matricule,
      'carteGrise': carteGrise,
      'chassis': chassis,
      'serie': serie,
      'etat': etat,
      'proprietaire': proprietaire?.toMap(),
      'zem': zem?.toMap(),
      'zemMotos': zemMotos?.map((x) => x.toMap()).toList(),
      'proprietaireMotos': proprietaireMotos?.map((x) => x.toMap()).toList(),
      'image': image?.toMap(),
      'images': images?.map((x) => x.toMap()).toList(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Moto.fromMap(Map<String, dynamic> map) {
    return Moto(
      id: map['id']?.toInt(),
      matricule: map['matricule'],
      carteGrise: map['carteGrise'],
      chassis: map['chassis'],
      serie: map['serie'],
      etat: map['etat'],
      proprietaire: map['proprietaire'] != null
          ? User.fromMap(map['proprietaire'])
          : null,
      zem: map['zem'] != null ? Zem.fromMap(map['zem']) : null,
      zemMotos: map['zemMotos'] != null
          ? List<ZemMoto>.from(map['zemMotos']?.map((x) => ZemMoto.fromMap(x)))
          : null,
      proprietaireMotos: map['proprietaireMotos'] != null
          ? List<ProprietaireMoto>.from(
              map['proprietaireMotos']?.map((x) => ProprietaireMoto.fromMap(x)))
          : null,
      image: map['image'] != null ? Fichier.fromMap(map['image']) : null,
      images: map['images'] != null
          ? List<Fichier>.from(map['images']?.map((x) => Fichier.fromMap(x)))
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

  factory Moto.fromJson(String source) => Moto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Moto(id: $id, matricule: $matricule, carteGrise: $carteGrise, chassis: $chassis, serie: $serie, etat: $etat, proprietaire: $proprietaire, zem: $zem, zemMotos: $zemMotos, proprietaireMotos: $proprietaireMotos, image: $image, images: $images, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Moto &&
        other.id == id &&
        other.matricule == matricule &&
        other.carteGrise == carteGrise &&
        other.chassis == chassis &&
        other.serie == serie &&
        other.etat == etat &&
        other.proprietaire == proprietaire &&
        other.zem == zem &&
        listEquals(other.zemMotos, zemMotos) &&
        listEquals(other.proprietaireMotos, proprietaireMotos) &&
        other.image == image &&
        listEquals(other.images, images) &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        matricule.hashCode ^
        carteGrise.hashCode ^
        chassis.hashCode ^
        serie.hashCode ^
        etat.hashCode ^
        proprietaire.hashCode ^
        zem.hashCode ^
        zemMotos.hashCode ^
        proprietaireMotos.hashCode ^
        image.hashCode ^
        images.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
