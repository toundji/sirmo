import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/appreciation.dart';
import 'package:sirmo/services/appreciation.service.dart';

import '../../models/conducteur.dart';
import '../../models/user.dart';

class AppreciationScreen extends StatefulWidget {
  AppreciationScreen({Key? key, required this.conducteur}) : super(key: key);
  final Conducteur conducteur;
  @override
  State<AppreciationScreen> createState() => _AppreciationScreenState();
}

class _AppreciationScreenState extends State<AppreciationScreen> {
  late Conducteur conducteur;
  User? user;

  @override
  void initState() {
    super.initState();
    conducteur = widget.conducteur;
    user = conducteur.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Appréciation"),
      body: FutureBuilder<List<Appreciation>?>(
        future: context.read<AppreciationService>().loadAll(conducteur),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Container(
            
          );
        },
      ),
    );
  }
}
