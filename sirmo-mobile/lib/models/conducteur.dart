import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/audit.dart';

import 'amande.dart';
import 'appreciation.dart';
import 'licence.dart';
import 'vehicule.dart';
import 'user.dart';
import 'conducteur_vehicule.dart';

class Conducteur implements Audit {
  User? user;

  int? id;

  String? ifu;

  String? cip;

  String? nip;

  String? nic;

  String? compteEcobank;

  String? compteFedapay;

  String? permis;

  String? idCarde;

  String? statut;

  String? ancienIdentifiant;

  //licence en cours
  Licence? licence;

  Vehicule? vehicule;

  List<Licence>? licences;

  // List des anciens vehicules conduit
  List<ConducteurVehicule>? conducteurvehicules;

  //  Compte? compte;

  List<Appreciation>? appreciations;

  List<Amande>? amandes;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;

  static String get ACTIF => "ACTIF";
  static String get DESATIVE => "DESACTIVE";
  static String get DEMANDE => "DEMANDE";

  Conducteur({
    this.user,
    this.id,
    this.ifu,
    this.cip,
    this.nip,
    this.nic,
    this.compteEcobank,
    this.compteFedapay,
    this.permis,
    this.idCarde,
    this.statut,
    this.ancienIdentifiant,
    this.licence,
    this.vehicule,
    this.licences,
    this.conducteurvehicules,
    this.appreciations,
    this.amandes,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Conducteur copyWith({
    User? user,
    int? id,
    String? ifu,
    String? cip,
    String? nip,
    String? nic,
    String? compteEcobank,
    String? compteFedapay,
    String? permis,
    String? idCarde,
    String? statut,
    String? ancienIdentifiant,
    Licence? licence,
    Vehicule? vehicule,
    List<Licence>? licences,
    List<ConducteurVehicule>? conducteurvehicules,
    List<Appreciation>? appreciations,
    List<Amande>? amandes,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Conducteur(
      user: user ?? this.user,
      id: id ?? this.id,
      ifu: ifu ?? this.ifu,
      cip: cip ?? this.cip,
      nip: nip ?? this.nip,
      nic: nic ?? this.nic,
      compteEcobank: compteEcobank ?? this.compteEcobank,
      compteFedapay: compteFedapay ?? this.compteFedapay,
      permis: permis ?? this.permis,
      idCarde: idCarde ?? this.idCarde,
      statut: statut ?? this.statut,
      ancienIdentifiant: ancienIdentifiant ?? this.ancienIdentifiant,
      licence: licence ?? this.licence,
      vehicule: vehicule ?? this.vehicule,
      licences: licences ?? this.licences,
      conducteurvehicules: conducteurvehicules ?? this.conducteurvehicules,
      appreciations: appreciations ?? this.appreciations,
      amandes: amandes ?? this.amandes,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'id': id,
      'ifu': ifu,
      'cip': cip,
      'nip': nip,
      'nic': nic,
      'compteEcobank': compteEcobank,
      'compteFedapay': compteFedapay,
      'permis': permis,
      'idCarde': idCarde,
      'statut': statut,
      'ancienIdentifiant': ancienIdentifiant,
      'licence': licence?.toMap(),
      'vehicule': vehicule?.toMap(),
      'licences': licences?.map((x) => x.toMap()).toList(),
      'conducteurvehicules':
          conducteurvehicules?.map((x) => x.toMap()).toList(),
      'appreciations': appreciations?.map((x) => x.toMap()).toList(),
      'amandes': amandes?.map((x) => x.toMap()).toList(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Conducteur.fromMap(Map<String, dynamic> map) {
    return Conducteur(
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      id: map['id']?.toInt(),
      ifu: map['ifu'],
      cip: map['cip'],
      nip: map['nip'],
      nic: map['nic'],
      compteEcobank: map['compteEcobank'],
      compteFedapay: map['compteFedapay'],
      permis: map['permis'],
      idCarde: map['idCarde'],
      statut: map['statut'],
      ancienIdentifiant: map['ancienIdentifiant'],
      licence: map['licence'] != null ? Licence.fromMap(map['licence']) : null,
      vehicule:
          map['vehicule'] != null ? Vehicule.fromMap(map['vehicule']) : null,
      licences: map['licences'] != null
          ? List<Licence>.from(map['licences']?.map((x) => Licence.fromMap(x)))
          : null,
      conducteurvehicules: map['conducteurvehicules'] != null
          ? List<ConducteurVehicule>.from(map['conducteurvehicules']
              ?.map((x) => ConducteurVehicule.fromMap(x)))
          : null,
      appreciations: map['appreciations'] != null
          ? List<Appreciation>.from(
              map['appreciations']?.map((x) => Appreciation.fromMap(x)))
          : null,
      amandes: map['amandes'] != null
          ? List<Amande>.from(map['amandes']?.map((x) => Amande.fromMap(x)))
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

  factory Conducteur.fromJson(String source) =>
      Conducteur.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Conducteur(user: $user, id: $id, ifu: $ifu, cip: $cip, nip: $nip, nic: $nic, compteEcobank: $compteEcobank, compteFedapay: $compteFedapay, permis: $permis, idCarde: $idCarde, statut: $statut, ancienIdentifiant: $ancienIdentifiant, licence: $licence, vehicule: $vehicule, licences: $licences, conducteurvehicules: $conducteurvehicules, appreciations: $appreciations, amandes: $amandes, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conducteur &&
        other.user == user &&
        other.id == id &&
        other.ifu == ifu &&
        other.cip == cip &&
        other.nip == nip &&
        other.nic == nic &&
        other.compteEcobank == compteEcobank &&
        other.compteFedapay == compteFedapay &&
        other.permis == permis &&
        other.idCarde == idCarde &&
        other.statut == statut &&
        other.ancienIdentifiant == ancienIdentifiant &&
        other.licence == licence &&
        other.vehicule == vehicule &&
        listEquals(other.licences, licences) &&
        listEquals(other.conducteurvehicules, conducteurvehicules) &&
        listEquals(other.appreciations, appreciations) &&
        listEquals(other.amandes, amandes) &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        id.hashCode ^
        ifu.hashCode ^
        cip.hashCode ^
        nip.hashCode ^
        nic.hashCode ^
        compteEcobank.hashCode ^
        compteFedapay.hashCode ^
        permis.hashCode ^
        idCarde.hashCode ^
        statut.hashCode ^
        ancienIdentifiant.hashCode ^
        licence.hashCode ^
        vehicule.hashCode ^
        licences.hashCode ^
        conducteurvehicules.hashCode ^
        appreciations.hashCode ^
        amandes.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
