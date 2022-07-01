import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/licence/licence-create.screen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../components/app-decore.dart';
import '../../components/personal_alert.dart';
import '../../models/moto.dart';
import '../../services/moto-service.dart';
import '../../utils/app-util.dart';
import '../../utils/request-exception.dart';

class MotoUpdateImageScreen extends StatefulWidget {
  MotoUpdateImageScreen({Key? key}) : super(key: key);

  @override
  State<MotoUpdateImageScreen> createState() => _MotoUpdateImageScreenState();
}

class _MotoUpdateImageScreenState extends State<MotoUpdateImageScreen> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppDecore.appBar(context, "Enrégistrer Moto"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 16),
            if (file != null) displayPdf(file!),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
              child: TextFormField(
                key: fieldKey,
                controller: controller,
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Valeur requise";
                  return null;
                },
                readOnly: true,
                onTap: () async {
                  final pickerFile = await ImagePicker.platform
                      .pickImage(source: ImageSource.gallery);
                  file = pickerFile != null ? File(pickerFile.path) : null;
                  controller.text = getFileName(file);
                  setState(() {});
                },
                decoration: AppDecore.input("Photo de la moto",
                    helper: "Cliquer pour choisir la photo de votre Moto",
                    prefix: Icons.upload_file),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            const SizedBox(height: 20),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: AppDecore.submitButton(context, "Valider", onSubmit))
          ],
        ));
  }

  onSubmit() {
    if (fieldKey.currentState != null && fieldKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context.read<MotoService>().updateMotoImage(file!).then((value) {
        PersonalAlert.showSuccess(context).then(
            (value) => AppUtil.goToScreen(context, LicenceCreateScreen()));
      }).onError((error, stackTrace) {
        if (error is RequestExcept) {
          setState(() {});
          PersonalAlert.showError(context, message: "${error.message}");
        } else {
          PersonalAlert.showError(context, message: "$error");
        }
      });
    }
  }

  String getFileName(File? file) {
    String value = file?.path == null ? "" : file!.path.split("/").last;
    return value;
  }

  Widget displayPdf(File file) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Image.file(file)),
        ),
      ),
    );
  }
}
