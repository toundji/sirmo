import 'package:flutter/material.dart';
import 'package:sirmo/components/drawer_screen.dart';

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: AppDrawer()),
                Expanded(
                  flex: 4,
                  child: Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
