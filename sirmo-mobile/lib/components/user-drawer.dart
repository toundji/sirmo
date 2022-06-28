import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/zem/become-zem.screen.dart';

import '../models/user.dart';
import '../screens/home/home.screen.dart';
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

class _UserDrawerState extends State<UserDrawer> {
  List<_Menu>? menus;

  @override
  void initState() {
    super.initState();
    adminMenu();
  }

  @override
  Widget build(BuildContext context) {
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

  adminMenu() {
    menus = [
      _Menu(title: "ACCUEIL", page: HomeScreen.routeName),
      _Menu(
        title: "Zem",
        leading: const Icon(
          Icons.motorcycle,
          color: ColorConst.primary,
        ),
        screen: ZemBecomeScreen(),
      ),
      _Menu(
          title: "Mairie",
          leading: const Icon(
            Icons.policy,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      _Menu(
          title: "Licences",
          leading: const Icon(
            Icons.badge,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      _Menu(
          title: "Police",
          leading: const Icon(
            Icons.policy,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      _Menu(
          title: "Amande",
          leading: const Icon(
            Icons.low_priority,
            color: ColorConst.primary,
          ),
          page: UnbuildScreen.routeName),
      _Menu(
        title: "AUTRES",
        leading: const Icon(Icons.directions_boat_filled_outlined),
        childreen: [],
      )
    ];
  }
}

class _Menu {
  String title;
  String? page;
  Widget? leading;
  Widget? screen;

  Widget? trealing;
  List<_Menu>? childreen;

  _Menu({
    required this.title,
    this.page,
    this.screen,
    this.leading,
    this.trealing,
    this.childreen,
  }) {
    assert(page == null || childreen == null);
  }

  Widget build(context) {
    if (page != null || screen != null) {
      return ListTile(
          focusColor: ColorConst.primary,
          title: Text(title),
          leading: leading,
          trailing: trealing,
          onTap: () {
            if (page != null && routes[page] != null) {
              Navigator.pop(context);
              Navigator.pushNamed(context, page!);
            } else if (screen != null) {
              AppUtil.goToScreen(context, screen!);
              Navigator.pushNamed(context, page!);
            }
          });
    } else {
      return ExpansionTile(
        title: Text(title),
        leading: leading,
        trailing: trealing,
        children: childreen == null
            ? []
            : childreen!.map((e) => e.build(context)).toList(),
      );
    }
  }
}
