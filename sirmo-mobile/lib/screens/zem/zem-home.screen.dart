import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/moto/create-moto.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/screens/zem/zem.drawer.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/action-card.dart';
import '../../components/app-bar.screen.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../services/user.service.dart';

class ZemHomeScreen extends StatefulWidget {
  ZemHomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<ZemHomeScreen> createState() => _ZemHomeScreenState();
}

class _ZemHomeScreenState extends State<ZemHomeScreen> {
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
                  name: "Moto",
                  icon: Icons.motorcycle,
                  screen: MotoCreateScreen(),
                ),
                const ActionCard(name: "Licence", icon: Icons.edit),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ActionCard(name: "Status", icon: Icons.info),
              ActionCard(name: "Evaluation", icon: CupertinoIcons.star),
            ],
          ),
          PortefeuilleComponent(),
        ],
      ),
      drawer: ZemDrawer(),
    );
  }
}
