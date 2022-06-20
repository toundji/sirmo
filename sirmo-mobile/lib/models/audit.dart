import 'package:provider/provider.dart';

abstract class Audit {
  int? id;
  DateTime? created_at;
  DateTime? updated_at;
  int? createur_id;
  int? editeur_id;
}
