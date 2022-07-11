import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/statistique-conducteur/evaluate-conduteur.screen.dart';
import 'package:sirmo/screens/statistique-conducteur/statistique-conducteur.screen.dart';
import 'package:sirmo/screens/vehicule/create-vehicule.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/screens/conducteur/conducteur.drawer.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/utils/app-util.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/action-card.dart';
import '../../components/app-bar.screen.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../services/user.service.dart';
import 'choice-driver.screen.dart';

class ConducteurHomeScreen extends StatefulWidget {
  ConducteurHomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<ConducteurHomeScreen> createState() => _ConducteurHomeScreenState();
}

class _ConducteurHomeScreenState extends State<ConducteurHomeScreen> {
  dynamic header;
  Compte? compte;
  @override
  void initState() {
    super.initState();

    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "êrror");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  name: "vehicule",
                  icon: Icons.motorcycle,
                  screen: vehiculeCreateScreen(),
                ),
                const ActionCard(name: "Licence", icon: Icons.edit),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionCard(
                name: "Status",
                icon: Icons.info,
                screen: StatistiqueConducteurScreen(),
              ),
              ActionCard(
                name: "Satistique",
                icon: CupertinoIcons.star,
                screen: StatistiqueConducteurScreen(),
              ),
            ],
          ),
          PortefeuilleComponent(),
        ],
      ),
      drawer: ConducteurDrawer(),
    );
  }
}