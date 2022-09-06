import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/profile/profile.screen.dart';

import '../../models/app-menu-item.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/color-const.dart';

class PoliceDrawer extends StatefulWidget {
  PoliceDrawer({Key? key}) : super(key: key);

  @override
  _PoliceDrawerState createState() => _PoliceDrawerState();
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

class _PoliceDrawerState extends State<PoliceDrawer> {
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
      AppMenuItem(
        title: "Profile",
        leading: const Icon(
          Icons.badge,
          color: ColorConst.primary,
        ),
        screen: ProfileScreen(),
      ),
    ];
  }
}
