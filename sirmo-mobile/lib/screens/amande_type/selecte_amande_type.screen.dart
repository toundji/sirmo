import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/models/amande.dart';

import 'package:sirmo/models/conducteur.dart';
import 'package:sirmo/models/type-amande.dart';
import 'package:sirmo/services/amande.service.dart';
import 'package:sirmo/services/type-amande.service.dart';

import '../../components/app-decore.dart';
import '../../components/personal_alert.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../licence/licence-create.screen.dart';

class SelecteAmandeTypeScreen extends StatefulWidget {
  const SelecteAmandeTypeScreen({
    Key? key,
    required this.conducteur,
  }) : super(key: key);
  final Conducteur conducteur;

  @override
  State<SelecteAmandeTypeScreen> createState() =>
      _SelecteAmandeTypeScreenState();
}

class _SelecteAmandeTypeScreenState extends State<SelecteAmandeTypeScreen> {
  Amande amande = Amande();
  @override
  void initState() {
    super.initState();
    amande.conducteur = widget.conducteur;
    amande.typeAmndes = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Types d'amandes"),
      body: Center(
        child: FutureBuilder<List<TypeAmande>?>(
          future: context.read<TypeAmandeService>().loadAll(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text("Aucune Amaande trouvée");
              } else {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Selectionner les amandes appliquées au zem",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16.0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return amandeTypeWidget(snapshot.data![index]);
                          }),
                    )
                  ],
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: amande.typeAmndes!.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: submit,
              label: const Text(
                "Valider",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
    );
  }

  submit() async {
    PersonalAlert.showLoading(context);
    await context.read<AmandeService>().createAmande(amande).then((value) {
      PersonalAlert.showSuccess(context, message: "Amande créée avec succès")
          .then((value) {
        Navigator.pop(context);
      });
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error");
    });
  }

  Widget amandeTypeWidget(TypeAmande type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: ColorConst.primary.withOpacity(0.3))),
        title: Text(
          "${type.nom}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "${type.description}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        onTap: () {
          bool value = amande.typeAmndes!.contains(type);
          if (!value) {
            setState(() {
              amande.typeAmndes!.add(type);
            });
          } else if (value) {
            setState(() {
              amande.typeAmndes!.remove(type);
            });
          }
        },
        onLongPress: () => PersonalAlert.dialog(context,
            title: type.nom ?? "",
            message: type.description ?? "Aucune description n'est fournie"),
        trailing: Checkbox(
            value: amande.typeAmndes!.contains(type),
            onChanged: (value) {
              if (value != null && value) {
                setState(() {
                  amande.typeAmndes!.add(type);
                });
              } else if (value != null && !value) {
                setState(() {
                  amande.typeAmndes!.remove(type);
                });
              }
            }),
      ),
    );
  }
}
