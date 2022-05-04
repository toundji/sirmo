import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirmo/utils/size-const.dart';

import '../utils/color-const.dart';

class AppDecore {
  static Text getTitle(String title, {Color? color, double scal = 1.4}) {
    return Text(
      title,
      style: TextStyle(
        color: color ?? ColorConst.primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget button(
      BuildContext context, String label, VoidCallback onPressed,
      {VoidCallback? onLongPress, double paddingCoef = 1}) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConst.padding * paddingCoef,
            vertical: SizeConst.padding / 2),
        decoration: BoxDecoration(
          color: ColorConst.primary,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(
                0,
                2,
              ),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }

  static appBar(BuildContext context, String title,
      {Widget? child, double? heigth}) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, heigth ?? 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              textScaleFactor: 1.5,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  static InputDecoration input({
    Widget? leading,
    label,
    errorText,
    double pv = 16.0,
    double ph = 0.0,
    Widget? trailing,
    int errorMaxLines = 1,
    String? helperText,
    String? hintText,
    double fontSize = 16.0,
  }) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(
            top: pv, bottom: pv, left: leading == null ? ph : 0, right: ph),
        prefixIcon: leading,
        prefixStyle: TextStyle(color: Colors.black38),
        suffix: trailing,
        suffixStyle: const TextStyle(color: Colors.black38),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        focusedBorder: OutlineInputBorder(
            //must be sombre
            borderSide: BorderSide(color: ColorConst.primary),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConst.error),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConst.error),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontSize: 18,
        ),
        errorText: errorText,
        errorMaxLines: errorMaxLines,
        helperText: helperText,
        hintText: hintText);
  }
}
