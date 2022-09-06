import 'dart:convert';

import 'package:sirmo/models/payement.dart';

import 'audit.dart';
import 'mairie.dart';
import 'conducteur.dart';

class Licence implements Audit {
  int? id;

  int? montant;

  DateTime? date_debut;

  DateTime? date_fin;

  Conducteur? conducteur;

  Mairie? mairie;

  Payement? payement;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Licence({
    this.id,
    this.montant,
    this.date_debut,
    this.date_fin,
    this.conducteur,
    this.mairie,
    this.payement,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Licence copyWith({
    int? id,
    int? montant,
    DateTime? date_debut,
    DateTime? date_fin,
    Conducteur? conducteur,
    Mairie? mairie,
    Payement? payement,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Licence(
      id: id ?? this.id,
      montant: montant ?? this.montant,
      date_debut: date_debut ?? this.date_debut,
      date_fin: date_fin ?? this.date_fin,
      conducteur: conducteur ?? this.conducteur,
      mairie: mairie ?? this.mairie,
      payement: payement ?? this.payement,
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
      'date_debut': date_debut?.millisecondsSinceEpoch,
      'date_fin': date_fin?.millisecondsSinceEpoch,
      'conducteur': conducteur?.toMap(),
      'mairie': mairie?.toMap(),
      'payement': payement?.toMap(),
      'created_at': created_at?.millisecondsSinceEpoch,
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Licence.fromMap(Map<String, dynamic> map) {
    return Licence(
      id: map['id']?.toInt(),
      montant: map['montant']?.toInt(),
      date_debut: map['date_debut'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_debut'])
          : null,
      date_fin: map['date_fin'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_fin'])
          : null,
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
          : null,
      mairie: map['mairie'] != null ? Mairie.fromMap(map['mairie']) : null,
      payement:
          map['payement'] != null ? Payement.fromMap(map['payement']) : null,
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

  factory Licence.fromJson(String source) =>
      Licence.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Licence(id: $id, montant: $montant, date_debut: $date_debut, date_fin: $date_fin, conducteur: $conducteur, mairie: $mairie, payement: $payement, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Licence &&
        other.id == id &&
        other.montant == montant &&
        other.date_debut == date_debut &&
        other.date_fin == date_fin &&
        other.conducteur == conducteur &&
        other.mairie == mairie &&
        other.payement == payement &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        montant.hashCode ^
        date_debut.hashCode ^
        date_fin.hashCode ^
        conducteur.hashCode ^
        mairie.hashCode ^
        payement.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
