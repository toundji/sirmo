import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/utils/color-const.dart';

import '../../components/app-decore.dart';
import '../../components/personal_alert.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/size-const.dart';
import '../auth/login.screen.dart';

class ChangePhoneComponent extends StatefulWidget {
  ChangePhoneComponent({Key? key}) : super(key: key);

  @override
  State<ChangePhoneComponent> createState() => _ChangePhoneComponentState();
}

class _ChangePhoneComponentState extends State<ChangePhoneComponent> {
  bool phoneisValide = false;
  PhoneNumber? phone = PhoneNumber(isoCode: "BJ");
  GlobalKey<FormState> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppDecore.getTitle("Conexion"),
        SizedBox(height: 25),
        Padding(
            padding: EdgeInsets.only(top: SizeConst.padding + 10),
            child: Form(
              key: _fieldKey,
              child: InternationalPhoneNumberInput(
                onInputValidated: (value) {
                  log("$value");
                  phoneisValide = value;
                },
                initialValue: phone,
                countries: ["BJ", "CI"],
                errorMessage: "Numméro de téléphone est invalide",
                spaceBetweenSelectorAndTextField: 0.0,
                validator: phoneValidator,
                onInputChanged: onPhoneChanged,
                inputDecoration: AppDecore.input("Téléphone * "),
                selectorConfig: SelectorConfig(
                    leadingPadding: SizeConst.padding,
                    trailingSpace: false,
                    setSelectorButtonAsPrefixIcon: true),
              ),
            )),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: onSubmit,
                child: const Text(
                  "Valider",
                  textScaleFactor: 1.2,
                  style: TextStyle(fontSize: 18),
                )),
            AppDecore.submitButton(context, "Annuler", () {
              Navigator.pop(context);
            }, color: ColorConst.error),
          ],
        )
      ],
    );
  }

  String? phoneValidator(String? value) {
    if (value == null) return "Le numéro de téléphone est obligatoire";
    if (!phoneisValide) return "Le numéro de téléphone est invalide";
    return null;
  }

  onPhoneChanged(PhoneNumber? value) {
    phone = value;
  }

  onSubmit() {
    log("${_fieldKey.currentState}");
    if (_fieldKey.currentState != null && _fieldKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context
          .read<UserService>()
          .changePhone(phone!.phoneNumber!)
          .then((value) {
        PersonalAlert.showSuccess(context, message: "Numero changé avec succès")
            .then((value) {
          AppUtil.popAllAndGoTo(context, LoginScreen());
        });
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
      });
    }
  }
}
