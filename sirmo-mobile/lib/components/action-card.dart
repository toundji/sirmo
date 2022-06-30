import 'package:flutter/material.dart';

import '../utils/app-util.dart';
import '../utils/color-const.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.name,
    required this.icon,
    this.onPressed,
    this.screen,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final VoidCallback? onPressed;
  final Widget? screen;

  @override
  Widget build(BuildContext context) {
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
