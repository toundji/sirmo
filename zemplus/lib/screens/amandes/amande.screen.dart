import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/amande.dart';
import 'package:sirmo/models/conducteur.dart';
import 'package:sirmo/services/amande.service.dart';
import 'package:sirmo/utils/app-date.dart';

import '../../components/personal_alert.dart';
import '../../utils/color-const.dart';

class AmandeScreen extends StatefulWidget {
  AmandeScreen({
    Key? key,
    required this.conducteur,
  }) : super(key: key);
  final Conducteur conducteur;

  @override
  State<AmandeScreen> createState() => _AmandeScreenState();
}

class _AmandeScreenState extends State<AmandeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Amandes"),
      body: FutureBuilder<List<Amande>>(
        future: context
            .read<AmandeService>()
            .loadAll(widget.conducteur, refresh: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Text("Le conducteur n'a aucun amande");
            } else {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Voici la liste des amandes du conducteur",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16.0),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return amandeWidget(snapshot.data![index]);
                        }),
                  )
                ],
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget amandeWidget(Amande amande) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: ColorConst.primary.withOpacity(0.3))),
        title: Text(
          "${amande.montant}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          amande.date_limite == null
              ? ""
              : AppDate.dayDateFormatString.format(amande.date_limite!),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        onLongPress: () => PersonalAlert.dialog(context,
            title: "${amande.montant ?? ""}", message: "$amande"),
        trailing: amande.montant != null && amande.montant! <= 0
            ? Icon(Icons.thumb_up, color: ColorConst.primary)
            : Icon(Icons.thumb_down, color: ColorConst.error),
      ),
    );
  }
}
