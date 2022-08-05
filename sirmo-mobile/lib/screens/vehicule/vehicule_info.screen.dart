import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/vehicule.dart';
import 'package:sirmo/screens/licence/licence-create.screen.dart';
import 'package:sirmo/utils/app-util.dart';
import '../../utils/color-const.dart';
import '../../utils/network-info.dart';

class VehiculeInfoScreen extends StatefulWidget {
  const VehiculeInfoScreen({
    Key? key,
    required this.vehicule,
  }) : super(key: key);
  final Vehicule vehicule;

  @override
  State<VehiculeInfoScreen> createState() => _VehiculeInfoScreenState();
}

class _VehiculeInfoScreenState extends State<VehiculeInfoScreen> {
  late Vehicule vehicule;
  late Map<String, dynamic> vMap;

  @override
  void initState() {
    super.initState();
    vehicule = widget.vehicule;
    vMap = vehicule.toDisplayMap();
  }

  @override
  Widget build(BuildContext context) {
    log("${vehicule.licence}");
    return Scaffold(
      appBar: AppDecore.appBar(context, "Véhicule Info"),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Status : "),
                Text(
                  vehicule.licence?.date_fin == null
                      ? 'Pas de Licence'
                      : DateTime.now().isBefore(vehicule.licence!.date_fin!)
                          ? "Activée"
                          : "Expirée",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: vehicule.licence?.date_fin == null ||
                              DateTime.now()
                                  .isAfter(vehicule.licence!.date_fin!)
                          ? ColorConst.error
                          : ColorConst.primary,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          image,
          ...vMap.keys
              .where((element) => vMap[element] is String)
              .map((e) => getTile(e, vMap[e]))
              .toList()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppUtil.goToScreen(context, LicenceCreateScreen());
        },
        label: const Text(
          "Prendre Licence",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  get image => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: AspectRatio(
          aspectRatio: 4 / 2.2,
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16,
                ),
                child: vehicule.image_path == null
                    ? Image.asset("assets/images/onboarding-first.gif")
                    : Image.network(
                        "${NetworkInfo.baseUrl}${vehicule.image_path}")),
          ),
        ),
      );

  getTile(String name, String value) {
    return ListTile(
      shape: Border(
        bottom: BorderSide(
          color: ColorConst.primary.withOpacity(0.2),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: ColorConst.primary),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
