import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sirmo/models/licence_vehicule.dart';
import 'package:sirmo/utils/app-date.dart';

import 'audit.dart';
import 'conducteur.dart';
import 'conducteur_vehicule.dart';
import 'fichier.dart';
import 'proprietaire-vehicule.dart';
import 'user.dart';

class Vehicule implements Audit {
  int? id;

  String? immatriculation;

  String? numero_carte_grise;

  String? numero_chassis;

  String? numero_serie;

  String? numero_serie_moteur;

  String? provenance;

  String? puissance;

  String? energie;

  DateTime? annee_mise_circulation;

  DateTime? derniere_revision;

  String? etat;

  String? type;

  String? marque;

  String? modele;

  String? couleur;

  String? pays_immatriculation;

  String? puissance_fiscale;

  String? carosserie;

  String? categorie;

  int? place_assise;

  String? ptac;

  String? pv;

  String? cv;

  String? ci_er;

  User? proprietaire;

  Conducteur? conducteur;
  LicenceVehicule? licence;

  List<ConducteurVehicule>? conducteurvehicules;

  List<ProprietaireVehicule>? proprietairevehicules;
  List<LicenceVehicule>? licences;

  String? image_path;

  List<Fichier>? images;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Vehicule({
    this.id,
    this.immatriculation,
    this.numero_carte_grise,
    this.numero_chassis,
    this.numero_serie,
    this.numero_serie_moteur,
    this.provenance,
    this.puissance,
    this.energie,
    this.annee_mise_circulation,
    this.derniere_revision,
    this.etat,
    this.type,
    this.marque,
    this.modele,
    this.ci_er,
    this.couleur,
    this.pays_immatriculation,
    this.puissance_fiscale,
    this.carosserie,
    this.categorie,
    this.place_assise,
    this.ptac,
    this.pv,
    this.cv,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
    this.proprietaire,
    this.conducteur,
    this.licence,
    this.conducteurvehicules,
    this.proprietairevehicules,
    this.image_path,
    this.images,
    this.licences,
  });

  static String get NEUF => 'NEUF';
  static String get OCASION => 'OCASION';
  static String get GATE => 'GATE';
  static String get SUPPRIMER => 'SUPPRIMER';

  static List<String> get ETATS => ["NEUF", "OCASION", "GATE", "SUPPRIMER"];

