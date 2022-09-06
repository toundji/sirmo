import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kkiapay_flutter_sdk/kkiapay/view/widget_builder_view.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/conducteur.dart';
import 'package:sirmo/models/enums/licence_property.dart';
import 'package:sirmo/models/licence_vehicule.dart';
import 'package:sirmo/services/conducteur.sevice.dart';

import '../../components/personal_alert.dart';
import '../../models/constante.dart';
import '../../models/user.dart';
import '../../services/constante.service.dart';
import '../../services/licence.service.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../../utils/size-const.dart';

class LicenceCreateScreen extends StatefulWidget {
  LicenceCreateScreen({Key? key}) : super(key: key);

  @override
  State<LicenceCreateScreen> createState() => _LicenceCreateScreenState();
}

class _LicenceCreateScreenState extends State<LicenceCreateScreen> {
  int? amount = 2000;
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  TextEditingController dureeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? errorMessage;
  PhoneNumber? phone;
  bool phoneIsValide = false;
  Map<String, Constante> constantes = {};
  late User user;

  @override
  void initState() {
    super.initState();

    user = context.read<UserService>().user!;
    phone = PhoneNumber(isoCode: "BJ", phoneNumber: user.phone);

    context
        .read<ConstanteService>()
        .loadAllByName()
        .then((value) => null)
        .onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    constantes = context.watch<ConstanteService>().allByName;
    dureeController.text =
        constantes[LicenceProperty.DUREE_DUREE]?.valeur ?? '12';
    amountController.text =
        constantes[LicenceProperty.PRIX_LICENCE]?.valeur ?? '....';
    amount =
        int.tryParse("${constantes[LicenceProperty.PRIX_LICENCE]?.valeur}");
    return Scaffold(
      appBar: AppDecore.appBar(context, "Achat de licenece"),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Veuillez renseilller le montant à recharger ",
                    style: TextStyle(
                        color: ColorConst.text, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: TextFormField(
                      controller: amountController,
                      readOnly: true,
                      decoration: AppDecore.input("Montant",
                          prefix: Icons.money, suffixWidget: Text("F CFA")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: TextFormField(
                        controller: dureeController,
                        readOnly: true,
                        decoration: AppDecore.input("Durrée",
                            prefix: Icons.timelapse,
                            suffixWidget: const Text("mois"))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: SizeConst.padding + 10),
                      child: InternationalPhoneNumberInput(
                        key: fieldKey,
                        onInputValidated: (value) {
                          phoneIsValide = value;
                        },
                        initialValue: phone,
                        countries: const ["BJ", "CI"],
                        errorMessage: "Numméro de téléphone est invalide",
                        spaceBetweenSelectorAndTextField: 0.0,
                        validator: phoneValidator,
                        onInputChanged: onPhoneChanged,
                        inputDecoration: AppDecore.input("Téléphone * "),
                        selectorConfig: SelectorConfig(
                            leadingPadding: SizeConst.padding,
                            trailingSpace: false,
                            setSelectorButtonAsPrefixIcon: true),
                      )),
                  AppDecore.submitButton(
                    context,
                    "Valider",
                    onSubmit,
                    onLongPress: onLongPressed,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? phoneValidator(String? value) {
    if (value == null) return "Le numéro de téléphone est obligatoire";
    if (!phoneIsValide) return "Le numéro de téléphone est invalide";
    return null;
  }

  onPhoneChanged(PhoneNumber? value) {
    phone = value;
  }

  onSubmit() async {
    if (amount != null && fieldKey.currentState == null ||
        fieldKey.currentState!.validate()) {
      await _onPay();
    }
  }

  onLongPressed() async {
    if (amount != null && fieldKey.currentState == null ||
        fieldKey.currentState!.validate()) {
      await verifyPayment("${DateTime.now()}");
    }
  }

  Future _onPay() async {
    String tel = phone!.parseNumber().replaceAll(RegExp(r'[\+,-]'), '');
    final payer = KKiaPay(
      amount: amount ?? 0,
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
    Conducteur conducteur = context.read<ConducteurService>().conducteur!;
    await context
        .read<LicenceService>()
        .pay(conducteur.vehicule?.id ?? -1, id)
        .then((LicenceVehicule? value) {
      PersonalAlert.showSuccess(context, message: "Licence payé avec succès")
          .then((r) {
        context.read<ConducteurService>().payLicenece(value!);

        Navigator.pop(context);
      });
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error");
    });
  }
}
