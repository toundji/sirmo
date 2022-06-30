import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:sirmo/components/app-decore.dart';

import '../../components/personal_alert.dart';
import '../../models/zem.dart';
import '../../services/zem.sevice.dart';
import '../../utils/app-util.dart';
import '../../utils/request-exception.dart';
import '../home/home.screen.dart';

class BecomeZemFileScreen extends StatefulWidget {
  BecomeZemFileScreen({
    Key? key,
    required this.zem,
  }) : super(key: key);

  final Zem zem;

  @override
  State<BecomeZemFileScreen> createState() => _BecomeZemFileScreenState();
}

class _BecomeZemFileScreenState extends State<BecomeZemFileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  late Zem zem;
  RequestExcept? validation;
  bool _useCustomFileViewer = true;
  bool formSubmited = false;

  Map<String, File?> files = {
    "ifu": null,
    "cip": null,
    "nip": null,
    "idCarde": null,
    "ancienIdentifiant": null,
    "certificatRoute": null
  };

  Map<String, String?> keyName = {
    "ifu": "IFU",
    "cip": "CIP",
    "nip": "NIP",
    "idCarde": "Carte d'identité",
    "ancienIdentifiant": "Ancien identifiant",
    "certificatRoute": "Permis moto"
  };

  Map<String, TextEditingController> controllers = {
    "ifu": TextEditingController(),
    "cip": TextEditingController(),
    "nip": TextEditingController(),
    "idCarde": TextEditingController(),
    "ancienIdentifiant": TextEditingController(),
    "certificatRoute": TextEditingController()
  };

  @override
  void initState() {
    zem = widget.zem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Documents"),
      body: SingleChildScrollView(
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
                  _formField('ifu'),
                  _formField('cip'),
                  _formField('nip'),
                  _formField('idCarde'),
                  _formField('ancienIdentifiant'),
                  _formField('certificatRoute'),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child:
                          AppDecore.submitButton(context, "Valider", onSubmit))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formField(String cle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (files[cle] != null) displayPdf(files[cle]!),
        TextFormField(
          controller: controllers[cle],
          validator: (String? value) {
            if (value == null || value.isEmpty) return "Valeur requise";
            return null;
          },
          readOnly: true,
          onTap: () async {
            final pickerFile = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowMultiple: false,
              allowedExtensions: ["pdf"],
            );
            files[cle] =
                pickerFile?.files != null && pickerFile!.files.isNotEmpty
                    ? File(pickerFile.files[0].path!)
                    : null;
            controllers[cle]?.text = getFileName(files[cle]);
            setState(() {});
          },
          decoration: AppDecore.input(keyName[cle]!,
              helper:
                  "Cliquer pour choisir le fichier pdf de votre ${keyName[cle]}"),
        ),
      ],
    );
  }

  String getFileName(File? file) {
    String value = file?.path == null ? "" : file!.path.split("/").last;
    return value;
  }

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) return "Valeur requise";
    return null;
  }

  Widget displayPdf(File pdf) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 1 / 1.41,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16,
            ),
            child: SfPdfViewer.file(
              pdf,
              canShowScrollHead: false,
              canShowScrollStatus: false,
              enableTextSelection: true,
              canShowPaginationDialog: false,
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context.read<ZemService>().becomeZem(zem, files).then((value) {
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
}