  Vehicule copyWith({
    int? id,
    String? immatriculation,
    String? numero_carte_grise,
    String? numero_chassis,
    String? numero_serie,
    String? numero_serie_moteur,
    String? provenance,
    String? puissance,
    String? energie,
    DateTime? annee_mise_circulation,
    DateTime? derniere_revision,
    String? etat,
    String? type,
    String? marque,
    String? modele,
    String? couleur,
    LicenceVehicule? licence,
    String? pays_immatriculation,
    String? puissance_fiscale,
    String? carosserie,
    String? categorie,
    int? place_assise,
    String? ptac,
    String? pv,
    String? cv,
    String? ci_er,
    User? proprietaire,
    Conducteur? conducteur,
    List<ConducteurVehicule>? conducteurvehicules,
    List<ProprietaireVehicule>? proprietairevehicules,
    String? image_path,
    List<Fichier>? images,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
    List<LicenceVehicule>? licences,
  }) {
    return Vehicule(
      id: id ?? this.id,
      immatriculation: immatriculation ?? this.immatriculation,
      numero_carte_grise: numero_carte_grise ?? this.numero_carte_grise,
      numero_chassis: numero_chassis ?? this.numero_chassis,
      numero_serie: numero_serie ?? this.numero_serie,
      numero_serie_moteur: numero_serie_moteur ?? this.numero_serie_moteur,
      provenance: provenance ?? this.provenance,
      puissance: puissance ?? this.puissance,
      energie: energie ?? this.energie,
      licence: licence ?? this.licence,
      annee_mise_circulation:
          annee_mise_circulation ?? this.annee_mise_circulation,
      derniere_revision: derniere_revision ?? this.derniere_revision,
      etat: etat ?? this.etat,
      type: type ?? this.type,
      marque: marque ?? this.marque,
      modele: modele ?? this.modele,
      couleur: couleur ?? this.couleur,
      pays_immatriculation: pays_immatriculation ?? this.pays_immatriculation,
      puissance_fiscale: puissance_fiscale ?? this.puissance_fiscale,
      carosserie: carosserie ?? this.carosserie,
      categorie: categorie ?? this.categorie,
      place_assise: place_assise ?? this.place_assise,
      ptac: ptac ?? this.ptac,
      pv: pv ?? this.pv,
      cv: cv ?? this.cv,
      ci_er: ci_er ?? this.ci_er,
      proprietaire: proprietaire ?? this.proprietaire,
      conducteur: conducteur ?? this.conducteur,
      conducteurvehicules: conducteurvehicules ?? this.conducteurvehicules,
      proprietairevehicules:
          proprietairevehicules ?? this.proprietairevehicules,
      image_path: image_path ?? this.image_path,
      images: images ?? this.images,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
      licences: licences ?? this.licences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'immatriculation': immatriculation,
      'numero_carte_grise': numero_carte_grise,
      'numero_chassis': numero_chassis,
      'numero_serie': numero_serie,
      'numero_serie_moteur': numero_serie_moteur,
      'provenance': provenance,
      'puissance': puissance,
      'energie': energie,
      'annee_mise_circulation': annee_mise_circulation?.toIso8601String(),
      'derniere_revision': derniere_revision?.toIso8601String(),
      'etat': etat,
      'type': type,
      'marque': marque,
      'modele': modele,
      'couleur': couleur,
      'pays_immatriculation': pays_immatriculation,
      'puissance_fiscale': puissance_fiscale,
      'carosserie': carosserie,
      'categorie': categorie,
      'place_assise': place_assise,
      'ptac': ptac,
      'pv': pv,
      'cv': cv,
      'ci_er': ci_er,
      'licence': licence?.toMap(),
      'proprietaire': proprietaire?.toMap(),
      'conducteur': conducteur?.toMap(),
      'conducteurvehicules':
          conducteurvehicules?.map((x) => x.toMap()).toList(),
      'proprietairevehicules':
          proprietairevehicules?.map((x) => x.toMap()).toList(),
      'image_path': image_path,
      'images': images?.map((x) => x.toMap()).toList(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
      'licences': licences?.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toDisplayMap() {
    return {
      'Immatriculation': immatriculation,
      'Numero de la carte grise': numero_carte_grise,
      'Numero chassis': numero_chassis,
      'Numero serie': numero_serie,
      'Numero serie moteur': numero_serie_moteur,
      'Provenance': provenance,
      'Puissance': puissance,
      'Energie': energie,
      'Annee de mise circulation': annee_mise_circulation?.toIso8601String(),
      'Date de la derniere revision': derniere_revision?.toIso8601String(),
      'Etat': etat,
      'Type': type,
      'Marque': marque,
      'Modele': modele,
      'Couleur': couleur,
      'Pays immatriculation': pays_immatriculation,
      'Puissance fiscale': puissance_fiscale,
      'Carosserie': carosserie,
      'Categorie': categorie,
      'Place assise': place_assise,
      'Ptac': ptac,
      'Pv': pv,
      'Cv': cv,
      if (proprietaire != null)
        'proprietaire': "${proprietaire?.nom} ${proprietaire?.prenom}",
      if (conducteur?.user != null)
        'conducteur': "${conducteur?.user?.nom} ${conducteur?.user?.prenom}",
      'Image': image_path == null
          ? "Le véhicule n'admet pas d'image"
          : "Le véhicule admet d'image",
      'Date Création': AppDate.dayDateFormat.format(created_at!),
      'Date de la dernière mise à jour':
          AppDate.dayDateFormat.format(created_at!),
    };
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'immatriculation': immatriculation,
      'numero_carte_grise': numero_carte_grise,
      'numero_chassis': numero_chassis,
      'numero_serie': numero_serie,
      'numero_serie_moteur': numero_serie_moteur,
      'provenance': provenance,
      'puissance': puissance,
      'energie': energie,
      'annee_mise_circulation': annee_mise_circulation?.toIso8601String(),
      'derniere_revision': derniere_revision?.toIso8601String(),
      'etat': etat,
      'type': type,
      'marque': marque,
      'modele': modele,
      'couleur': couleur,
      'pays_immatriculation': pays_immatriculation,
      'puissance_fiscale': puissance_fiscale,
      'carosserie': carosserie,
      'categorie': categorie,
      'place_assise': place_assise ?? 1,
      'ptac': ptac,
      'pv': pv,
      'cv': cv,
      "ci_er": ci_er,
      'proprietaire_id': proprietaire?.id,
      'conducteur_id': conducteur?.id,
    };
  }

  factory Vehicule.fromMap(Map<String, dynamic> map) {
    return Vehicule(
      id: map['id']?.toInt(),
      immatriculation: map['immatriculation'],
      numero_carte_grise: map['numero_carte_grise'],
      numero_chassis: map['numero_chassis'],
      numero_serie: map['numero_serie'],
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
      modele: map['modele'],
      couleur: map['couleur'],
      pays_immatriculation: map['pays_immatriculation'],
      puissance_fiscale: map['puissance_fiscale'],
      carosserie: map['carosserie'],
      categorie: map['categorie'],
      place_assise: map['place_assise']?.toInt(),
      ptac: map['ptac'],
      pv: map['pv'],
      cv: map['cv'],
      ci_er: map['ci_er'],
      proprietaire: map['proprietaire'] != null
          ? User.fromMap(map['proprietaire'])
          : null,
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
          : null,
      licence: map['licence'] != null
          ? LicenceVehicule.fromMap(map['licence'])
          : null,
      conducteurvehicules: map['conducteurvehicules'] != null
          ? List<ConducteurVehicule>.from(map['conducteurvehicules']
              ?.map((x) => ConducteurVehicule.fromMap(x)))
          : null,
      proprietairevehicules: map['proprietairevehicules'] != null
          ? List<ProprietaireVehicule>.from(map['proprietairevehicules']
              ?.map((x) => ProprietaireVehicule.fromMap(x)))
          : null,
      image_path: map['image_path'],
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
      licences: map['licences'] != null
          ? List<LicenceVehicule>.from(
              map['licences']?.map((x) => LicenceVehicule.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicule.fromJson(String source) =>
      Vehicule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicule(id: $id, immatriculation: $immatriculation, numero_carte_grise: $numero_carte_grise, numero_chassis: $numero_chassis, numero_serie: $numero_serie, numero_serie_moteur: $numero_serie_moteur, provenance: $provenance, puissance: $puissance, energie: $energie, annee_mise_circulation: $annee_mise_circulation, derniere_revision: $derniere_revision, etat: $etat, type: $type, marque: $marque, modele: $modele, couleur: $couleur, pays_immatriculation: $pays_immatriculation, puissance_fiscale: $puissance_fiscale, carosserie: $carosserie, categorie: $categorie, place_assise: $place_assise, ptac: $ptac, pv: $pv, cv: $cv, proprietaire: $proprietaire, conducteur: $conducteur, conducteurvehicules: $conducteurvehicules, proprietairevehicules: $proprietairevehicules, image_path: $image_path, images: $images, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vehicule &&
        other.id == id &&
        other.immatriculation == immatriculation &&
        other.numero_carte_grise == numero_carte_grise &&
        other.numero_chassis == numero_chassis &&
        other.numero_serie == numero_serie &&
        other.numero_serie_moteur == numero_serie_moteur &&
        other.provenance == provenance &&
        other.puissance == puissance &&
        other.energie == energie &&
        other.annee_mise_circulation == annee_mise_circulation &&
        other.derniere_revision == derniere_revision &&
        other.etat == etat &&
        other.type == type &&
        other.marque == marque &&
        other.modele == modele &&
        other.couleur == couleur &&
        other.pays_immatriculation == pays_immatriculation &&
        other.puissance_fiscale == puissance_fiscale &&
        other.carosserie == carosserie &&
        other.categorie == categorie &&
        other.place_assise == place_assise &&
        other.ptac == ptac &&
        other.pv == pv &&
        other.cv == cv &&
        other.proprietaire == proprietaire &&
        other.conducteur == conducteur &&
        listEquals(other.conducteurvehicules, conducteurvehicules) &&
        listEquals(other.proprietairevehicules, proprietairevehicules) &&
        other.image_path == image_path &&
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
        numero_serie.hashCode ^
        numero_serie_moteur.hashCode ^
        provenance.hashCode ^
        puissance.hashCode ^
        energie.hashCode ^
        annee_mise_circulation.hashCode ^
        derniere_revision.hashCode ^
        etat.hashCode ^
        type.hashCode ^
        marque.hashCode ^
        modele.hashCode ^
        couleur.hashCode ^
        pays_immatriculation.hashCode ^
        puissance_fiscale.hashCode ^
        carosserie.hashCode ^
        categorie.hashCode ^
        place_assise.hashCode ^
        ptac.hashCode ^
        pv.hashCode ^
        cv.hashCode ^
        proprietaire.hashCode ^
        conducteur.hashCode ^
        conducteurvehicules.hashCode ^
        proprietairevehicules.hashCode ^
        image_path.hashCode ^
        images.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
