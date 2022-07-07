import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/appreciation.dart';

import '../../components/shake-transition.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../../utils/size-const.dart';

class EvaluateConducteurScreen extends StatefulWidget {
  EvaluateConducteurScreen({Key? key}) : super(key: key);

  @override
  State<EvaluateConducteurScreen> createState() =>
      _EvaluateConducteurScreenState();
}

class _EvaluateConducteurScreenState extends State<EvaluateConducteurScreen> {
  File? image;
  TextEditingController controller = TextEditingController();

  PhoneNumber? phone = PhoneNumber(isoCode: "BJ");
  bool phoneisValide = false;

  Appreciation appreciation = Appreciation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Appréciation"),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCard(
                    value: "EXCELLENT",
                    icon: CupertinoIcons.add,
                    color: Colors.blue),
                getCard(
                    value: "TRES BON",
                    icon: CupertinoIcons.add,
                    color: Colors.green),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCard(
                    value: "BON",
                    icon: CupertinoIcons.add,
                    color: Colors.yellow),
                getCard(
                    value: "MAUVAISE",
                    icon: CupertinoIcons.add,
                    color: Colors.red),
              ],
            ),
            SizedBox(height: 25),
            Padding(
                padding: EdgeInsets.only(top: SizeConst.padding + 10),
                child: InternationalPhoneNumberInput(
                  onInputValidated: (value) {
                    log("$value");
                    phoneisValide = value;
                  },
                  initialValue: phone,
                  countries: ["BJ", "CI"],
                  errorMessage: "Numméro de téléphone est invalide",
                  spaceBetweenSelectorAndTextField: 0.0,
                  validator: phoneValidator,
                  onInputChanged: onPhoneChanged,
                  inputDecoration: AppDecore.input("Téléphone * ",
                      helper: "Saisissez votre numéro de téléphone"),
                  selectorConfig: SelectorConfig(
                      leadingPadding: SizeConst.padding,
                      trailingSpace: false,
                      setSelectorButtonAsPrefixIcon: true),
                )),
            SizedBox(height: 25),
            TextField(
              onChanged: (String? value) {
                appreciation.message = value;
              },
              decoration: AppDecore.input("Message"),
            ),
            _formField,
            const SizedBox(height: 20),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: AppDecore.submitButton(context, "Valider", onSubmit))
          ],
        ),
      ),
    );
  }

  String? phoneValidator(String? value) {
    if (value == null) return "Le numéro de téléphone est obligatoire";
    if (!phoneisValide) return "Le numéro de téléphone est invalide";
    return null;
  }

  onPhoneChanged(PhoneNumber? value) {
    phone = value;
  }

  onSubmit() {
    if (appreciation.typeAppreciation != null) {}
  }

  Widget get _formField {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (image != null) displayPdf(image!),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
          child: TextField(
            controller: controller,
            readOnly: true,
            onTap: () async {
              final pickerFile = await ImagePicker.platform
                  .pickImage(source: ImageSource.camera);
              image = pickerFile != null ? File(pickerFile.path) : null;
              controller.text = getFileName(image);
              setState(() {});
            },
            decoration: AppDecore.input("Photo",
                helper: "Cliquer pour prendre une photo",
                prefix: Icons.upload_file),
          ),
        ),
      ],
    );
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

  String getFileName(File? file) {
    String value = file?.path == null ? "" : file!.path.split("/").last;
    return value;
  }

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) return "Valeur requise";
    return null;
  }

  getCard(
      {required IconData icon, required String value, required Color color}) {
    Size size = MediaQuery.of(context).size;

    return ShakeTransition(
      child: Card(
        color: value == appreciation.typeAppreciation ? color : null,
        child: MaterialButton(
          onPressed: () {},
          child: Container(
            width: size.width * 0.33,
            height: size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Icon(
                  icon,
                  size: 32,
                  color: ColorConst.secondary,
                ),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: value != appreciation.typeAppreciation
                        ? ColorConst.text
                        : value == "BON"
                            ? Colors.black
                            : ColorConst.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
