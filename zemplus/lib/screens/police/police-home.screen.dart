import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/action-card.dart';
import 'package:sirmo/components/app-bar.screen.dart';
import 'package:sirmo/screens/amande_type/selecte_amande_type.screen.dart';
import 'package:sirmo/screens/amandes/amande.screen.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/push_notis.dart';
import '../../services/user.service.dart';
import '../../utils/app-util.dart';
import '../../utils/color-const.dart';
import '../conducteur/choice-driver.screen.dart';
import '../statistique-conducteur/evaluate-conduteur.screen.dart';
import '../statistique-conducteur/statistique-conducteur.screen.dart';
import '../vehicule/vehicule_info.screen.dart';

class PoliceHomeScreen extends StatefulWidget {
  PoliceHomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<PoliceHomeScreen> createState() => _PoliceHomeScreenState();
}

class _PoliceHomeScreenState extends State<PoliceHomeScreen> {
  dynamic header;
  Compte? compte;

  FirebaseMessaging? _messaging;
  @override
  void initState() {
    super.initState();
    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "êrror");
    });
  }

  void sowSnackBarr(PushNotification notis) {
    var snackBar = SnackBar(
      backgroundColor: ColorConst.secondary,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(notis.title ?? ""),
        Text(notis.body ?? ""),
      ]),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings? settings = await _messaging?.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    log(' permission cheking ...');

    if (settings?.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        sowSnackBarr(notification);
      });
    } else {
      log('User declined or has not accepted permission');
    }
  }

  login() {
    context
        .read<UserService>()
        .login("+22994851785", "Baba@1234")
        .then((value) {
      setState(() {
        header = NetworkInfo.headers;
      });
      context
          .read<CompteService>()
          .loadCompte()
          .then((value) {})
          .onError((error, stackTrace) {
        PersonalAlert.showError(context, message: "êrror");
      });
      setState(() {});
    }).onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "$error").then((value) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(context,
          leading: const Text(
            "Police",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          auto: false),
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  name: "Amander",
                  icon: Icons.edit,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          SelecteAmandeTypeScreen(
                            conducteur: conducteur,
                          ));
                    },
                  ),
                ),
                ActionCard(
                  name: "Amandes",
                  icon: Icons.remove_red_eye,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          AmandeScreen(
                            conducteur: conducteur,
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionCard(
                name: "Véhicule",
                icon: CupertinoIcons.eye,
                screen: ChoiceDriverScreen(
                  onSubmit: (conducteur) {
                    AppUtil.changeToScreen(context,
                        VehiculeInfoScreen(vehicule: conducteur.vehicule!));
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionCard(
                name: "Statistique du Conducteur",
                icon: CupertinoIcons.eye,
                screen: ChoiceDriverScreen(
                  onSubmit: (conducteur) {
                    AppUtil.changeToScreen(
                        context,
                        StatistiqueConducteurScreen(
                          conducteur: conducteur,
                        ));
                  },
                ),
              ),
              ActionCard(
                name: "Evaluer Conducteur",
                icon: Icons.edit,
                screen: ChoiceDriverScreen(
                  onSubmit: (conducteur) {
                    AppUtil.changeToScreen(context,
                        EvaluateConducteurScreen(conducteur: conducteur));
                  },
                ),
              ),
            ],
          ),

          // portefeuile,
        ],
      ),
      // drawer: PoliceDrawer(),
    );
  }
}
