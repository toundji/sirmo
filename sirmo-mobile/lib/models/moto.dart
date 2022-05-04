import 'fichier.dart';
import 'proprietaire-moto.dart';
import 'user.dart';
import 'zem.dart';
import 'zem_moto.dart';

class Moto {
  int? id;

  String? matricule;

  String? carteGrise;

  String? chassis;

  String? serie;

  String? etat;

  User? proprietaire;

  Zem? zem;

  List<ZemMoto>? zemMotos;

  List<ProprietaireMoto>? proprietaireMotos;

  Fichier? image;

  List<Fichier>? images;
  int? createur_id;

  int? editeur_id;

  DateTime? create_at;

  DateTime? update_at;
}
