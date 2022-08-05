import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/components/personal_alert.dart';
import 'package:sirmo/models/conducteur.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import 'package:sirmo/utils/app-util.dart';
import 'package:sirmo/utils/color-const.dart';

class ChoiceDriverScreen extends StatefulWidget {
  ChoiceDriverScreen({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(Conducteur conducteur) onSubmit;

  @override
  State<ChoiceDriverScreen> createState() => _ChoiceDriverScreenState();
}

class _ChoiceDriverScreenState extends State<ChoiceDriverScreen> {
  TextEditingController controller = TextEditingController();
  File? file;
  String error = "";
  int errorNr = 0;
  final qeKey = GlobalKey(debugLabel: "QR");
  QRViewController? qrViewController;
  GlobalKey<FormFieldState> field = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Choisir un conducteur"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(children: [
          const Text("Scanner le qr code du conducteur ou entrez son nip"),
          _buildControlButtons(),
          _buildQrView(context),
          const SizedBox(height: 20),
          TextFormField(
            key: field,
            onChanged: (String? value) {},
            validator: (value) {
              if (value == null) {
                return "une valeur est requise";
              } else if (value.length != 8) {
                return "cip invalide";
              }
              return null;
            },
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

  Widget _buildQrView(context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: QRView(
          key: qeKey,
          overlay: QrScannerOverlayShape(
            borderRadius: 10,
            borderWidth: 10,
            borderLength: 20,
            borderColor: Theme.of(context).primaryColor,
            overlayColor: Colors.green,
            cutOutSize: MediaQuery.of(context).size.width * 0.8,
          ),
          onQRViewCreated: onQRViewCreated),
    );
  }

  void onQRViewCreated(QRViewController qrViewController) {
    // log("qr view is created");
    setState(() {
      this.qrViewController = qrViewController;
    });
    qrViewController.scannedDataStream.listen((barcode) async {
      if (barcode.code != null) {
        qrViewController.stopCamera();
        await submit(barcode.code!.trim());
      }
    });
  }

  submit(String nic) async {
    PersonalAlert.showLoading(context);
    await context
        .read<ConducteurService>()
        .loadConducteurByCip(nic)
        .then((value) {
      PersonalAlert.showSuccess(context, message: "Code scanner avec succès")
          .then((v) {
        widget.onSubmit(value!);
      });
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error").then((value) {
        qrViewController?.resumeCamera();
      });
    });
  }

  onSubmit() async {
    if (field.currentState != null && field.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      await context
          .read<ConducteurService>()
          .loadConducteurByCip(controller.text)
          .then((value) {
        PersonalAlert.showSuccess(context, message: "Code scanner avec succès")
            .then((v) {
          widget.onSubmit(value!);
        });
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error").then((value) {
          qrViewController?.resumeCamera();
        });
      });
    }
  }

  Widget _buildControlButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(
          vertical: 16, horizontal: MediaQuery.of(context).size.width * 0.2),
      decoration: BoxDecoration(
          color: ColorConst.primary, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async {
                qrViewController?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder(
                future: qrViewController?.getFlashStatus(),
                builder: (context, AsyncSnapshot<bool?> snapshot) {
                  if (snapshot.hasData) {
                    return Icon(
                      snapshot.data == null || !snapshot.data!
                          ? Icons.flash_on
                          : Icons.flash_off,
                      color: ColorConst.white,
                    );
                  }
                  return const Icon(
                    Icons.flash_off,
                    color: ColorConst.white,
                  );
                },
              )),
          IconButton(
              onPressed: () async {
                qrViewController?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                  future: qrViewController?.getCameraInfo(),
                  builder: (context, AsyncSnapshot<CameraFacing?> snapshot) {
                    if (snapshot.hasData) {
                      return Icon(
                        snapshot.data == null ||
                                snapshot.data == CameraFacing.back
                            ? Icons.switch_camera
                            : Icons.camera,
                        color: ColorConst.white,
                      );
                    }
                    return Icon(
                      Icons.flash_off,
                      color: ColorConst.white,
                    );
                  }))
        ],
      ),
    );
  }
}
