import 'dart:convert';

import 'audit.dart';
import 'conducteur.dart';
import 'mairie.dart';
import 'vehicule.dart';

class LicenceVehicule implements Audit {
  int? id;

  int? montant;

  int? solde_mairie;

  String? type_payement;

  String? transaction_id;

  String? transaction_info;

  DateTime? date_debut;

  DateTime? date_fin;

  String? status;

  Conducteur? conducteur;

  Vehicule? vehicule;

  Mairie? mairie;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  LicenceVehicule({
    this.id,
    this.montant,
    this.solde_mairie,
    this.type_payement,
    this.transaction_id,
    this.transaction_info,
    this.date_debut,
    this.date_fin,
    this.status,
    this.conducteur,
    this.vehicule,
    this.mairie,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  LicenceVehicule copyWith({
    int? id,
    int? montant,
    int? solde_mairie,
    String? type_payement,
    String? transaction_id,
    String? transaction_info,
    DateTime? date_debut,
    DateTime? date_fin,
    String? status,
    Conducteur? conducteur,
    Vehicule? vehicule,
    Mairie? mairie,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return LicenceVehicule(
      id: id ?? this.id,
      montant: montant ?? this.montant,
      solde_mairie: solde_mairie ?? this.solde_mairie,
      type_payement: type_payement ?? this.type_payement,
      transaction_id: transaction_id ?? this.transaction_id,
      transaction_info: transaction_info ?? this.transaction_info,
      date_debut: date_debut ?? this.date_debut,
      date_fin: date_fin ?? this.date_fin,
      status: status ?? this.status,
      conducteur: conducteur ?? this.conducteur,
      vehicule: vehicule ?? this.vehicule,
      mairie: mairie ?? this.mairie,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'solde_mairie': solde_mairie,
      'type_payement': type_payement,
      'transaction_id': transaction_id,
      'transaction_info': transaction_info,
      'date_debut': date_debut?.toIso8601String(),
      'date_fin': date_fin?.toIso8601String(),
      'status': status,
      'conducteur': conducteur?.toMap(),
      'vehicule': vehicule?.toMap(),
      'mairie': mairie?.toMap(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  factory LicenceVehicule.fromMap(Map<String, dynamic> map) {
    return LicenceVehicule(
      id: map['id']?.toInt(),
      montant: map['montant']?.toInt(),
      solde_mairie: map['solde_mairie']?.toInt(),
      type_payement: map['type_payement'],
      transaction_id: map['transaction_id'],
      transaction_info: map['transaction_info'],
      date_debut: map['date_debut'] != null
          ? DateTime.tryParse(map['date_debut'])
          : null,
      date_fin:
          map['date_fin'] != null ? DateTime.tryParse(map['date_fin']) : null,
      status: map['status'],
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
          : null,
      vehicule:
          map['vehicule'] != null ? Vehicule.fromMap(map['vehicule']) : null,
      mairie: map['mairie'] != null ? Mairie.fromMap(map['mairie']) : null,
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

  factory LicenceVehicule.fromJson(String source) =>
      LicenceVehicule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LicenceVehicule(id: $id, montant: $montant, solde_mairie: $solde_mairie, type_payement: $type_payement, transaction_id: $transaction_id, transaction_info: $transaction_info, date_debut: $date_debut, date_fin: $date_fin, status: $status, conducteur: $conducteur, vehicule: $vehicule, mairie: $mairie, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LicenceVehicule &&
        other.id == id &&
        other.montant == montant &&
        other.solde_mairie == solde_mairie &&
        other.type_payement == type_payement &&
        other.transaction_id == transaction_id &&
        other.transaction_info == transaction_info &&
        other.date_debut == date_debut &&
        other.date_fin == date_fin &&
        other.status == status &&
        other.conducteur == conducteur &&
        other.vehicule == vehicule &&
        other.mairie == mairie &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        montant.hashCode ^
        solde_mairie.hashCode ^
        type_payement.hashCode ^
        transaction_id.hashCode ^
        transaction_info.hashCode ^
        date_debut.hashCode ^
        date_fin.hashCode ^
        status.hashCode ^
        conducteur.hashCode ^
        vehicule.hashCode ^
        mairie.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
