import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/components/app-bar.screen.dart';
import 'package:sirmo/screens/potefeuille/pay_conducteur.screen.dart';
import 'package:sirmo/screens/potefeuille/portefeuille.component.dart';
import 'package:sirmo/screens/statistique-conducteur/evaluate-conduteur.screen.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import 'package:sirmo/utils/app-util.dart';

import '../../components/action-card.dart';
import '../../components/personal_alert.dart';
import '../../models/compte.dart';
import '../../models/push_notis.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../../utils/color-const.dart';
import '../conducteur/choice-driver.screen.dart';
import '../statistique-conducteur/statistique-conducteur.screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Compte? compte;
  User? user;

  FirebaseMessaging? _messaging;
  int _totalNotifications = 0;
  PushNotification? _notificationInfo;

  @override
  void initState() {
    super.initState();
    user = context.read<UserService>().user;
    registerNotification();
    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "êrror");
    });
  }

  loadMyConducteurList() {
    context
        .read<ConducteurService>()
        .loadMyConducteurList(user!.id!)
        .then((value) {})
        .onError((error, stackTrace) {});
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
    return Scaffold(
      appBar: AppAppBar(context,
          leading: const Text(
            "User",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          auto: false),
      // drawer: UserDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  name: "Payer Conducteur",
                  icon: Icons.payment,
                  screen: ChoiceDriverScreen(
                    onSubmit: (conducteur) {
                      AppUtil.changeToScreen(
                          context,
                          PayConducteurScreen(
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
                      AppUtil.changeToScreen(
                          context,
                          EvaluateConducteurScreen(
                            conducteur: conducteur,
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
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
            ],
          ),
          PortefeuilleComponent(),
        ],
      ),
    );
  }
}
