import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/vehicule/create-vehicule.dart';
import 'package:sirmo/screens/conducteur/become-conducteur.screen.dart';
import 'package:sirmo/services/conducteur.sevice.dart';

import '../models/app-menu-item.dart';
import '../models/user.dart';
import '../models/conducteur.dart';
import '../screens/home/home.screen.dart';
import '../screens/conducteur/conducteur-home.screen.dart';
import '../services/user.service.dart';
import '../utils/app-routes.dart';
import '../utils/app-util.dart';
import '../utils/color-const.dart';

class UserDrawer extends StatefulWidget {
  UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

_buildHeader(BuildContext context) {
  return UserAccountsDrawerHeader(
    accountName: Text("ZEM+"),
    accountEmail: Text(""),
    currentAccountPicture: InkWell(
      onTap: () {},
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        foregroundImage: AssetImage(
          "assets/logos/logo.png",
        ),
      ),
    ),
    otherAccountsPictures: [],
    otherAccountsPicturesSize: Size(100, 50),
  );
}

class _UserDrawerState extends State<UserDrawer> {
  List<AppMenuItem>? menus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adminMenu(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
          child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              children: menus!.map((e) => e.build(context)).toList(),
            ),
          )
        ],
      )),
    );
  }

  adminMenu(BuildContext context) {
    User? user = context.watch<UserService>().user;
    Conducteur? conducteur = context.watch<ConducteurService>().conducteur;
    menus = [
      AppMenuItem(title: "ACCUEIL", page: HomeScreen.routeName),
      if (user != null && user.hasRole("conducteur"))
        AppMenuItem(
          title: "Conducteur",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: ConducteurHomeScreen(),
        ),
      if (conducteur == null)
        AppMenuItem(
          title: "Devenir Conducteur",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: ConducteurBecomeScreen(),
        ),
      if (conducteur != null && conducteur.statut == Conducteur.DEMANDE)
        AppMenuItem(
          title: "Créer un vehicule",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: vehiculeCreateScreen(),
        ),
      AppMenuItem(
          title: "Mairie",
          leading: const Icon(
            Icons.policy,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem(
          title: "Licences",
          leading: const Icon(
            Icons.badge,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem(
          title: "Police",
          leading: const Icon(
            Icons.policy,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem(
          title: "Amande",
          leading: const Icon(
            Icons.low_priority,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem.devMenu,
    ];
  }
}
