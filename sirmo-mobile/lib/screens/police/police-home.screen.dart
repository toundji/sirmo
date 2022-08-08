import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/action-card.dart';
import 'package:sirmo/components/app-bar.screen.dart';
import 'package:sirmo/screens/amande_type/selecte_amande_type.screen.dart';
import 'package:sirmo/screens/amandes/amande.screen.dart';
import 'package:sirmo/screens/conducteur/conducteur.drawer.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../conducteur/choice-driver.screen.dart';
import '../statistique-conducteur/evaluate-conduteur.screen.dart';

class PoliceHomeScreen extends StatefulWidget {
  PoliceHomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<PoliceHomeScreen> createState() => _PoliceHomeScreenState();
}

class _PoliceHomeScreenState extends State<PoliceHomeScreen> {
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

  login() {
    context
        .read<UserService>()
        .login("+22994851785", "Baba@1234")
        .then((value) {
      setState(() {
        header = NetworkInfo.headers;
      });
      context
          .read<CompteService>()
          .loadCompte()
          .then((value) {})
          .onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "êrror");
      });
      setState(() {});
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error").then((value) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(context),
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  name: "Amander",
                  icon: Icons.edit,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          SelecteAmandeTypeScreen(
                            conducteur: conducteur,
                          ));
                    },
                  ),
                ),
                ActionCard(
                  name: "Amandes",
                  icon: Icons.remove_red_eye,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          AmandeScreen(
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
            children: const [
              ActionCard(name: "Status", icon: Icons.info),
              ActionCard(name: "Apprecier", icon: CupertinoIcons.star),
            ],
          ),
          // portefeuile,
        ],
      ),
      drawer: ConducteurDrawer(),
    );
  }
}
