import 'package:flutter/material.dart';
import 'package:sirmo/screens/home/home.screen.dart';
import 'package:sirmo/screens/police/police-home.screen.dart';
import 'package:sirmo/screens/conducteur/conducteur-home.screen.dart';

import '../components/unbuild.screen.dart';
import '../utils/app-routes.dart';
import '../utils/app-util.dart';
import '../utils/color-const.dart';

class AppMenuItem {
  String title;
  String? page;
  Widget? leading;
  Widget? screen;

  Widget? trealing;
  List<AppMenuItem>? childreen;

  static AppMenuItem get devMenu {
    return AppMenuItem(
        title: "Developpeur",
        trealing: Icon(Icons.arrow_drop_down),
        childreen: [
          AppMenuItem(
              title: "Accueil",
              leading: const Icon(
                Icons.policy,
                color: ColorConst.primary,
              ),
              screen: HomeScreen()),
          AppMenuItem(
              title: "Accueil Conducteur",
              leading: const Icon(
                Icons.policy,
                color: ColorConst.primary,
              ),
              screen: ConducteurHomeScreen()),
          AppMenuItem(
              title: "Accueil Police",
              leading: const Icon(
                Icons.policy,
                color: ColorConst.primary,
              ),
              screen: PoliceHomeScreen()),
        ]);
  }

  AppMenuItem({
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
              Navigator.pop(context);
              AppUtil.goToScreen(context, screen!);
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
