import 'package:flutter/material.dart';
import 'package:sirmo/services/zem.sevice.dart';
import '../../models/zem.dart';
import '../../utils/request-exception.dart';
import '/screens/home/home.screen.dart';
import 'package:provider/provider.dart';

import '../../../components/app-decore.dart';
import '../../../components/personal_alert.dart';
import '../../../models/zem.dart';
import '../../../utils/app-util.dart';
import '../../../utils/color-const.dart';

class ZemBecomeScreen extends StatefulWidget {
  ZemBecomeScreen({Key? key}) : super(key: key);

  @override
  State<ZemBecomeScreen> createState() => _ZemBecomeScreenState();
}

class _ZemBecomeScreenState extends State<ZemBecomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  Zem zem = Zem();
  RequestExcept? validation;
  @override
  void initState() {
    super.initState();
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
                      initialValue: zem.ifu,
                      onChanged: (String? value) {
                        zem.ifu = value?.trim();
                        resetError('ifu');
                      },
                      validator: (value) => firstNameValidator(value, 8, 17),
                      decoration: AppDecore.input("IFU"),
                    ),
                    ...displayError("ifu"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: zem.cip,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        zem.cip = value?.trim();
                        resetError('cip');
                      },
                      decoration: AppDecore.input("CIP"),
                    ),
                    ...displayError("cip"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: zem.nip,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        zem.nip = value?.trim();
                        resetError('nip');
                      },
                      decoration: AppDecore.input("NIP"),
                    ),
                    ...displayError("nip"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: zem.certificatRoute,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        zem.certificatRoute = value?.trim();
                        resetError('certificatRoute');
                      },
                      decoration: AppDecore.input("Certificat de Route"),
                    ),
                    ...displayError("certificatRoute"),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: zem.ancienIdentifiant,
                      validator: (value) => firstNameValidator(value, 8, 17),
                      onChanged: (String? value) {
                        zem.ancienIdentifiant = value?.trim();
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
      PersonalAlert.showLoading(context);
      context.read<ZemService>().becomeZem(zem).then((value) {
        PersonalAlert.showSuccess(context,
                message: "Vous demander est enregistrées evac succès")
            .then((value) {
          AppUtil.goToScreen(context, HomeScreen());
        });
        context.read<ZemService>().zem = value;
      }).onError((error, stackTrace) {
        if (error is RequestExcept) {
          setState(() {
            validation = error;
          });
        } else if (error is String) {
          PersonalAlert.showError(context, message: "$error");
        }
      });
    }
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
