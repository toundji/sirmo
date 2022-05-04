import 'amande.dart';
import 'appreciation.dart';
import 'licence.dart';
import 'moto.dart';
import 'user.dart';
import 'zem_moto.dart';

class Zem {
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

  DateTime? create_at;

  DateTime? update_at;
}
