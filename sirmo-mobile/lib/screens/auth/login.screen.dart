import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sirmo/screens/home/home.screen.dart';
import '../../components/curve_path_clipper.dart';
import '/components/app-decore.dart';
import '/components/shake-transition.dart';
import '/screens/auth/register/register.screen.dart';
import '/services/user.service.dart';
import '/utils/app-util.dart';
import '/utils/color-const.dart';
import 'package:provider/provider.dart';

import '../../components/personal_alert.dart';
import '../../utils/size-const.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "login";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage;
  String? password;
  String? email;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool saveInfo = false;
  PhoneNumber? phone = PhoneNumber(isoCode: "BJ");
  bool phoneisValide = false;

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
              style: TextStyle(color: ColorConst.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShakeTransition(
              child: Card(
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
                        AppDecore.getTitle("Conexion"),
                        SizedBox(height: 25),
                        Padding(
                            padding:
                                EdgeInsets.only(top: SizeConst.padding + 10),
                            child: InternationalPhoneNumberInput(
                              onInputValidated: (value) {
                                log("$value");
                                phoneisValide = value;
                              },
                              initialValue: phone,
                              countries: ["BJ", "CI"],
                              errorMessage: "Numm??ro de t??l??phone est invalide",
                              spaceBetweenSelectorAndTextField: 0.0,
                              validator: phoneValidator,
                              onInputChanged: onPhoneChanged,
                              inputDecoration: AppDecore.input("T??l??phone * "),
                              selectorConfig: SelectorConfig(
                                  leadingPadding: SizeConst.padding,
                                  trailingSpace: false,
                                  setSelectorButtonAsPrefixIcon: true),
                            )),
                        SizedBox(height: 25),
                        TextFormField(
                          onChanged: onPasswordChanged,
                          initialValue: password,
                          validator: passwordValidator,
                          obscureText: true,
                          decoration: AppDecore.input("Password"),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            const Flexible(
                                child: SizedBox(
                              width: 20,
                            )),
                            Checkbox(
                                value: saveInfo,
                                onChanged: (value) {
                                  setState(() {
                                    saveInfo = value ?? false;
                                  });
                                }),
                            Text("Se souvenir de moi"),
                          ],
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
            ),
            Padding(
              padding: EdgeInsets.all(SizeConst.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Je n'ai pas de compte ! ",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextButton(
                    onPressed: () {
                      AppUtil.goToScreen(context, RegisterScreen());
                    },
                    child: const Text(
                      "S'inscrire",
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

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      var formValue = {
        "email": email,
        "password": password,
      };
      PersonalAlert.showLoading(context);

      context
          .read<UserService>()
          .login("${phone?.dialCode}${phone?.parseNumber()}", password!)
          .then((value) {
        PersonalAlert.showSuccess(context,
                message: "Vous ??tes connecter avec succ??s")
            .then(
          (value) => AppUtil.goToScreen(context, HomeScreen()),
        );
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error").then((value) {});
      });
    }
  }

  onMailChanged(value) {
    email = value;
  }

  String? phoneValidator(String? value) {
    if (value == null) return "Le num??ro de t??l??phone est obligatoire";
    if (!phoneisValide) return "Le num??ro de t??l??phone est invalide";
    return null;
  }

  onPhoneChanged(PhoneNumber? value) {
    phone = value;
  }

  MultiValidator emailValidator() {
    return MultiValidator([
      EmailValidator(errorText: "Format email invalid"),
    ]);
  }

  String? passwordValidator(String? value) {
    if (value == null)
      return "Le mot de passe est obligartoire";
    else if (value.length < 6)
      return "Vous devez entrez 6 carar??res au minimum";
    else if (value.length > 15)
      return "Vous devez entrez 15 carar??res au maximum";
    return null;
  }

  onPasswordChanged(String? value) {
    password = value;
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
