import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/personal_alert.dart';

import 'package:sirmo/models/conducteur.dart';
import 'package:sirmo/services/compte.service.dart';

import '../../components/app-decore.dart';
import '../../models/user.dart';
import '../../utils/color-const.dart';
import '../../utils/network-info.dart';

class PayConducteurScreen extends StatefulWidget {
  const PayConducteurScreen({
    Key? key,
    required this.conducteur,
  }) : super(key: key);
  final Conducteur conducteur;

  @override
  State<PayConducteurScreen> createState() => _PayConducteurScreenState();
}

class _PayConducteurScreenState extends State<PayConducteurScreen> {
  late Conducteur conducteur;
  User? user;
  int? amount;
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();

  String? errorMessage, successMessage;

  @override
  void initState() {
    super.initState();
    conducteur = widget.conducteur;
    user = conducteur.user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppDecore.appBar(context, "Payer Le Conducteur"),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            profile,
            const Text(
              "Veuillez renseilller le montant à recharger ",
              style: TextStyle(
                  color: ColorConst.text, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: TextFormField(
                initialValue: "$amount",
                key: fieldKey,
                onChanged: (value) {
                  amount = int.tryParse(value);
                  setState(() {});
                },
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: AppDecore.input("Montant", prefix: Icons.money),
              ),
            ),
            AppDecore.submitButton(context, "Valider", onSubmit)
          ],
        ),
      ),
    );
  }

  onSubmit() async {
    if (fieldKey.currentState == null || fieldKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      successMessage = null;
      await context
          .read<CompteService>()
          .payDriver(conducteur, amount!)
          .then((value) {
        PersonalAlert.showSuccess(context,
            message: "Conducteur payé avec succès");
        setState(() {
          successMessage = "Conducteur payé avec succès\n Montant : $amount";
        });
      }).onError((error, stackTrace) {
        setState(() {
          errorMessage = "$error";
        });
        PersonalAlert.showError(context, message: "$error");
      });
    }
  }

  Widget get profile {
    Size size = MediaQuery.of(context).size;

    return Center(
      widthFactor: 0.8,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Container(
          width: size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  padding: EdgeInsets.all(2),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    foregroundImage: user?.profile_image == null
                        ? null
                        : NetworkImage(
                            "${NetworkInfo.baseUrl}${user?.profile_image}",
                            headers: {
                              "Authorization": "Bearer ${NetworkInfo.token}",
                            },
                          ),
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "${user?.nom ?? ''} ${user?.prenom ?? ''}",
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Status : "),
                  Text(
                    "${conducteur.statut}",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: conducteur.isActif
                            ? ColorConst.primary
                            : ColorConst.error,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
