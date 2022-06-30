import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/zem/become-zem.screen.dart';
import 'package:sirmo/screens/zem/zem-home.screen.dart';

import '../../models/app-menu-item.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/app-routes.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../home/home.screen.dart';

class ZemDrawer extends StatefulWidget {
  ZemDrawer({Key? key}) : super(key: key);

  @override
  _ZemDrawerState createState() => _ZemDrawerState();
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

class _ZemDrawerState extends State<ZemDrawer> {
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
      if (user != null && !user.hasRole("zem"))
        AppMenuItem(
          title: "Devinir Zem",
          leading: const Icon(
            Icons.motorcycle,
            color: ColorConst.primary,
          ),
          screen: ZemBecomeScreen(),
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
          title: "Moto",
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
