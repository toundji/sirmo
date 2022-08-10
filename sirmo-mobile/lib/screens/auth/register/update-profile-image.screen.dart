import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirmo/components/personal_alert.dart';
import 'package:sirmo/services/user.service.dart';
import '../../../components/curve_path_clipper.dart';
import '../../home/home.screen.dart';
import '/utils/app-util.dart';
import '/utils/color-const.dart';
import 'package:provider/provider.dart';

import '../../../components/app-decore.dart';

import '../../../services/auth.service.dart';

class UpdateProfileImageScreen extends StatefulWidget {
  UpdateProfileImageScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileImageScreen> createState() =>
      _UpdateProfileImageScreenState();
}

class _UpdateProfileImageScreenState extends State<UpdateProfileImageScreen> {
  String? errorMessage;

  File? profile;

  @override
  void initState() {
    super.initState();
    profile = context.read<AuthService>().profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 120),
        child: ClipPath(
          clipper: CurvePathClipper(),
          child: AppBar(
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: ColorConst.white),
            title: Container(
              child: Image.asset(
                "assets/logos/logo.png",
                width: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppDecore.getTitle("Profile", color: ColorConst.text, scal: 1.2),
            const SizedBox(height: 16),
            _getImage(profile, getImage: _getLogo),
            if (_hasError)
              Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: ColorConst.error),
                  )),
            SizedBox(height: 20),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: AppDecore.submitButton(context, "Valider", onSubmit))
          ],
        ),
      ),
    );
  }

  onSubmit() {
    if (profile != null) {
      PersonalAlert.showLoading(context);
      context.read<AuthService>().setImageProfile(profile);
      context.read<UserService>().updateProfile(profile!).then((value) {
        PersonalAlert.showSuccess(context,
                message: "Photo de profile mise à jour avec succès")
            .then((value) {
          AppUtil.goToScreen(context, HomeScreen());
        });
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
      });
    } else {}
  }

  bool get _hasError => errorMessage != null && errorMessage!.isNotEmpty;

  _getLogo() async {
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profile = File(pickerFile.path);
      setState(() {});
    }
  }

  _getImage(image, {required VoidCallback getImage}) {
    return Card(
      shape: CircleBorder(),
      child: Stack(
        children: [
          MaterialButton(
            onPressed: getImage,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.45,
              child: Stack(
                children: [
                  if (image == null)
                    const Icon(
                      CupertinoIcons.camera,
                      size: 80,
                      color: ColorConst.primary,
                    ),
                  if (image != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                      child: CircleAvatar(
                        child: ClipOval(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: buildEditButton(onPressed: getImage),
          )
        ],
      ),
    );
  }

  buildEditButton({required void Function()? onPressed}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: ColorConst.primary, width: 1.5)),
      child: IconButton(
        icon: Icon(Icons.edit, color: ColorConst.primary),
        onPressed: onPressed,
      ),
    );
  }
}
