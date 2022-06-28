import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/audit.dart';

import 'amande.dart';
import 'appreciation.dart';
import 'licence.dart';
import 'moto.dart';
import 'user.dart';
import 'zem_moto.dart';

class Zem implements Audit {
  User? user;

  int? id;

  String? ifu;

  String? cip;

  String? nip;

  String? niz;

  String? compteEcobank;

  String? compteFedapay;

  String? certificatRoute;

  String? statut;

  String? ancienIdentifiant;

  //licence en cours
  Licence? licence;

  Moto? moto;

  List<Licence>? licences;

  // List des anciens motos conduit
  List<ZemMoto>? zemMotos;

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
  Zem({
    this.user,
    this.id,
    this.ifu,
    this.cip,
    this.nip,
    this.niz,
    this.compteEcobank,
    this.compteFedapay,
    this.certificatRoute,
    this.statut,
    this.ancienIdentifiant,
    this.licence,
    this.moto,
    this.licences,
    this.zemMotos,
    this.appreciations,
    this.amandes,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Zem copyWith({
    User? user,
    int? id,
    String? ifu,
    String? cip,
    String? nip,
    String? niz,
    String? compteEcobank,
    String? compteFedapay,
    String? certificatRoute,
    String? statut,
    String? ancienIdentifiant,
    Licence? licence,
    Moto? moto,
    List<Licence>? licences,
    List<ZemMoto>? zemMotos,
    List<Appreciation>? appreciations,
    List<Amande>? amandes,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Zem(
      user: user ?? this.user,
      id: id ?? this.id,
      ifu: ifu ?? this.ifu,
      cip: cip ?? this.cip,
      nip: nip ?? this.nip,
      niz: niz ?? this.niz,
      compteEcobank: compteEcobank ?? this.compteEcobank,
      compteFedapay: compteFedapay ?? this.compteFedapay,
      certificatRoute: certificatRoute ?? this.certificatRoute,
      statut: statut ?? this.statut,
      ancienIdentifiant: ancienIdentifiant ?? this.ancienIdentifiant,
      licence: licence ?? this.licence,
      moto: moto ?? this.moto,
      licences: licences ?? this.licences,
      zemMotos: zemMotos ?? this.zemMotos,
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
      'niz': niz,
      'compteEcobank': compteEcobank,
      'compteFedapay': compteFedapay,
      'certificatRoute': certificatRoute,
      'statut': statut,
      'ancienIdentifiant': ancienIdentifiant,
      'licence': licence?.toMap(),
      'moto': moto?.toMap(),
      'licences': licences?.map((x) => x?.toMap())?.toList(),
      'zemMotos': zemMotos?.map((x) => x?.toMap())?.toList(),
      'appreciations': appreciations?.map((x) => x?.toMap())?.toList(),
      'amandes': amandes?.map((x) => x?.toMap())?.toList(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Zem.fromMap(Map<String, dynamic> map) {
    return Zem(
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      id: map['id']?.toInt(),
      ifu: map['ifu'],
      cip: map['cip'],
      nip: map['nip'],
      niz: map['niz'],
      compteEcobank: map['compteEcobank'],
      compteFedapay: map['compteFedapay'],
      certificatRoute: map['certificatRoute'],
      statut: map['statut'],
      ancienIdentifiant: map['ancienIdentifiant'],
      licence: map['licence'] != null ? Licence.fromMap(map['licence']) : null,
      moto: map['moto'] != null ? Moto.fromMap(map['moto']) : null,
      licences: map['licences'] != null
          ? List<Licence>.from(map['licences']?.map((x) => Licence.fromMap(x)))
          : null,
      zemMotos: map['zemMotos'] != null
          ? List<ZemMoto>.from(map['zemMotos']?.map((x) => ZemMoto.fromMap(x)))
          : null,
      appreciations: map['appreciations'] != null
          ? List<Appreciation>.from(
              map['appreciations']?.map((x) => Appreciation.fromMap(x)))
          : null,
      amandes: map['amandes'] != null
          ? List<Amande>.from(map['amandes']?.map((x) => Amande.fromMap(x)))
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

  factory Zem.fromJson(String source) => Zem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Zem(user: $user, id: $id, ifu: $ifu, cip: $cip, nip: $nip, niz: $niz, compteEcobank: $compteEcobank, compteFedapay: $compteFedapay, certificatRoute: $certificatRoute, statut: $statut, ancienIdentifiant: $ancienIdentifiant, licence: $licence, moto: $moto, licences: $licences, zemMotos: $zemMotos, appreciations: $appreciations, amandes: $amandes, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Zem &&
        other.user == user &&
        other.id == id &&
        other.ifu == ifu &&
        other.cip == cip &&
        other.nip == nip &&
        other.niz == niz &&
        other.compteEcobank == compteEcobank &&
        other.compteFedapay == compteFedapay &&
        other.certificatRoute == certificatRoute &&
        other.statut == statut &&
        other.ancienIdentifiant == ancienIdentifiant &&
        other.licence == licence &&
        other.moto == moto &&
        listEquals(other.licences, licences) &&
        listEquals(other.zemMotos, zemMotos) &&
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
        niz.hashCode ^
        compteEcobank.hashCode ^
        compteFedapay.hashCode ^
        certificatRoute.hashCode ^
        statut.hashCode ^
        ancienIdentifiant.hashCode ^
        licence.hashCode ^
        moto.hashCode ^
        licences.hashCode ^
        zemMotos.hashCode ^
        appreciations.hashCode ^
        amandes.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
