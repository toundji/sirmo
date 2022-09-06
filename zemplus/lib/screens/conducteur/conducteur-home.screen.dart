import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/models/conducteur.dart';
import 'package:sirmo/screens/appreciation/appreciation.screen.dart';
import 'package:sirmo/screens/statistique-conducteur/statistique-conducteur.screen.dart';
import 'package:sirmo/screens/vehicule/create-vehicule.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import 'package:sirmo/utils/color-const.dart';

import '../../components/action-card.dart';
import '../../components/app-bar.screen.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/notifcation_badge.dart';
import '../../models/push_notis.dart';
import '../licence/licence-create.screen.dart';
import '../vehicule/vehicule_info.screen.dart';

class ConducteurHomeScreen extends StatefulWidget {
  ConducteurHomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<ConducteurHomeScreen> createState() => _ConducteurHomeScreenState();
}

class _ConducteurHomeScreenState extends State<ConducteurHomeScreen> {
  dynamic header;
  Compte? compte;
  Conducteur? conducteur;

  FirebaseMessaging? _messaging;
  int _totalNotifications = 0;
  PushNotification? _notificationInfo;

  @override
  void initState() {
    super.initState();

    registerNotification();

    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "error");
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

  @override
  Widget build(BuildContext context) {
    conducteur = context.read<ConducteurService>().conducteur;

    return Scaffold(
      appBar: AppAppBar(context,
          auto: false, leading: const Text("Conducteur", maxLines: 1)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  name: "vehicule",
                  icon: Icons.motorcycle,
                  screen: conducteur?.vehicule == null
                      ? vehiculeCreateScreen()
                      : VehiculeInfoScreen(vehicule: conducteur!.vehicule!),
                ),
                ActionCard(
                    name: "Licence",
                    icon: Icons.edit,
                    screen: LicenceCreateScreen()),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionCard(
                name: "Appreciation",
                icon: Icons.info,
                screen: AppreciationScreen(
                  conducteur: conducteur!,
                ),
              ),
              ActionCard(
                name: "Satistique",
                icon: CupertinoIcons.star,
                screen: StatistiqueConducteurScreen(
                  conducteur: conducteur!,
                ),
              ),
            ],
          ),
          PortefeuilleComponent(),
        ],
      ),
      // drawer: ConducteurDrawer(),
    );
  }
}
