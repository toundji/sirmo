import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/drawer_screen.dart';
import 'package:sirmo/components/top_curve_path.dart';
import 'package:sirmo/components/user-drawer.dart';
import 'package:sirmo/screens/potefeuille/compte.history.screen.dart';
import 'package:sirmo/screens/potefeuille/credite-porte.screen.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/screens/profile/profile.screen.dart';
import 'package:sirmo/screens/zem/zem.drawer.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/action-card.dart';
import '../../components/app-bar.screen.dart';
import '../../components/curve_path_clipper.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';

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
    if (widget.debug) {
      login();
    }
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
      appBar: AppAppBar(context, header),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(name: "Moto", icon: Icons.motorcycle),
                ActionCard(name: "Licence", icon: Icons.edit),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
