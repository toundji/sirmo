import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/components/personal_alert.dart';
import 'package:sirmo/models/payement.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/utils/app-date.dart';
import 'package:sirmo/utils/color-const.dart';

class CompteHistoryScreen extends StatefulWidget {
  CompteHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CompteHistoryScreen> createState() => _CompteHistoryScreenState();
}

class _CompteHistoryScreenState extends State<CompteHistoryScreen> {
  List<Payement>? histories;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    context
        .read<CompteService>()
        .loadHistory()
        .then((value) {})
        .onError((error, stackTrace) {
      errorMessage == "$error";
      PersonalAlert.showError(context, message: "$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    histories = context.watch<CompteService>().histories;
    return Scaffold(
      appBar: AppDecore.appBar(context, "Historiques du compte"),
      body: histories == null
          ? Center(
              child: errorMessage == null
                  ? CircularProgressIndicator()
                  : Text("$errorMessage"))
          : histories!.isEmpty
              ? Center(
                  child: Text("$errorMessage"),
                )
              : ListView.builder(
                  itemCount: histories!.length,
                  itemBuilder: (context, index) {
                    return tile(histories![index]);
                  },
                ),
    );
  }

  tile(Payement payement) {
    return Card(
      child: Container(
          child: Column(
        children: [
          ListTile(
            leading: Icon(
              payement.type == "CREDIT"
                  ? CupertinoIcons.arrow_down
                  : CupertinoIcons.arrow_up,
              color: ColorConst.primary,
            ),
            title: Text(payement.operation!),
            subtitle: Text(payement.created_at == null
                ? ""
                : AppDate.dayDateTimeFormatString.format(payement.created_at!)),
            trailing: Text("${payement.montant} F"),
          ),
        ],
      )),
    );
  }
}
