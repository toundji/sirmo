import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirmo/utils/color-const.dart';

class PersonalAlert {
  static BuildContext? context;
  static Future showLoading(BuildContext context,
      {message = "Connexion en cours ... "}) async {
    PersonalAlert.context = context;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
          );
        }).then((value) {
      PersonalAlert.context = null;
    });
  }

  static Future showSuccess(
    BuildContext context, {
    String title = "Succès",
    message = "Opération effectuée avec succès",
    int? duration = 2,
  }) async {
    PersonalAlert.hideLoading();
    PersonalAlert.context = context;
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Icon(
              Icons.check_circle_outline,
              color: ColorConst.primary,
              size: 54,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorConst.primary, fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(message),
              ],
            ),
          );
        }).then((value) {
      if (duration != null) {
        timer?.cancel();
        timer = null;
      }
    });
  }

  static Future showError(
    BuildContext context, {
    String title = "Erreur",
    message = "Erreur d'escution de votre requète",
    int? duration = 5,
  }) async {
    PersonalAlert.hideLoading();
    PersonalAlert.context = context;

    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Icon(
              CupertinoIcons.clear_circled,
              color: ColorConst.error,
              size: 54,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorConst.error, fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(message)
              ],
            ),
          );
        }).then((value) {
      if (duration != null) {
        timer?.cancel();
        timer = null;
      }
    });
  }

  static hideLoading() {
    if (PersonalAlert.context != null) {
      Navigator.pop(PersonalAlert.context!);
      PersonalAlert.context = null;
    }
  }
}
