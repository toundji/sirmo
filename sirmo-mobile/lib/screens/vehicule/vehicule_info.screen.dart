import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/vehicule.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../utils/color-const.dart';

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

  @override
  void initState() {
    super.initState();
    vehicule = widget.vehicule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Véhicule Info"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AspectRatio(
              aspectRatio: 4 / 3,
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
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Status : "),
              Text(
                "${vehicule.licence?.status ?? ''}",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: vehicule.licence?.status != null
                        ? ColorConst.primary
                        : ColorConst.error,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ListTile(
            title: Text("Date d'activation"),
            subtitle: Text("${vehicule.licence?.created_at}"),
            leading: Icon(CupertinoIcons.time_solid),
          ),
          ListTile(
            title: Text("Date d'exiration"),
            subtitle: Text("${vehicule.licence?.date_fin}"),
            leading: Icon(CupertinoIcons.time_solid),
          )
        ],
      ),
    );
  }
}
