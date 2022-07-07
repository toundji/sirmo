import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/conducteur/become-conducteur.screen.dart';
import 'package:sirmo/screens/conducteur/conducteur-home.screen.dart';

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
        foregroundImage: AssetImage(
          "assets/logos/logo.png",
        ),
      ),
    ),
    otherAccountsPictures: [],
    otherAccountsPicturesSize: Size(100, 50),
  );
}

class _AppDrawerState extends State<AppDrawer> {
  List<_Menu>? menus;

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
      _Menu(title: "ACCUEIL", page: HomeScreen.routeName),
      if (user != null && user.hasRole("conducteur"))
        _Menu(
          title: "Conducteur",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: ConducteurHomeScreen(),
        ),
      if (user != null && !user.hasRole("conducteur"))
        _Menu(
          title: "Devinir Conducteur",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: ConducteurBecomeScreen(),
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
