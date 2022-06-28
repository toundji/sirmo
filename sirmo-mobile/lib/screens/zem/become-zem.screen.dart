import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sirmo/models/arrondissement.dart';
import 'package:sirmo/models/commune.dart';
import 'package:sirmo/models/departement.dart';
import 'package:sirmo/services/user.service.dart';
import 'package:sirmo/utils/app-date.dart';
import '../../../components/curve_path_clipper.dart';
import '../../../services/departement.service.dart';
import '/screens/home/home.screen.dart';
import 'package:provider/provider.dart';

import '../../../components/app-decore.dart';
import '../../../components/personal_alert.dart';
import '../../../models/user.dart';
import '../../../services/auth.service.dart';
import '../../../utils/app-util.dart';
import '../../../utils/color-const.dart';
import '../../../utils/size-const.dart';

class ZemBecomeScreen extends StatefulWidget {
  ZemBecomeScreen({Key? key}) : super(key: key);

  @override
  State<ZemBecomeScreen> createState() => _ZemBecomeScreenState();
}

class _ZemBecomeScreenState extends State<ZemBecomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  User? user;
  @override
  void initState() {
    super.initState();
    user = context.read<UserService>().user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Devenir Zem"),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Card(
            elevation: 10.0,
            margin: EdgeInsets.all(8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppDecore.getTitle("Devenir Zem"),
                    SizedBox(height: 25),
                    TextFormField(
                      initialValue: user?.nom,
                      onChanged: onLastNameChanged,
                      validator: firstNameValidator,
                      decoration: AppDecore.input("IFU"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: user?.prenom,
                      onChanged: onFirstNameChanged,
                      validator: lastNameValidator,
                      decoration: AppDecore.input("CIP"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: user?.nom,
                      onChanged: onLastNameChanged,
                      validator: firstNameValidator,
                      decoration: AppDecore.input("NIP"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: user?.prenom,
                      onChanged: onFirstNameChanged,
                      validator: lastNameValidator,
                      decoration: AppDecore.input("Certificat de Route"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: user?.prenom,
                      onChanged: onFirstNameChanged,
                      validator: lastNameValidator,
                      decoration: AppDecore.input("Ancien Identifiant"),
                    ),
                    SizedBox(height: 16),
                    const Text(
                      "* est obligatoire",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    if (_hasError)
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16.0),
                          child: Text(
                            errorMessage!,
                            style: const TextStyle(color: ColorConst.error),
                          )),
                    const SizedBox(height: 20),
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
      ),
    );
  }

  String? firstNameValidator(String? value) {
    if (value == null)
      return "Le nom est obligartoire";
    else if (value.length < 3)
      return "Vous devez entrez 3 cararères au minimum";
    else if (value.length > 50)
      return "Vous devez entrez 50 cararères au maximum";
    return null;
  }

  onFirstNameChanged(String? value) {
    user?.prenom = value?.trim();
  }

  String? lastNameValidator(String? value) {
    if (value == null)
      return "Le prénom est obligartoire";
    else if (value.length < 3)
      return "Vous devez entrez 3 cararères au minimum";
    else if (value.length > 50)
      return "Vous devez entrez 50 cararères au maximum";
    return null;
  }

  onLastNameChanged(String? value) {
    user?.nom = value?.trim();
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context.read<AuthService>().create(user!).then((value) {
        PersonalAlert.showSuccess(context,
                message: "Vous êtes inscrit avec succès.")
            .then((value) {
          AppUtil.goToScreen(context, HomeScreen());
        });
        context.read<UserService>().user = value;
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
      });
    }
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
