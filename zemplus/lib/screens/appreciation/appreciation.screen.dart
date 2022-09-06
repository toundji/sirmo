import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/appreciation.dart';
import 'package:sirmo/services/appreciation.service.dart';

import '../../models/conducteur.dart';
import '../../models/user.dart';

class AppreciationScreen extends StatefulWidget {
  const AppreciationScreen({Key? key, required this.conducteur})
      : super(key: key);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Appreciation>>(
          future: context.read<AppreciationService>().loadAll(conducteur),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Center(child: Text("${snapshot.error}"));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return apreciateTile(snapshot.data![index]);
                    });
              } else {
                return const Center(
                    child: Text("Auccune appréciation trouvée"));
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget apreciateTile(Appreciation appreciation) {
    return Card(
      child: ListTile(
        title: Text(appreciation.typeAppreciation ?? ""),
        subtitle: appreciation.message == null || appreciation.message!.isEmpty
            ? null
            : Text(
                appreciation.typeAppreciation!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
        leading: Icon(
          Appreciation.STATUS_ICONS[appreciation.typeAppreciation],
          color: Appreciation.STATUS_Colors[appreciation.typeAppreciation],
        ),
      ),
    );
  }
}
