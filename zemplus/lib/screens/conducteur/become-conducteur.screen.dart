import 'package:flutter/material.dart';
import 'package:sirmo/screens/conducteur/become-conducteur-file.screen.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import '../../models/conducteur.dart';
import '../../utils/request-exception.dart';
import '/screens/home/home.screen.dart';
import 'package:provider/provider.dart';

import '../../../components/app-decore.dart';
import '../../../components/personal_alert.dart';
import '../../../models/conducteur.dart';
import '../../../utils/app-util.dart';
import '../../../utils/color-const.dart';

class ConducteurBecomeScreen extends StatefulWidget {
  ConducteurBecomeScreen({Key? key}) : super(key: key);

  @override
  State<ConducteurBecomeScreen> createState() => _ConducteurBecomeScreenState();
}

class _ConducteurBecomeScreenState extends State<ConducteurBecomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  Conducteur conducteur = Conducteur();
  RequestExcept? validation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Devenir Conducteur"),
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
                    AppDecore.getTitle("Devenir Conducteur"),
                    SizedBox(height: 25),
                    TextFormField(
                      initialValue: conducteur.ifu,
                      onChanged: (String? value) {
                        conducteur.ifu = value?.trim();
                        resetError('ifu');
                      },
                      validator: (value) => firstNameValidator(value, 8, 17),
                      decoration: AppDecore.input("IFU"),
                    ),
                    ...displayError("ifu"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: conducteur.cip,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        conducteur.cip = value?.trim();
                        resetError('cip');
                      },
                      decoration: AppDecore.input("CIP"),
                    ),
                    ...displayError("cip"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: conducteur.nip,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        conducteur.nip = value?.trim();
                        resetError('nip');
                      },
                      decoration: AppDecore.input("NIP"),
                    ),
                    ...displayError("nip"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: conducteur.permis,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        conducteur.permis = value?.trim();
                        resetError('permis');
                      },
                      decoration: AppDecore.input("Permis de conduire moto"),
                    ),
                    ...displayError("permis"),
                    SizedBox(height: 16),
                    ...displayError("idCarde"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: conducteur.ancienIdentifiant,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        conducteur.ancienIdentifiant = value?.trim();
                        resetError('ancienIdentifiant');
                      },
                      decoration: AppDecore.input("Ancien Identifiant"),
                    ),
                    ...displayError("ancienIdentifiant"),
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

  List<Widget> displayError(String cle) {
    if (validation?.validations?[cle] != null) {
      return (validation?.validations?[cle] as List)
          .map((e) => Row(
                children: [
                  Text(e, style: TextStyle(color: ColorConst.error)),
                ],
              ))
          .toList();
    }
    return [];
  }

  void resetError(cle) {
    if (validation?.validations?[cle] != null &&
        (validation?.validations?[cle] as List).isNotEmpty) {
      validation?.validations?[cle] = null;
      setState(() {});
    }
  }

  String? firstNameValidator(String? value, [min = 3, max = 50]) {
    if (value == null) {
      return "Ce champ est obligartoire";
    } else if (value.length < min) {
      return "Vous devez entrez $min cararères au minimum";
    } else if (value.length > max) {
      return "Vous devez entrez $max cararères au maximum";
    }
    return null;
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      AppUtil.goToScreen(
          context,
          BecomeConducteurFileScreen(
            conducteur: conducteur,
          ));
    }
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
