import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-decore.dart';
import 'package:sirmo/screens/auth/login.screen.dart';
import 'package:sirmo/utils/app-util.dart';

import '../../components/personal_alert.dart';
import '../../services/user.service.dart';
import '../../utils/size-const.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? _confirmPassword;
  String? _oldPassword;
  String? _password;
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppDecore.appBar(context, "Changement de mot de passe"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeConst.padding * 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Ancien mot de passe invalide";
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      _oldPassword = value;
                    },
                    obscureText: true,
                    autocorrect: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: AppDecore.input("Ancien", prefix: Icons.lock),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeConst.padding * 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: passwordValidator,
                    onChanged: (String value) {
                      _password = value;
                    },
                    obscureText: true,
                    autocorrect: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: AppDecore.input(
                      "Nouveau",
                      prefix: Icons.lock,
                    ),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: confirmPasswordValidator,
                  onChanged: onConfirmPasswordChanged,
                  obscureText: true,
                  decoration: AppDecore.input(
                    "Confirmez",
                    prefix: Icons.lock,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AppDecore.button(context, "Valider", onSubmit),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? confirmPasswordValidator(String? value) {
    if (_password != null && value != _password) {
      return "Le deux mots de pass ne sont pas identiques";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    RegExp uperCase = RegExp("[A-Z]+"),
        lowerCase = RegExp("[a-z]+"),
        digit = RegExp("\\d");
    //specialShare = RegExp("[@#%_-.*+/=)(']+");
    if (value!.isEmpty) return "Le mot de pass est obligatoire\n";
    if (value.length < 6) {
      return "Le mot de pass doit contenir au moins 8 caractère\n";
    }
    if (value.length > 10) {
      return "Le mot de pass doit contenir au moins u plus 10 caractère\n";
    }
    if (!uperCase.hasMatch(value)) {
      return 'Le mot de pass doit contenir au moins un caratère majuscule\n ';
    }
    if (!lowerCase.hasMatch(value)) {
      return 'Le mot de pass doit contenir au moins un caratère majuscule\n ';
    }
    if (!digit.hasMatch(value)) {
      return 'Le mot de pass doit contenir au moins un chiffre\n ';
    } // if(specialShare.hasMatch(value))
    //   return 'Le mot de pass doit contenir au moins un caratère spécial\n ';
    return null;
  }

  void onConfirmPasswordChanged(String? value) {
    _confirmPassword = value;
  }

  onSubmit() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context
          .read<UserService>()
          .resetPassword(_oldPassword!, _password!)
          .then((value) {
        PersonalAlert.showSuccess(context,
                message: "Mot de passe changé avec succès")
            .then((value) {
          AppUtil.popAllAndGoTo(context, LoginScreen());
        });
      }).onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "$error");
      });
    }
  }
}
