import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/models/conducteur.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ChoiceDriverScreen extends StatefulWidget {
  ChoiceDriverScreen({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(Conducteur? conducteur) onSubmit;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Choisir un conducteur"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          _buildControlButtons(),
          _buildQrView(context),
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

  Widget _buildQrView(context) {
    return QRView(
        key: qeKey,
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 20,
          borderColor: Theme.of(context).primaryColor,
          overlayColor: Colors.green,
          cutOutSize: MediaQuery.of(context).size.width * 0.5,
        ),
        onQRViewCreated: onQRViewCreated);
  }

  void onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      this.qrViewController = qrViewController;
    });
    qrViewController.scannedDataStream.listen((barcode) async {
      qrViewController.stopCamera();
      // await onScan(barcode.code);
    });
  }

  Widget _buildControlButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(
          vertical: 16, horizontal: MediaQuery.of(context).size.width * 0.2),
      decoration: BoxDecoration(
          color: Colors.green[200], borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async {
                qrViewController!.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder(
                future: qrViewController == null
                    ? null
                    : qrViewController!.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Icon(snapshot.data == null
                        ? Icons.flash_on
                        : Icons.flash_off);
                  }
                  return Icon(Icons.flash_off);
                },
              )),
          IconButton(
              onPressed: () async {
                qrViewController!.flipCamera();
              },
              icon: FutureBuilder(
                  future: qrViewController == null
                      ? null
                      : qrViewController!.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) return Icon(Icons.switch_camera);
                    return Icon(Icons.switch_camera);
                  }))
        ],
      ),
    );
  }

  onSubmit() {
    widget.onSubmit(null);
  }
}
