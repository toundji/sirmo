import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/compte.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/services/user.service.dart';
import 'package:sirmo/utils/color-const.dart';

import '../../components/personal_alert.dart';
import '../../models/user.dart';
import '../../utils/app-util.dart';

class CreditPortefeuilleScreen extends StatefulWidget {
  CreditPortefeuilleScreen({Key? key}) : super(key: key);

  @override
  State<CreditPortefeuilleScreen> createState() =>
      _CreditPortefeuilleScreenState();
}

class _CreditPortefeuilleScreenState extends State<CreditPortefeuilleScreen> {
  int? amount = 1000;
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Recharge son compte"),
      body: Column(
        children: [
          Flexible(
              child: Container(
            height: 100,
          )),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Veuillez renseilller le montant à recharger ",
                    style: TextStyle(
                        color: ColorConst.text, fontStyle: FontStyle.italic),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: TextFormField(
                      initialValue: "$amount",
                      key: fieldKey,
                      onChanged: (value) {
                        amount = int.tryParse(value);
                        setState(() {});
                      },
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration:
                          AppDecore.input("Montant", prefix: Icons.money),
                    ),
                  ),
                  AppDecore.submitButton(context, "Valider", onSubmit)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSubmit() async {
    if (fieldKey.currentState == null || fieldKey.currentState!.validate()) {
      await _onPay();
    }
  }

  Future _onPay() async {
    User? user = context.read<UserService>().user;

    PhoneNumber phone =
        await PhoneNumber.getRegionInfoFromPhoneNumber(user!.phone!);
    String tel = phone.parseNumber().replaceAll(RegExp(r'[\+,-]'), '');
    final payer = KKiaPay(
      amount: amount,
      callback: onPaymentSuccess,
      apikey: AppUtil.kikiapayKey,
      phone: tel,
      name: "Ola BABA",
      data: "ola@gmail.com",
      sandbox: true,
      theme: "#009688",
    );
    String? id = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Scaffold(
                body: SafeArea(child: payer),
              )),
    ) as String;

    print("id : $id");
    if (id != null) {
      await verifyPayment(id);
    } else {
      PersonalAlert.showError(context,
          message:
              "Vous n'avez pas finalisé le rechargament. Assurez vous que vosu avez confirmer sur votre téléphone",
          title: "Rechargement Annulé");
    }
  }

  Future<void> onPaymentSuccess(
      Map<String, dynamic> response, BuildContext context) async {
    print(response);
    String transactionId = response["transactionId"];
    Navigator.pop<String>(context, transactionId);
  }

  Future<void> verifyPayment(String id) async {
    PersonalAlert.showLoading(context, message: "vérification en cours ...");
    await context
        .read<CompteService>()
        .creditAcount(id, amount!)
        .then((Compte? value) {
      context.read<UserService>().notifyListeners();
      PersonalAlert.showSuccess(context, message: "Compte rechargé avec succès")
          .then((r) {});
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error");
    });
  }
}
