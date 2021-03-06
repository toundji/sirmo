import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/licence.dart';

import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/user.dart';
import '../../services/compte.service.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';

class LicenceCreateScreen extends StatefulWidget {
  LicenceCreateScreen({Key? key}) : super(key: key);

  @override
  State<LicenceCreateScreen> createState() => _LicenceCreateScreenState();
}

class _LicenceCreateScreenState extends State<LicenceCreateScreen> {
  int amount = 2000;
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
      name: "${user.nom} ${user.prenom}",
      sandbox: true,
      theme: "#${ColorConst.primary.value.toRadixString(16)}",
    );
    String? id = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Scaffold(
                body: SafeArea(child: payer),
              )),
    ) as String?;
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
        .creditAcount(id, 2000)
        .then((Compte? value) {
      context.read<UserService>().notifyListeners();
      PersonalAlert.showSuccess(context, message: "Compte rechargé avec succès")
          .then((r) {});
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error");
    });
  }
}
