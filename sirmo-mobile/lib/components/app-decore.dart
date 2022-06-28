import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/app-util.dart';
import '../utils/color-const.dart';
import '../utils/size-const.dart';
import 'curve_path_clipper.dart';

class AppDecore {
  static Widget getTitle(
    String titlte, {
    double scal = 1.4,
    Color color = ColorConst.primary,
    TextAlign align = TextAlign.center,
  }) {
    return Text(
      titlte,
      textScaleFactor: scal,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget buildSearch({
    void Function(String)? onChanged,
    String hintText = "Ecriver pour rechercher ...",
  }) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 16, right: 10),
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: Colors.black12,
            )
          ]),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
          suffixIcon: Icon(Icons.search),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  static Widget submitButton(
      BuildContext context, String label, VoidCallback onPressed,
      {VoidCallback? onLongPress,
      Color? color,
      Color? textColor,
      double scal = 1.2,
      double vp = 16}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vp),
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          primary: color ?? ColorConst.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            textAlign: TextAlign.left,
            textScaleFactor: scal,
            style: TextStyle(
              color: textColor ?? ColorConst.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  static nameValidator(String name, String? value,
      {int min = 3, int max = 50}) {
    if (value == null || value.isEmpty)
      return "Le $name est obligartoire";
    else if (value.length < min)
      return "Vous devez entrez 3 cararères au minimum";
    else if (value.length > max)
      return "Vous devez entrez 50 cararères au maximum";
    return null;
  }

  static requiredValidator(String name, String? value) {
    if (value == null || (value is String && value.isEmpty))
      return "$name est obligartoire";
  }

  static AppBar registerAppBar(BuildContext context, String level) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                "assets/logos/logo.jpeg",
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
            AppDecore.getTitle(level.toUpperCase())
          ],
        ),
      ),
    );
  }

  static Widget getPrimaryTitle(
    String titlte, {
    double scal = 1.2,
    TextAlign align = TextAlign.center,
  }) {
    return Text(
      titlte,
      textScaleFactor: scal,
      textAlign: align,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static InputDecoration input(String label,
      {String? helper, IconData? prefix, IconData? suffix}) {
    return InputDecoration(
      helperText: helper,
      suffix: suffix == null ? null : Icon(suffix),
      prefix: prefix == null ? null : Icon(prefix),
      label: Text(label,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16.0)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static PreferredSize appBar(
    BuildContext context,
    String title, {
    double scal = 1,
    double? height,
    bool leading = false,
    List<Widget>? actions,
  }) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 120),
      child: ClipPath(
        clipper: CurvePathClipper(),
        child: AppBar(
          iconTheme:
              Theme.of(context).iconTheme.copyWith(color: ColorConst.white),
          title: Text(
            title,
            textScaleFactor: 1.2,
            style: TextStyle(color: ColorConst.white),
          ),
          centerTitle: true,
          actions: actions ?? [],
        ),
      ),
    );
  }

  static Widget buildSearch2({
    void Function(String)? onChanged,
    String hintText = "Ecriver pour rechercher ...",
  }) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 16, right: 10),
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: Colors.black12,
            )
          ]),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
          suffixIcon: Icon(Icons.search),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  static Widget button(
    BuildContext context,
    String label,
    VoidCallback onPressed, {
    VoidCallback? onLongPress,
    Color? color,
    Color? textColor,
    double scal = 1.2,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConst.padding),
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            textAlign: TextAlign.left,
            textScaleFactor: scal,
            style: TextStyle(
              color: textColor ?? ColorConst.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
