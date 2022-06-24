import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/unbuild.screen.dart';

import '../models/user.dart';
import '../screens/home/home.screen.dart';
import '../services/user.service.dart';
import '../utils/app-routes.dart';
import '../utils/app-util.dart';
import '../utils/color-const.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

_buildHeader(BuildContext context) {
  return UserAccountsDrawerHeader(
    accountName: Text("ZEM+"),
    accountEmail: Text(""),
    currentAccountPicture: InkWell(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              "assets/images/femme.jpg",
              fit: BoxFit.contain,
            )),
      ),
    ),
    otherAccountsPictures: [],
    otherAccountsPicturesSize: Size(100, 50),
  );
}

class _AppDrawerState extends State<AppDrawer> {
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
          page: UnbuildScreen.routeName),
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
          childreen: [
            _Menu(
                title: "Notifications",
                leading: const Icon(
                  Icons.notification_important,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Aide",
                leading: const Icon(
                  Icons.help,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Paramertre",
                leading: const Icon(
                  Icons.settings,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Nous Contacter",
                leading: const Icon(
                  Icons.mail,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Partager",
                leading: const Icon(
                  Icons.share,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "UACTransport",
                leading: const Icon(
                  Icons.app_blocking,
                  color: ColorConst.primary,
                ),
                page: null),
            _Menu(
                title: "Login",
                leading: const Icon(
                  Icons.login,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "sign up",
                leading: const Icon(
                  Icons.logout,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Confirm mail",
                leading: const Icon(
                  Icons.email,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Confirm phone",
                leading: const Icon(
                  Icons.phone,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Onboarding",
                leading: const Icon(
                  Icons.phone,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
            _Menu(
                title: "Débugage",
                leading: const Icon(
                  Icons.car_repair,
                  color: ColorConst.primary,
                ),
                page: UnbuildScreen.routeName),
          ]),
    ];
  }
}

class _Menu {
  String title;
  String? page;
  Widget? leading;
  Widget? trealing;
  List<_Menu>? childreen;

  _Menu({
    required this.title,
    this.page,
    this.leading,
    this.trealing,
    this.childreen,
  }) {
    assert(page == null || childreen == null);
  }

  Widget build(context) {
    if (page != null) {
      return ListTile(
          focusColor: ColorConst.primary,
          title: Text(title),
          leading: leading,
          trailing: trealing,
          onTap: () {
            if (page != null && routes[page] != null) {
              Navigator.pop(context);
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
//
// _buildHeader(BuildContext context) {
//   User user = context.read<UserService>().user ?? User();
//   Account account = context.read<UserService>().account ?? Account(amount: 0);
//   return UserAccountsDrawerHeader(
//     accountName: Text(user.fullName),
//     accountEmail: Text("${user.email ?? ''} \n${user.phoneNr ?? ''}"),
//     currentAccountPicture: InkWell(
//       onTap: () {
//         context.read<UserService>().loadUser().onError((error, stackTrace) {
//           log("$error");
//           log("$stackTrace");
//         });
//       },
//       child: CircleAvatar(
//         backgroundColor: Colors.white,
//         child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: Image.asset(
//               "assets/images/femme.jpg",
//               fit: BoxFit.contain,
//             )),
//       ),
//     ),
//     otherAccountsPictures: [
//       Card(
//         color: Colors.white,
//         child: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "${account.amount} BMo",
//           ),
//         ),
//       ),
//     ],
//     otherAccountsPicturesSize: Size(100, 50),
//   );
// }
