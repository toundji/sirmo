import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtil {
  static String appName = "Zem🏍";
  static String kikiapayKey = "08dc6a00e3e911eb96cbffe4cc632e8e";

  static void goToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  static void changeToScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  static void popAllAndGoHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (c) => Scaffold()), (route) => false);
  }
}
