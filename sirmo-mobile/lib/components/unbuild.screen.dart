import 'package:flutter/material.dart';

class UnbuildScreen extends StatelessWidget {
  const UnbuildScreen({Key? key}) : super(key: key);
  static const String routeName = "not-build";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Unbuild screen"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
