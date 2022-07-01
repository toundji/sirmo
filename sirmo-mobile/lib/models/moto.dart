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

  String? immatriculation;

  String? numero_carte_grise;

  String? numero_chassis;

  String? numero_serie_moteur;

  String? provenance;

  String? puissance;

  String? energie;

  DateTime? annee_mise_circulation;

  DateTime? derniere_revision;

  String? etat;

  String? type;

  String? marque;

  String? model;

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
    this.immatriculation,
    this.numero_carte_grise,
    this.numero_chassis,
    this.numero_serie_moteur,
    this.provenance,
    this.puissance,
    this.energie,
    this.annee_mise_circulation,
    this.derniere_revision,
    this.etat,
    this.type,
    this.marque,
    this.model,
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
    String? immatriculation,
    String? numero_carte_grise,
    String? numero_chassis,
    String? numero_serie_moteur,
    String? provenance,
    String? puissance,
    String? energie,
    DateTime? annee_mise_circulation,
    DateTime? derniere_revision,
    String? etat,
    String? type,
    String? marque,
    String? model,
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
      immatriculation: immatriculation ?? this.immatriculation,
      numero_carte_grise: numero_carte_grise ?? this.numero_carte_grise,
      numero_chassis: numero_chassis ?? this.numero_chassis,
      numero_serie_moteur: numero_serie_moteur ?? this.numero_serie_moteur,
      provenance: provenance ?? this.provenance,
      puissance: puissance ?? this.puissance,
      energie: energie ?? this.energie,
      annee_mise_circulation:
          annee_mise_circulation ?? this.annee_mise_circulation,
      derniere_revision: derniere_revision ?? this.derniere_revision,
      etat: etat ?? this.etat,
      type: type ?? this.type,
      marque: marque ?? this.marque,
      model: model ?? this.model,
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
      'immatriculation': immatriculation,
      'numero_carte_grise': numero_carte_grise,
      'numero_chassis': numero_chassis,
      'numero_serie_moteur': numero_serie_moteur,
      'provenance': provenance,
      'puissance': puissance,
      'energie': energie,
      'annee_mise_circulation': annee_mise_circulation?.millisecondsSinceEpoch,
      'derniere_revision': derniere_revision?.millisecondsSinceEpoch,
      'etat': etat,
      'type': type,
      'marque': marque,
      'model': model,
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
      immatriculation: map['immatriculation'],
      numero_carte_grise: map['numero_carte_grise'],
      numero_chassis: map['numero_chassis'],
      numero_serie_moteur: map['numero_serie_moteur'],
      provenance: map['provenance'],
      puissance: map['puissance'],
      energie: map['energie'],
      annee_mise_circulation: map['annee_mise_circulation'] != null
          ? DateTime.tryParse(map['annee_mise_circulation'])
          : null,
      derniere_revision: map['derniere_revision'] != null
          ? DateTime.tryParse(map['derniere_revision'])
          : null,
      etat: map['etat'],
      type: map['type'],
      marque: map['marque'],
      model: map['model'],
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

  factory Moto.fromJson(String source) => Moto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Moto(id: $id, immatriculation: $immatriculation, numero_carte_grise: $numero_carte_grise, numero_chassis: $numero_chassis, numero_serie_moteur: $numero_serie_moteur, provenance: $provenance, puissance: $puissance, energie: $energie, annee_mise_circulation: $annee_mise_circulation, derniere_revision: $derniere_revision, etat: $etat, type: $type, marque: $marque, model: $model, proprietaire: $proprietaire, zem: $zem, zemMotos: $zemMotos, proprietaireMotos: $proprietaireMotos, image: $image, images: $images, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Moto &&
        other.id == id &&
        other.immatriculation == immatriculation &&
        other.numero_carte_grise == numero_carte_grise &&
        other.numero_chassis == numero_chassis &&
        other.numero_serie_moteur == numero_serie_moteur &&
        other.provenance == provenance &&
        other.puissance == puissance &&
        other.energie == energie &&
        other.annee_mise_circulation == annee_mise_circulation &&
        other.derniere_revision == derniere_revision &&
        other.etat == etat &&
        other.type == type &&
        other.marque == marque &&
        other.model == model &&
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
        immatriculation.hashCode ^
        numero_carte_grise.hashCode ^
        numero_chassis.hashCode ^
        numero_serie_moteur.hashCode ^
        provenance.hashCode ^
        puissance.hashCode ^
        energie.hashCode ^
        annee_mise_circulation.hashCode ^
        derniere_revision.hashCode ^
        etat.hashCode ^
        type.hashCode ^
        marque.hashCode ^
        model.hashCode ^
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
