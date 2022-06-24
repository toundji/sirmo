import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/drawer_screen.dart';
import 'package:sirmo/components/top_curve_path.dart';
import 'package:sirmo/screens/potefeuille/credite-porte.screen.dart';
import 'package:sirmo/screens/profile/profile.screen.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/curve_path_clipper.dart';
import '../../components/personal_alert.dart';
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
  dynamic header;
  @override
  void initState() {
    super.initState();
    if (widget.debug) {
      login();
    }
  }

  login() {
    context
        .read<UserService>()
        .login("+22994851785", "Baba@1234")
        .then((value) {
      header = NetworkInfo.headers;
      setState(() {});
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error").then((value) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preferredSize,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                actionCard("Payer Zem", Icons.payment),
                actionCard("Evaluer Zem", Icons.edit),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              actionCard("Statistique du Zem", CupertinoIcons.eye),
            ],
          ),
          portefeuile,
        ],
      ),
      drawer: AppDrawer(),
    );
  }

  Widget get portefeuile {
    return ClipPath(
      clipper: TopCurvePathClipper(),
      child: Card(
        elevation: 10.0,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(children: [
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Solde: ",
                      style: TextStyle(
                          color: ColorConst.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "0 F ",
                      style: TextStyle(
                          color: ColorConst.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 32, right: 32),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          AppUtil.goToScreen(
                              context, CreditPortefeuilleScreen());
                        },
                        icon: const Icon(
                          Icons.add,
                          color: ColorConst.white,
                        ),
                        label: const Text(
                          "Recharger",
                          style: TextStyle(
                              color: ColorConst.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.history,
                          color: ColorConst.white,
                        ),
                        label: const Text(
                          "Historique",
                          style: TextStyle(
                              color: ColorConst.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            )
          ]),
          height: 200,
        ),
      ),
    );
  }

  PreferredSize get preferredSize => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 150),
        child: ClipPath(
          clipper: CurvePathClipper(),
          child: AppBar(
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: ColorConst.white),
            centerTitle: true,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 14, top: 5, bottom: 5),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.6))),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 1),
                  onPressed: () => AppUtil.goToScreen(context, ProfileScreen()),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        foregroundImage: header == null
                            ? null
                            : NetworkImage(NetworkInfo.imageProfile,
                                headers: header),
                        backgroundImage: AssetImage("assets/logos/logo.png"),
                      ),
                      Icon(Icons.arrow_drop_down_outlined,
                          color: ColorConst.white)
                    ],
                  ),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size(50, 100),
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Text(
                  AppUtil.appName,
                  textScaleFactor: 1.2,
                  style: const TextStyle(
                      color: ColorConst.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      );

  Widget actionCard(String name, IconData icon,
      {VoidCallback? onPressed, Widget? screen}) {
    Size size = MediaQuery.of(context).size;

    return Card(
      child: MaterialButton(
        onPressed: onPressed ??
            () => AppUtil.goToScreen(context, screen ?? Scaffold()),
        child: Container(
          width: size.width * 0.33,
          height: size.width * 0.4,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              Icon(
                icon,
                size: 32,
                color: ColorConst.primary,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConst.text,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
