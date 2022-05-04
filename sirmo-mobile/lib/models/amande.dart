import 'payement.dart';
import 'police.dart';
import 'type-amande.dart';
import 'zem.dart';

class Amande {
  int? id;

  String? message;

  int? montant;

  DateTime? date_limite;

  int? restant;

  List<TypeAmande>? typeAmndes;

  List<Payement>? payements;

  Police? police;

  Zem? zem;

  int? editeur_id;

  DateTime? create_at;

  DateTime? update_at;
}
