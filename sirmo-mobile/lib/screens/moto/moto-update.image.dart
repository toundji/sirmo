import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../components/app-decore.dart';

class MotoUpdateImageScreen extends StatefulWidget {
  MotoUpdateImageScreen({Key? key}) : super(key: key);

  @override
  State<MotoUpdateImageScreen> createState() => _MotoUpdateImageScreenState();
}

class _MotoUpdateImageScreenState extends State<MotoUpdateImageScreen> {
  TextEditingController controller = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppDecore.appBar(context, "Enrégistrer Moto"),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (file != null) displayPdf(file!),
            TextFormField(
              controller: controller,
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
                file = pickerFile?.files != null && pickerFile!.files.isNotEmpty
                    ? File(pickerFile.files[0].path!)
                    : null;
                controller.text = getFileName(file);
                setState(() {});
              },
              decoration: AppDecore.input("Photo de la moto",
                  helper: "Cliquer pour choisir la photo de votre Moto"),
            ),
          ],
        ));
  }

  String getFileName(File? file) {
    String value = file?.path == null ? "" : file!.path.split("/").last;
    return value;
  }

  Widget displayPdf(File pdf) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 1 / 1.41,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
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
}
