import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/personal_alert.dart';
import 'package:sirmo/screens/moto/moto-update.image.dart';
import 'package:sirmo/services/moto-service.dart';
import 'package:sirmo/services/user.service.dart';
import 'package:sirmo/services/zem.sevice.dart';
import 'package:sirmo/utils/app-util.dart';
import '../../models/moto.dart';
import '../../utils/app-date.dart';
import '../../utils/request-exception.dart';

import '../../../components/app-decore.dart';
import '../../../utils/color-const.dart';

class MotoCreateScreen extends StatefulWidget {
  MotoCreateScreen({Key? key}) : super(key: key);

  @override
  State<MotoCreateScreen> createState() => _MotoCreateScreenState();
}

class _MotoCreateScreenState extends State<MotoCreateScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  Moto moto = Moto();
  RequestExcept? validation;
  @override
  void initState() {
    super.initState();
    moto.zem = context.read<ZemService>().zem;
    moto.proprietaire = context.read<UserService>().user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Enrégistrer Moto"),
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
                    AppDecore.getTitle("Enrégistrer Moto"),
                    const SizedBox(height: 25),
                    TextFormField(
                      initialValue: moto.immatriculation,
                      onChanged: (String? value) {
                        moto.immatriculation = value?.trim();
                        resetError('immatriculation');
                      },
                      validator: firstNameValidator,
                      decoration: AppDecore.input("Immatriculation"),
                    ),
                    ...displayError("ifu"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.numero_carte_grise,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.numero_carte_grise = value?.trim();
                        resetError('numero_carte_grise');
                      },
                      decoration: AppDecore.input("Numero de la carte grise"),
                    ),
                    ...displayError("numero_carte_grise"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.numero_chassis,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.numero_chassis = value?.trim();
                        resetError('numero_chassis');
                      },
                      decoration: AppDecore.input("Numero de Chassis"),
                    ),
                    ...displayError("numero_chassis"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.numero_serie_moteur,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.numero_serie_moteur = value?.trim();
                        resetError('numero_serie_moteur');
                      },
                      decoration: AppDecore.input("Numero de série Moteur"),
                    ),
                    ...displayError("numero_serie_moteur"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.provenance,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.provenance = value?.trim();
                        resetError('provenance');
                      },
                      decoration: AppDecore.input("Provenance"),
                    ),
                    ...displayError("provenance"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.puissance,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.puissance = value?.trim();
                        resetError('puissance');
                      },
                      decoration: AppDecore.input("Puissance"),
                    ),
                    ...displayError("puissance"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.marque,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.marque = value?.trim();
                        resetError('marque');
                      },
                      decoration: AppDecore.input("Marque"),
                    ),
                    ...displayError("marque"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.model,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.model = value?.trim();
                        resetError('modele');
                      },
                      decoration: AppDecore.input("Modele"),
                    ),
                    ...displayError("modele"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: moto.type,
                      validator: firstNameValidator,
                      onChanged: (String? value) {
                        moto.type = value?.trim();
                        resetError('type');
                      },
                      decoration: AppDecore.input("Type"),
                    ),
                    ...displayError("type"),
                    const SizedBox(height: 16),
                    DateTimeField(
                        format: AppDate.dateFormat,
                        initialValue: moto.annee_mise_circulation,
                        onChanged: (DateTime? date) {
                          moto.annee_mise_circulation = date;
                          resetError('annee_mise_circulation');
                        },
                        validator: (value) {
                          if (value == null) return 'La date est invalide';
                          return null;
                        },
                        decoration: AppDecore.input(
                            "Anné de mise en circulation",
                            prefix: Icons.event),
                        onShowPicker: AppUtil.showPicker),
                    ...displayError("annee_mise_circulation"),
                    const SizedBox(height: 16),
                    DateTimeField(
                        format: AppDate.dateFormat,
                        initialValue: moto.derniere_revision,
                        onChanged: (DateTime? date) {
                          moto.derniere_revision = date;
                          resetError('derniere_revision');
                        },
                        validator: (value) {
                          if (value == null) return 'La date est invalide';
                          return null;
                        },
                        decoration: AppDecore.input(
                            "Date de la dernière revision",
                            prefix: Icons.event),
                        onShowPicker: AppUtil.showPicker),
                    ...displayError("derniere_revision"),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                        decoration: AppDecore.input("Etat"),
                        items: Moto.ETATS
                            .map((e) =>
                                DropdownMenuItem(child: Text(e), value: e))
                            .toList(),
                        onChanged: (value) {
                          moto.etat = value?.trim();
                        }),
                    ...displayError("etat"),
                    const SizedBox(height: 16),
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

  String? Validator(String? value, [min = 3, max = 50]) {
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
      context.read<MotoService>().createMoto(moto).then((value) {
        PersonalAlert.showSuccess(context).then(
            (value) => AppUtil.goToScreen(context, MotoUpdateImageScreen()));
      }).onError((error, stackTrace) {
        if (error is RequestExcept) {
          setState(() {
            validation = error;
          });
          PersonalAlert.showError(context, message: "${error.message}");
        } else {
          PersonalAlert.showError(context, message: "$error");
        }
      });
    }
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
