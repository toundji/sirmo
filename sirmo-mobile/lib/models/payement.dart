import 'dart:convert';

import 'package:sirmo/models/audit.dart';

import 'compte.dart';

class Payement implements Audit {
  int? id;

  int? montant;

  int? solde;

  String? type;

  String? operation;

  dynamic info;

  Compte? compte;

  int? createur_id;

  int? editeur_id;

  DateTime? created_at;

  DateTime? updated_at;
  Payement({
    this.id,
    this.montant,
    this.solde,
    this.type,
    this.operation,
    required this.info,
    this.compte,
    this.createur_id,
    this.editeur_id,
    this.created_at,
    this.updated_at,
  });

  Payement copyWith({
    int? id,
    int? montant,
    int? solde,
    String? type,
    String? operation,
    dynamic? info,
    Compte? compte,
    int? createur_id,
    int? editeur_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Payement(
      id: id ?? this.id,
      montant: montant ?? this.montant,
      solde: solde ?? this.solde,
      type: type ?? this.type,
      operation: operation ?? this.operation,
      info: info ?? this.info,
      compte: compte ?? this.compte,
      createur_id: createur_id ?? this.createur_id,
      editeur_id: editeur_id ?? this.editeur_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'solde': solde,
      'type': type,
      'operation': operation,
      'info': info,
      'compte': compte?.toMap(),
      'createur_id': createur_id,
      'editeur_id': editeur_id,
      'created_at': created_at?.millisecondsSinceEpoch,
      'updated_at': updated_at?.millisecondsSinceEpoch,
    };
  }

  factory Payement.fromMap(Map<String, dynamic> map) {
    return Payement(
      id: map['id']?.toInt(),
      montant: map['montant']?.toInt(),
      solde: map['solde']?.toInt(),
      type: map['type'],
      operation: map['operation'],
      info: map['info'] == null ? null : json.decode(map['info']),
      compte: map['compte'] != null ? Compte.fromMap(map['compte']) : null,
      createur_id: map['createur_id']?.toInt(),
      editeur_id: map['editeur_id']?.toInt(),
      created_at: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updated_at: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Payement.fromJson(String source) =>
      Payement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payement(id: $id, montant: $montant, solde: $solde, type: $type, operation: $operation, info: $info, compte: $compte, createur_id: $createur_id, editeur_id: $editeur_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payement &&
        other.id == id &&
        other.montant == montant &&
        other.solde == solde &&
        other.type == type &&
        other.operation == operation &&
        other.info == info &&
        other.compte == compte &&
        other.createur_id == createur_id &&
        other.editeur_id == editeur_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        montant.hashCode ^
        solde.hashCode ^
        type.hashCode ^
        operation.hashCode ^
        info.hashCode ^
        compte.hashCode ^
        createur_id.hashCode ^
        editeur_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
