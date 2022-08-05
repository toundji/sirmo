import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sirmo/models/audit.dart';

import 'payement.dart';
import 'police.dart';
import 'type-amande.dart';
import 'conducteur.dart';

class Amande implements Audit {
  int? id;

  String? message;

  int? montant;

  DateTime? date_limite;

  int? restant;

  List<TypeAmande>? typeAmndes;

  List<Payement>? payements;

  Police? police;

  Conducteur? conducteur;

  @override
  DateTime? created_at;

  @override
  int? createur_id;

  @override
  int? editeur_id;

  @override
  DateTime? updated_at;
  Amande({
    this.id,
    this.message,
    this.montant,
    this.date_limite,
    this.restant,
    this.typeAmndes,
    this.payements,
    this.police,
    this.conducteur,
    this.created_at,
    this.createur_id,
    this.editeur_id,
    this.updated_at,
  });

  Amande copyWith({
    int? id,
    String? message,
    int? montant,
    DateTime? date_limite,
    int? restant,
    List<TypeAmande>? typeAmndes,
    List<Payement>? payements,
    Police? police,
    Conducteur? conducteur,
    DateTime? created_at,
    int? createur_id,
    int? editeur_id,
    DateTime? updated_at,
  }) {
    return Amande(
      id: id ?? this.id,
      message: message ?? this.message,
      montant: montant ?? this.montant,
      date_limite: date_limite ?? this.date_limite,
      restant: restant ?? this.restant,
      typeAmndes: typeAmndes ?? this.typeAmndes,
      payements: payements ?? this.payements,
      police: police ?? this.police,
      conducteur: conducteur ?? this.conducteur,
      created_at: created_at ?? this.created_at,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'montant': montant,
      'date_limite': date_limite?.millisecondsSinceEpoch,
      'restant': restant,
      'typeAmndes': typeAmndes?.map((x) => x.toMap()).toList(),
      'payements': payements?.map((x) => x.toMap()).toList(),
      'police': police?.toMap(),
      'conducteur': conducteur?.toMap(),
      'created_at': created_at?.toIso8601String(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  Map<String, dynamic> toCreateMap() {
    return {
      if (message != null) 'message': message,
      'typeAmndeIds': typeAmndes?.map((x) => x.id).toList(),
      'conducteur_id': conducteur?.id,
    };
  }

  factory Amande.fromMap(Map<String, dynamic> map) {
    return Amande(
      id: map['id']?.toInt(),
      message: map['message'],
      montant: map['montant']?.toInt(),
      date_limite: map['date_limite'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_limite'])
          : null,
      restant: map['restant']?.toInt(),
      typeAmndes: map['typeAmndes'] != null
          ? List<TypeAmande>.from(
              map['typeAmndes']?.map((x) => TypeAmande.fromMap(x)))
          : null,
      payements: map['payements'] != null
          ? List<Payement>.from(
              map['payements']?.map((x) => Payement.fromMap(x)))
          : null,
      police: map['police'] != null ? Police.fromMap(map['police']) : null,
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
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

  factory Amande.fromJson(String source) => Amande.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Amande(id: $id, message: $message, montant: $montant, date_limite: $date_limite, restant: $restant, typeAmndes: $typeAmndes, payements: $payements, police: $police, conducteur: $conducteur, created_at: $created_at, createur_id: $createur_id, editeur_id: $editeur_id, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Amande &&
        other.id == id &&
        other.message == message &&
        other.montant == montant &&
        other.date_limite == date_limite &&
        other.restant == restant &&
        listEquals(other.typeAmndes, typeAmndes) &&
        listEquals(other.payements, payements) &&
        other.police == police &&
        other.conducteur == conducteur &&
        other.created_at == created_at &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        montant.hashCode ^
        date_limite.hashCode ^
        restant.hashCode ^
        typeAmndes.hashCode ^
        payements.hashCode ^
        police.hashCode ^
        conducteur.hashCode ^
        created_at.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        updated_at.hashCode;
  }
}
