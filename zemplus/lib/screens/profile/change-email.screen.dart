import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../components/app-decore.dart';
import '../../components/personal_alert.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../../utils/size-const.dart';
import '../auth/login.screen.dart';

class ChangeEmailComponent extends StatefulWidget {
  ChangeEmailComponent({Key? key}) : super(key: key);

  @override
  State<ChangeEmailComponent> createState() => _ChangeEmailComponentState();
}

class _ChangeEmailComponentState extends State<ChangeEmailComponent> {
  String? email;
  GlobalKey<FormFieldState> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppDecore.getTitle("Email"),
        SizedBox(height: 25),
        TextFormField(
          key: _fieldKey,
          onChanged: (value) {
            email = value;
          },
          validator: emailValidator(),
          keyboardType: TextInputType.emailAddress,
          decoration: AppDecore.input("Email"),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: onSubmit,
                child: Text(
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

  MultiValidator emailValidator() {
    return MultiValidator([
      EmailValidator(errorText: "Format email invalid"),
      RequiredValidator(errorText: "Vous devez entrez une valleur")
    ]);
  }

  onSubmit() {
    if (_fieldKey.currentState != null && _fieldKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context.read<UserService>().changeEmail(email!).then((value) {
        PersonalAlert.showSuccess(context, message: "Email avec succès")
            .then((value) {
          Navigator.pop(context);
        });
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
      });
    }
  }
}
