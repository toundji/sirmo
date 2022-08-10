import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-bar.screen.dart';
import 'package:sirmo/components/user-drawer.dart';
import 'package:sirmo/screens/potefeuille/pay_conducteur.screen.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/screens/statistique-conducteur/evaluate-conduteur.screen.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import 'package:sirmo/utils/app-util.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/action-card.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../conducteur/choice-driver.screen.dart';
import '../statistique-conducteur/statistique-conducteur.screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Compte? compte;
  User? user;
  @override
  void initState() {
    super.initState();
    user = context.read<UserService>().user;

    loadMyConducteurList();

    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "êrror");
    });
  }

  loadMyConducteurList() {
    context
        .read<ConducteurService>()
        .loadMyConducteurList(user!.id!)
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(context,
          leading: const Text(
            "User",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          auto: false),
      // drawer: UserDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 16),
          InkWell(
              onTap: () {
                log("${NetworkInfo.headers}");
              },
              child: const Text("Cliquer pour débuger")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  name: "Payer Conducteur",
                  icon: Icons.payment,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          PayConducteurScreen(
                            conducteur: conducteur,
                          ));
                    },
                  ),
                ),
                ActionCard(
                  name: "Evaluer Conducteur",
                  icon: Icons.edit,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          EvaluateConducteurScreen(
                            conducteur: conducteur,
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionCard(
                name: "Statistique du Conducteur",
                icon: CupertinoIcons.eye,
                screen: ChoiceDriverScreen(
                  onSubmit: (conducteur) {
                    AppUtil.changeToScreen(
                        context,
                        StatistiqueConducteurScreen(
                          conducteur: conducteur,
                        ));
                  },
                ),
              ),
            ],
          ),
          PortefeuilleComponent(),
        ],
      ),
    );
  }
}
