import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sirmo/screens/auth/register/registe-profile.screen.dart';
import '../../../components/curve_path_clipper.dart';
import '../../../components/personal_alert.dart';
import '../../../models/user.dart';
import '../../../services/auth.service.dart';
import '/components/app-decore.dart';
import '/screens/home/home.screen.dart';
import '/utils/app-util.dart';
import '/utils/color-const.dart';
import 'package:provider/provider.dart';

import '../../../utils/size-const.dart';
import '../login.screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? errorMessage;
  String? password;
  String? email;
  String? confirmPassword;
  PhoneNumber? phone = PhoneNumber(isoCode: "BJ");
  bool phoneisValide = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool saveInfo = false;

  @override
  void initState() {
    super.initState();
    User? user = context.read<AuthService>().user;
    password = user?.password;
    email = user?.email;
    phone = context.read<AuthService>().phone ?? phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 120),
        child: ClipPath(
          clipper: CurvePathClipper(),
          child: AppBar(
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: ColorConst.white),
            title: Text(
              AppUtil.appName,
              textScaleFactor: 1.2,
              style: TextStyle(
                color: ColorConst.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10.0,
              margin: EdgeInsets.all(16),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDecore.getTitle("Inscription"),
                      Padding(
                          padding: EdgeInsets.only(top: SizeConst.padding),
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
                          )),
                      SizedBox(height: 25),
                      TextFormField(
                        onChanged: onMailChanged,
                        validator: emailValidator(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppDecore.input("Email"),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        onChanged: onPasswordChanged,
                        initialValue: password,
                        validator: passwordValidator,
                        obscureText: true,
                        decoration: AppDecore.input("Password"),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        onChanged: onConfirmChanged,
                        initialValue: confirmPassword,
                        obscureText: true,
                        validator: confirmValidator,
                        decoration: AppDecore.input("Confirmer"),
                      ),
                      if (_hasError)
                        Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              errorMessage!,
                              style: TextStyle(color: ColorConst.error),
                            )),
                      SizedBox(height: 20),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: AppDecore.submitButton(
                              context, "Valider", onSubmit))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConst.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "J'ai déjà un compte ! ",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextButton(
                    onPressed: () {
                      AppUtil.goToScreen(context, LoginScreen());
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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

  onMailChanged(value) {
    email = value;
  }

  MultiValidator emailValidator() {
    return MultiValidator([
      EmailValidator(errorText: "Format email invalid"),
    ]);
  }

  String? confirmValidator(String? value) {
    if (password != null && value != password)
      return "Les deux mots de passe ne corresponde pas.";
    return null;
  }

  onConfirmChanged(String? value) {
    confirmPassword = value;
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      AuthService authService = context.read<AuthService>();
      authService.setEmailPhoneAndPass(phone!, password!, email);

      PersonalAlert.showLoading(context);

      authService.checkAvailableEmail().then((value) {
        authService.checkAvailablePhone().then((value) {
          AppUtil.goToScreen(context, RegistreProfileScreen());
        }).onError((error, stackTrace) {
          PersonalAlert.showError(context, message: "$error");
          setState(() {
            errorMessage = "$error";
          });
        });
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
        setState(() {
          errorMessage = "$error";
        });
      });
    }
    AppUtil.goToScreen(context, RegistreProfileScreen());
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

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
