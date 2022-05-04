import 'arrondissement.dart';
import 'commune.dart';
import 'fichier.dart';
import 'licence.dart';
import 'localisation.dart';

class Mairie {
  int? id;

  String? nom;

  String? adresse;

  String? couleur;

  int? solde;

  Arrondissement? arrondissement;

  Localisation? localisation;

  List<Licence>? licences;

  Commune? commune;

  Fichier? image;

  List<Fichier>? images;

  int? createur_id;

  int? editeur_id;

  DateTime? create_at;

  DateTime? update_at;
}
