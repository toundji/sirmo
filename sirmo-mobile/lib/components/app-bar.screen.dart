import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../screens/profile/profile.screen.dart';
import '../services/user.service.dart';
import '../utils/app-util.dart';
import '../utils/color-const.dart';
import '../utils/network-info.dart';
import 'curve_path_clipper.dart';

PreferredSize AppAppBar(BuildContext context) {
  User? user = context.read<UserService>().user;
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 150),
    child: ClipPath(
      clipper: CurvePathClipper(),
      child: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: ColorConst.white),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14, top: 5, bottom: 5),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.6))),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
              onPressed: () => AppUtil.goToScreen(context, ProfileScreen()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    foregroundImage: user?.profile_image == null
                        ? null
                        : NetworkImage(
                            "${NetworkInfo.baseUrl}${user?.profile_image}",
                            headers: NetworkInfo.headers,
                          ),
                    backgroundImage:
                        const AssetImage("assets/images/profile.jpg"),
                  ),
                  const Icon(Icons.arrow_drop_down_outlined,
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
