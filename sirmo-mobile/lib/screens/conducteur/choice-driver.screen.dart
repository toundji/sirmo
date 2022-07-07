import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/conducteur.dart';

import '../../utils/app-util.dart';

class ChoiceDriverScreen extends StatefulWidget {
  ChoiceDriverScreen({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(Conducteur? conducteur) onSubmit;

  @override
  State<ChoiceDriverScreen> createState() => _ChoiceDriverScreenState();
}

class _ChoiceDriverScreenState extends State<ChoiceDriverScreen> {
  TextEditingController controller = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Choisir un conducteur"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Card(
            child: MaterialButton(
                onPressed: () async {
                  final pickerFile = await ImagePicker.platform
                      .pickImage(source: ImageSource.camera);
                  file = pickerFile != null ? File(pickerFile.path) : null;
                  controller.text = AppUtil.getFileName(file);
                  final FirebaseVisionImage visionImage =
                      FirebaseVisionImage.fromFile(file!);
                  final TextRecognizer textRecognizer =
                      FirebaseVision.instance.textRecognizer();
                  final VisionText visionText =
                      await textRecognizer.processImage(visionImage);
                  String? text = visionText.text;
                  if (text != null) {
                    controller.text = text;
                    controller.selection =
                        TextSelection(baseOffset: 0, extentOffset: text.length);
                  }

                  setState(() {});
                },
                child: Container(
                    height: 70, width: 100, child: Icon(Icons.camera))),
          ),
          if (file != null) AppDecore.dispayImageRatio(file!),
          TextField(
            onChanged: (String? value) {},
            controller: controller,
            decoration: AppDecore.input("Conduteur N°"),
          ),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: AppDecore.submitButton(context, "Valider", onSubmit))
        ]),
      ),
    );
  }

  onSubmit() {
    widget.onSubmit(null);
  }
}
