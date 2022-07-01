import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-bar.screen.dart';
import 'package:sirmo/components/drawer_screen.dart';
import 'package:sirmo/components/top_curve_path.dart';
import 'package:sirmo/components/user-drawer.dart';
import 'package:sirmo/screens/potefeuille/compte.history.screen.dart';
import 'package:sirmo/screens/potefeuille/credite-porte.screen.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/screens/profile/profile.screen.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/services/zem.sevice.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/action-card.dart';
import '../../components/curve_path_clipper.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';

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

    loadMyZemList();

    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "êrror");
    });
  }

  loadMyZemList() {
    context
        .read<ZemService>()
        .loadMyZemList(user!.id!)
        .then((value) {
          
        })
        .onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(context),
      drawer: UserDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16),
          InkWell(
              onTap: () {
                log("${NetworkInfo.headers}");
              },
              child: Text("Cliquer pour débuger")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ActionCard(name: "Payer Zem", icon: Icons.payment),
                ActionCard(name: "Evaluer Zem", icon: Icons.edit),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionCard(name: "Statistique du Zem", icon: CupertinoIcons.eye),
            ],
          ),
          PortefeuilleComponent(),
        ],
      ),
    );
  }
}
