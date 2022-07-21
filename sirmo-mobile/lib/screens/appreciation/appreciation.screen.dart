import 'package:flutter/material.dart';
import 'package:sirmo/components/app-decore.dart';

class AppreciationScreen extends StatefulWidget {
  AppreciationScreen({Key? key}) : super(key: key);

  @override
  State<AppreciationScreen> createState() => _AppreciationScreenState();
}

class _AppreciationScreenState extends State<AppreciationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Appréciation"),
      body: Container(),
    );
  }
}
