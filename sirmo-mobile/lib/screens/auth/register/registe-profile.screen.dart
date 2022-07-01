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
import '../login.screen.dart';
import 'update-profile-image.screen.dart';

class RegistreProfileScreen extends StatefulWidget {
  RegistreProfileScreen({Key? key}) : super(key: key);

  @override
  State<RegistreProfileScreen> createState() => _RegistreProfileScreenState();
}

class _RegistreProfileScreenState extends State<RegistreProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();
  List<Departement>? departments;
  Departement? dep;
  Commune? commune;

  User? user;

  String genre = User.MASCULIN;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthService>().user;

    genre = user?.genre ?? User.MASCULIN;

    context
        .read<DepartmentService>()
        .loadAll()
        .then((value) {})
        .onError((error, stackTrace) {
      setState(() {
        errorMessage = "$error";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    departments = context.watch<DepartmentService>().all;

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
                    AppDecore.getTitle("Profile"),
                    SizedBox(height: 25),
                    TextFormField(
                      initialValue: user?.nom,
                      onChanged: onLastNameChanged,
                      validator: firstNameValidator,
                      decoration: AppDecore.input("Nom"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: user?.prenom,
                      onChanged: onFirstNameChanged,
                      validator: lastNameValidator,
                      decoration: AppDecore.input("Prénom"),
                    ),
                    SizedBox(height: 16),
                    DateTimeField(
                        format: AppDate.dateFormat,
                        initialValue: user?.date_naiss,
                        onChanged: (DateTime? date) {
                          user?.date_naiss = date;
                        },
                        validator: (value) {
                          if (value == null) return 'La date est invalide';
                          return null;
                        },
                        decoration:
                            AppDecore.input("Date", prefix: Icons.event),
                        onShowPicker: AppUtil.showPicker),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                                value: User.MASCULIN,
                                groupValue: user?.genre,
                                onChanged: (String? value) {
                                  user?.genre = value ?? User.MASCULIN;
                                  setState(() {});
                                }),
                            Text("MASCULIN")
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                                value: User.FEMININ,
                                groupValue: user?.genre,
                                onChanged: (String? value) {
                                  user?.genre = value ?? User.MASCULIN;

                                  setState(() {});
                                }),
                            Text("FEMININ")
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 16),
                    DropdownButtonFormField<Departement>(
                      onChanged: (value) {
                        setState(() {
                          dep = value;
                        });
                      },
                      isDense: true,
                      isExpanded: true,
                      validator: departmentValidator,
                      decoration: AppDecore.input("Departement * "),
                      items: departments == null
                          ? []
                          : departments!
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      "${e.nom}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                    ),
                    SizedBox(height: 16),
                    if (dep != null)
                      DropdownButtonFormField<Commune>(
                        onChanged: (value) {
                          setState(() {
                            commune = value;
                          });
                        },
                        isDense: true,
                        isExpanded: true,
                        validator: (value) {
                          if (value == null)
                            return "le commune est obligatoire";
                        },
                        decoration: AppDecore.input("Commune * "),
                        items: dep?.communes == null
                            ? []
                            : dep!.communes!
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        "${e.nom}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                      ),
                    SizedBox(height: 16),
                    if (commune != null)
                      DropdownButtonFormField<Arrondissement>(
                        onChanged: (value) {
                          setState(() {
                            user?.arrondissement = value;
                          });
                        },
                        isDense: true,
                        isExpanded: true,
                        validator: (value) {
                          if (value == null)
                            return "l'arrondissement est obligatoire";
                        },
                        decoration: AppDecore.input("Arrondissement * "),
                        items: commune?.arrondissements == null
                            ? []
                            : commune!.arrondissements!
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        "${e.nom}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      value: e,
                                    ))
                                .toList(),
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

  String? departmentValidator(Departement? value) {
    if (value == null) return "Le département est obligartoire";
    return null;
  }

  String? communeValidator(Departement? value) {
    if (value == null) return "La commune est obligartoire";
  }

  String? arrondisValidator(Departement? value) {
    if (value == null) return "L'arrondissement est obligartoire";
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

  String? cityValidator(String? value) {
    if (value == null)
      return "La ville est obligartoire";
    else if (value.length < 3)
      return "Vous devez entrez 3 cararères au minimum";
    else if (value.length > 50)
      return "Vous devez entrez 50 cararères au maximum";
    return null;
  }

  String? adresseValidator(String? value) {
    if (value == null) {
      return "L'adresse est obligartoire";
    } else if (value.length < 3) {
      return "Vous devez entrez 3 cararères au minimum";
    } else if (value.length > 50) {
      return "Vous devez entrez 50 cararères au maximum";
    }
    return null;
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context.read<AuthService>().create(user!).then((value) {
        PersonalAlert.showSuccess(context,
                message: "Vous êtes inscrit avec succès.")
            .then((value) {
          AppUtil.goToScreen(context, UpdateProfileImageScreen());
        });
        context.read<UserService>().user = value;
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
      });
    }
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
