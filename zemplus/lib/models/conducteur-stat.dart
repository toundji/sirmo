import 'dart:convert';

import 'conducteur.dart';

class ConducteurStat {
  double? excellence;
  double? tres_bon;
  double? bon;
  double? mauvais;
  Conducteur? conducteur;
  ConducteurStat({
    this.excellence,
    this.tres_bon,
    this.bon,
    this.mauvais,
    this.conducteur,
  });

  ConducteurStat copyWith({
    double? excellence,
    double? tres_bon,
    double? bon,
    double? mauvais,
    Conducteur? conducteur,
  }) {
    return ConducteurStat(
      excellence: excellence ?? this.excellence,
      tres_bon: tres_bon ?? this.tres_bon,
      bon: bon ?? this.bon,
      mauvais: mauvais ?? this.mauvais,
      conducteur: conducteur ?? this.conducteur,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'excellence': excellence,
      'tres_bon': tres_bon,
      'bon': bon,
      'mauvais': mauvais,
      'conducteur': conducteur?.toMap(),
    };
  }

  factory ConducteurStat.fromMap(Map<String, dynamic> map) {
    return ConducteurStat(
      excellence: double.tryParse("${map['excellence']}"),
      tres_bon: double.tryParse("${map['tres_bon']}"),
      bon: double.tryParse("${map['bon']}"),
      mauvais: double.tryParse("${map['mauvais']}"),
      conducteur: map['conducteur'] != null
          ? Conducteur.fromMap(map['conducteur'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConducteurStat.fromJson(String source) =>
      ConducteurStat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConducteurStat(excellence: $excellence, tres_bon: $tres_bon, bon: $bon, mauvais: $mauvais, conducteur: $conducteur)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConducteurStat &&
        other.excellence == excellence &&
        other.tres_bon == tres_bon &&
        other.bon == bon &&
        other.mauvais == mauvais &&
        other.conducteur == conducteur;
  }
}
