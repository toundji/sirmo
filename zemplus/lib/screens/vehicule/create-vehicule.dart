import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/personal_alert.dart';
import 'package:sirmo/screens/vehicule/vehicule-update.image.dart';
import 'package:sirmo/services/vehicule-service.dart';
import 'package:sirmo/services/user.service.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import 'package:sirmo/utils/app-util.dart';
import '../../models/vehicule.dart';
import '../../utils/app-date.dart';
import '../../utils/request-exception.dart';

import '../../../components/app-decore.dart';
import '../../../utils/color-const.dart';

class vehiculeCreateScreen extends StatefulWidget {
  vehiculeCreateScreen({Key? key}) : super(key: key);

  @override
  State<vehiculeCreateScreen> createState() => _vehiculeCreateScreenState();
}

class _vehiculeCreateScreenState extends State<vehiculeCreateScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  Vehicule vehicule = Vehicule();
  RequestExcept? validation;
  @override
  void initState() {
    super.initState();
    vehicule.conducteur = context.read<ConducteurService>().conducteur;
    vehicule.proprietaire = context.read<UserService>().user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Enrégistrer vehicule"),
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
                    AppDecore.getTitle("Enrégistrer vehicule"),
                    const SizedBox(height: 25),
                    TextFormField(
                      initialValue: vehicule.immatriculation,
                      onChanged: (String? value) {
                        vehicule.immatriculation = value?.trim();
                        resetError('immatriculation');
                      },
                      validator: validator,
                      decoration: AppDecore.input("Immatriculation"),
                    ),
                    ...displayError("ifu"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.numero_carte_grise,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.numero_carte_grise = value?.trim();
                        resetError('numero_carte_grise');
                      },
                      decoration: AppDecore.input("Numero de la carte grise"),
                    ),
                    ...displayError("numero_carte_grise"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.numero_chassis,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.numero_chassis = value?.trim();
                        resetError('numero_chassis');
                      },
                      decoration: AppDecore.input("Numero de Chassis"),
                    ),
                    ...displayError("numero_chassis"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.numero_serie_moteur,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.numero_serie_moteur = value?.trim();
                        resetError('numero_serie_moteur');
                      },
                      decoration: AppDecore.input("Numero de série Moteur"),
                    ),
                    ...displayError("numero_serie_moteur"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.numero_serie,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.numero_serie = value?.trim();
                        resetError('numero_serie');
                      },
                      decoration: AppDecore.input("Numero série"),
                    ),
                    ...displayError("numero_serie"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.provenance,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.provenance = value?.trim();
                        resetError('provenance');
                      },
                      decoration: AppDecore.input("Provenance"),
                    ),
                    ...displayError("provenance"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.puissance,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.puissance = value?.trim();
                        resetError('puissance');
                      },
                      decoration: AppDecore.input("Puissance"),
                    ),
                    ...displayError("puissance"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.marque,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.marque = value?.trim();
                        resetError('marque');
                      },
                      decoration: AppDecore.input("Marque"),
                    ),
                    ...displayError("marque"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.modele,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.modele = value?.trim();
                        resetError('modele');
                      },
                      decoration: AppDecore.input("Modele"),
                    ),
                    ...displayError("modele"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.categorie,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.categorie = value?.trim();
                        resetError('categorie');
                      },
                      decoration: AppDecore.input("categorie"),
                    ),
                    ...displayError("categorie"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.puissance_fiscale,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.puissance_fiscale = value?.trim();
                        resetError('puissance_fiscale');
                      },
                      decoration: AppDecore.input("puissance_fiscale"),
                    ),
                    ...displayError("puissance_fiscale"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.type,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.type = value?.trim();
                        resetError('type');
                      },
                      decoration: AppDecore.input("Type"),
                    ),
                    ...displayError("type"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.ci_er,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.ci_er = value?.trim();
                        resetError('ci_er');
                      },
                      decoration: AppDecore.input("ci_er"),
                    ),
                    ...displayError("ci_er"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.ptac,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.ptac = value?.trim();
                        resetError('ptac');
                      },
                      decoration: AppDecore.input("ptac"),
                    ),
                    ...displayError("ptac"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.pv,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.pv = value?.trim();
                        resetError('pv');
                      },
                      decoration: AppDecore.input("pv"),
                    ),
                    ...displayError("pv"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.cv,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.cv = value?.trim();
                        resetError('cv');
                      },
                      decoration: AppDecore.input("cv"),
                    ),
                    ...displayError("cv"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.carosserie,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.carosserie = value?.trim();
                        resetError('carosserie');
                      },
                      decoration: AppDecore.input("carosserie"),
                    ),
                    ...displayError("carosserie"),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: vehicule.pays_immatriculation,
                      validator: validator,
                      onChanged: (String? value) {
                        vehicule.pays_immatriculation = value?.trim();
                        resetError('pays_immatriculation');
                      },
                      decoration: AppDecore.input("pays_immatriculation"),
                    ),
                    ...displayError("pays_immatriculation"),
                    const SizedBox(height: 16),
                    DateTimeField(
                        format: AppDate.dateFormat,
                        initialValue: vehicule.annee_mise_circulation,
                        onChanged: (DateTime? date) {
                          vehicule.annee_mise_circulation = date;
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
                        initialValue: vehicule.derniere_revision,
                        onChanged: (DateTime? date) {
                          vehicule.derniere_revision = date;
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
                        items: Vehicule.ETATS
                            .map((e) =>
                                DropdownMenuItem(child: Text(e), value: e))
                            .toList(),
                        onChanged: (value) {
                          vehicule.etat = value?.trim();
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

  String? validator(String? value, [min = 3, max = 50]) {
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
      context.read<VehiculeService>().createvehicule(vehicule).then((value) {
        PersonalAlert.showSuccess(context).then((value) =>
            AppUtil.goToScreen(context, vehiculeUpdateImageScreen()));
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
