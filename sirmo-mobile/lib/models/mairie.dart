import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'arrondissement.dart';
import 'commune.dart';
import 'fichier.dart';
import 'licence.dart';
import 'localisation.dart';

class Mairie {
  int? id;

  String? nom;

  String? adresse;

  String? couleur;

  int? solde;

  Arrondissement? arrondissement;

  Localisation? localisation;

  List<Licence>? licences;

  Commune? commune;

  Fichier? image;

  List<Fichier>? images;

  int? createur_id;

  int? editeur_id;

  DateTime? create_at;

  DateTime? update_at;
  Mairie({
    this.id,
    this.nom,
    this.adresse,
    this.couleur,
    this.solde,
    this.arrondissement,
    this.localisation,
    this.licences,
    this.commune,
    this.image,
    this.images,
    this.createur_id,
    this.editeur_id,
    this.create_at,
    this.update_at,
  });

  Mairie copyWith({
    int? id,
    String? nom,
    String? adresse,
    String? couleur,
    int? solde,
    Arrondissement? arrondissement,
    Localisation? localisation,
    List<Licence>? licences,
    Commune? commune,
    Fichier? image,
    List<Fichier>? images,
    int? createur_id,
    int? editeur_id,
    DateTime? create_at,
    DateTime? update_at,
  }) {
    return Mairie(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      adresse: adresse ?? this.adresse,
      couleur: couleur ?? this.couleur,
      solde: solde ?? this.solde,
      arrondissement: arrondissement ?? this.arrondissement,
      localisation: localisation ?? this.localisation,
      licences: licences ?? this.licences,
      commune: commune ?? this.commune,
      image: image ?? this.image,
      images: images ?? this.images,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      create_at: create_at ?? this.create_at,
      update_at: update_at ?? this.update_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'adresse': adresse,
      'couleur': couleur,
      'solde': solde,
      'arrondissement': arrondissement?.toMap(),
      'localisation': localisation?.toMap(),
      'licences': licences?.map((x) => x.toMap()).toList(),
      'commune': commune?.toMap(),
      'image': image?.toMap(),
      'images': images?.map((x) => x.toMap()).toList(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'create_at': create_at?.millisecondsSinceEpoch,
      'update_at': update_at?.millisecondsSinceEpoch,
    };
  }

  factory Mairie.fromMap(Map<String, dynamic> map) {
    return Mairie(
      id: map['id']?.toInt(),
      nom: map['nom'],
      adresse: map['adresse'],
      couleur: map['couleur'],
      solde: map['solde']?.toInt(),
      arrondissement: map['arrondissement'] != null
          ? Arrondissement.fromMap(map['arrondissement'])
          : null,
      localisation: map['localisation'] != null
          ? Localisation.fromMap(map['localisation'])
          : null,
      licences: map['licences'] != null
          ? List<Licence>.from(map['licences']?.map((x) => Licence.fromMap(x)))
          : null,
      commune: map['commune'] != null ? Commune.fromMap(map['commune']) : null,
      image: map['image'] != null ? Fichier.fromMap(map['image']) : null,
      images: map['images'] != null
          ? List<Fichier>.from(map['images']?.map((x) => Fichier.fromMap(x)))
          : null,
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      create_at: map['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['create_at'])
          : null,
      update_at: map['update_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['update_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Mairie.fromJson(String source) => Mairie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Mairie(id: $id, nom: $nom, adresse: $adresse, couleur: $couleur, solde: $solde, arrondissement: $arrondissement, localisation: $localisation, licences: $licences, commune: $commune, image: $image, images: $images, createur_id: $createur_id, editeur_id: $editeur_id, create_at: $create_at, update_at: $update_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Mairie &&
        other.id == id &&
        other.nom == nom &&
        other.adresse == adresse &&
        other.couleur == couleur &&
        other.solde == solde &&
        other.arrondissement == arrondissement &&
        other.localisation == localisation &&
        listEquals(other.licences, licences) &&
        other.commune == commune &&
        other.image == image &&
        listEquals(other.images, images) &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.create_at == create_at &&
        other.update_at == update_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        adresse.hashCode ^
        couleur.hashCode ^
        solde.hashCode ^
        arrondissement.hashCode ^
        localisation.hashCode ^
        licences.hashCode ^
        commune.hashCode ^
        image.hashCode ^
        images.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        create_at.hashCode ^
        update_at.hashCode;
  }
}
