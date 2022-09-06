import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/models/auth_storage.dart';
import 'package:sirmo/screens/conducteur/conducteur-home.screen.dart';
import 'package:sirmo/utils/app-util.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../models/enums/user_role.dart';
import '../../models/user.dart';
import '../../services/conducteur.sevice.dart';
import '../../services/police.service.dart';
import '../../services/user.service.dart';
import '../home/home.screen.dart';
import '../police/police-home.screen.dart';
import '../welcome/onboarding-first.dart';
import 'login.screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getScreen(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Image.asset("assets/logos/logo.png"),
        ),
      ),
    );
  }

  Future getScreen(BuildContext context) async {
    String? storage = await FlutterSecureStorage().read(key: "authStorage");
    log("storage :$storage");
    if (storage == null) {
      return OnboardingFirst();
    }
    AuthStorage auth = AuthStorage.fromJson(storage);
    if (auth.token == null || auth.token!.isEmpty) {
      AppUtil.changeToScreen(context, LoginScreen());
    } else if (Jwt.isExpired(auth.token!)) {
      AppUtil.changeToScreen(context, LoginScreen());
    }
    NetworkInfo.token = auth.token;
    List<String>? roles = auth.roles;

    if (UserRole.isConducteur(User(roles: roles))) {
      await context.read<ConducteurService>().myInfo().then((value) {
        log("Token is $value");
        context.read<UserService>().setUser(value.user!);
        AppUtil.changeToScreen(context, ConducteurHomeScreen());
      }).onError((error, stackTrace) {
        log("$error");
        AppUtil.changeToScreen(context, LoginScreen());
      });
    }
    if (UserRole.isPolice(User(roles: roles))) {
      await context.read<PoliceService>().myInfo().then((value) {
        context.read<UserService>().setUser(value.user!);
        AppUtil.changeToScreen(context, PoliceHomeScreen());
      }).onError((error, stackTrace) {
        log("$error");
        AppUtil.changeToScreen(context, LoginScreen());
      });
    }
    log("It is a single user");
    await context.read<UserService>().profile().then((value) {
      AppUtil.changeToScreen(context, HomeScreen());
    }).onError((error, stackTrace) {
      log("$error", stackTrace: stackTrace);
      AppUtil.changeToScreen(context, LoginScreen());
    });
  }
}
