import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/conducteur/become-conducteur.screen.dart';
import 'package:sirmo/screens/conducteur/conducteur-home.screen.dart';

import '../../models/app-menu-item.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/app-routes.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../home/home.screen.dart';

class ConducteurDrawer extends StatefulWidget {
  ConducteurDrawer({Key? key}) : super(key: key);

  @override
  _ConducteurDrawerState createState() => _ConducteurDrawerState();
}

_buildHeader(BuildContext context) {
  return UserAccountsDrawerHeader(
    accountName: Text("ZEM+"),
    accountEmail: Text(""),
    currentAccountPicture: InkWell(
      onTap: () {},
      child: CircleAvatar(
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

class _ConducteurDrawerState extends State<ConducteurDrawer> {
  List<AppMenuItem>? menus;

  User? user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserService>().user;

    adminMenu(user);
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

  adminMenu(User? user) {
    menus = [
      if (user != null && !user.hasRole("conducteur"))
        AppMenuItem(
          title: "Devinir Conducteur",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: ConducteurBecomeScreen(),
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
          title: "Amande",
          leading: const Icon(
            Icons.low_priority,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem(
          title: "vehicule",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem(
          title: "Appréciation",
          leading: const Icon(
            CupertinoIcons.hand_thumbsup,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      AppMenuItem.devMenu,
    ];
  }
}
