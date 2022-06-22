import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirmo/components/drawer_screen.dart';
import 'package:sirmo/components/top_curve_path.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/curve_path_clipper.dart';
import '../../models/user.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preferredSize2,
      body: ClipPath(
        clipper: TopCurvePathClipper(),
        child: Card(
          elevation: 10.0,
          child: Container(
            color: ColorConst.primary.shade400,
            child: Stack(children: [
              Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [],
                  ))
            ]),
            height: 200,
          ),
        ),
      ),
      drawer: Container(),
    );
  }

  PreferredSize get preferredSize2 => PreferredSize(
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
                  onPressed: () => AppUtil.goToScreen(context, Scaffold()),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(NetworkInfo.imageProfile,
                            headers: NetworkInfo.headers),
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
}
