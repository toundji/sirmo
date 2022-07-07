import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/licence/licence-create.screen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../components/app-decore.dart';
import '../../components/personal_alert.dart';
import '../../services/vehicule-service.dart';
import '../../utils/app-util.dart';
import '../../utils/request-exception.dart';

class vehiculeUpdateImageScreen extends StatefulWidget {
  vehiculeUpdateImageScreen({Key? key}) : super(key: key);

  @override
  State<vehiculeUpdateImageScreen> createState() =>
      _vehiculeUpdateImageScreenState();
}

class _vehiculeUpdateImageScreenState extends State<vehiculeUpdateImageScreen> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppDecore.appBar(context, "Enrégistrer vehicule"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 16),
            if (file != null) AppDecore.dispayImageRatio(file!),
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
                  controller.text = AppUtil.getFileName(file);
                  setState(() {});
                },
                decoration: AppDecore.input("Photo de la vehicule",
                    helper: "Cliquer pour choisir la photo de votre vehicule",
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
      context.read<VehiculeService>().updatevehiculeImage(file!).then((value) {
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
}
