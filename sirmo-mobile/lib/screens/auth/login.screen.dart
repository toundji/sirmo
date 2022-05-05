import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/components/icon-animation.dart';
import 'package:sirmo/components/responsive.dart';
import 'package:sirmo/components/shake-transition.dart';
import 'package:sirmo/main.dart';
import 'package:sirmo/models/login.dart';
import 'package:sirmo/services/auth.service.dart';
import 'package:sirmo/utils/color-const.dart';

import '../../components/personal_alert.dart';
import '../../utils/size-const.dart';
import '../home/home.screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorText = "";
  bool _phoneIsValide = false;
  String? password;
  PhoneNumber? phone = PhoneNumber(isoCode: "BJ");
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 200,
              child: Image.asset(
                "assets/images/logo_large.png",
                fit: BoxFit.cover,
              )),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: Responsive.responsiveValue(context,
                      mobile: MainAxisSize.min),
                  children: [
                    AppDecore.getTitle("Connexion"),
                    const SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Responsive.responsiveValue(context,
                                mobile: 16.0, desktop: 24.0)),
                        child: InternationalPhoneNumberInput(
                          onInputValidated: (value) {
                            log("$value");
                            _phoneIsValide = value;
                          },
                          initialValue: phone,
                          countries: ["BJ"],
                          errorMessage: "Numméron de téléphone est invalide",
                          spaceBetweenSelectorAndTextField: 0.0,
                          validator: phoneValidator,
                          onInputChanged: onPhoneChanged,
                          inputDecoration: AppDecore.input("Téléphone * "),
                          selectorConfig: SelectorConfig(
                              leadingPadding: SizeConst.padding,
                              setSelectorButtonAsPrefixIcon: true),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.responsiveValue(context,
                              mobile: 16.0, desktop: 24.0)),
                      child: TextFormField(
                        onChanged: onPasswordChanged,
                        validator: passwordValidator,
                        decoration: AppDecore.input("Password"),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text("Se souvenir de moi")
                      ],
                    ),
                    Text(
                      errorText ?? "",
                      style: TextStyle(color: ColorConst.error),
                    ),
                    const SizedBox(height: 10),
                    AppDecore.button(context, "Valider", onSubmit)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  get form {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.responsiveValue(context,
            mobile: 16.0, tablet: 50.0, desktop: 20.0),
        horizontal: Responsive.responsiveValue(context,
            mobile: 16.0, tablet: 150.0, desktop: 100.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 35),
          Flexible(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Image.asset("assets/images/logo_large.png"))),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.responsiveValue(context,
                      mobile: 16.0, tablet: 60.0, desktop: 50.0),
                  vertical: Responsive.responsiveValue(context,
                      mobile: 50.0, tablet: 50.0, desktop: 50.0),
                ),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? phoneValidator(String? value) {
    if (value == null) return "Le numéro de téléphone est obligatoire";
    if (!_phoneIsValide) return "Le numéro de téléphone est invalide";
    return null;
  }

  onPhoneChanged(PhoneNumber? value) {
    phone = value;
  }

  String? passwordValidator(String? value) {
    if (value == null)
      return "Le mot de passe est obligartoire";
    else if (value.length < 6)
      return "Vous devez entrez 6 cararères au minimum";
    else if (value.length > 15)
      return "Vous devez entrez 15 cararères au maximum";
    return null;
  }

  onPasswordChanged(String? value) {
    password = value;
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context
          .read<AuthService>()
          .login(Login(username: phone.toString(), password: password!))
          .then((value) {
        PersonalAlert.showSuccess(context,
                message: "Vous êtes connecter avec succès")
            .then((value) =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName));
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error").then((value) {});
        setState(() {
          errorText = "$error";
        });
      });
    }
  }
}
