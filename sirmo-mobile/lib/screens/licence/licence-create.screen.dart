import 'package:flutter/material.dart';
import 'package:sirmo/components/app-decore.dart';

class LicenceCreateScreen extends StatefulWidget {
  LicenceCreateScreen({Key? key}) : super(key: key);

  @override
  State<LicenceCreateScreen> createState() => _LicenceCreateScreenState();
}

class _LicenceCreateScreenState extends State<LicenceCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Achat de licenece"),
      body: Center(
        child: AppDecore.submitButton(
            context, "Cliquer pour payer votre licence", () {}),
      ),
    );
  }
}
