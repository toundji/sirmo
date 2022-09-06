import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../models/notifcation_badge.dart';
import '../../models/user.dart';
import '../../services/user.service.dart';
import '../conducteur/choice-driver.screen.dart';
import '../statistique-conducteur/statistique-conducteur.screen.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:sirmo/models/push_notis.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.debug = false}) : super(key: key);
  static const String routeName = "home";
  static String debugRouteName = "home/debug";

  final bool debug;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class _HomeScreenState extends State<HomeScreen> {
  Compte? compte;
  User? user;

  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;

  @override
  void initState() {
    super.initState();
    user = context.read<UserService>().user;

    late int _totalNotifications;
    PushNotification? _notificationInfo;

    loadMyConducteurList();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });

    context
        .read<CompteService>()
        .loadCompte()
        .then((value) {})
        .onError((error, stackTrace) {
      PersonalAlert.showError(context, message: "êrror");
    });

    checkForInitialMessage();
    registerNotification();
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  loadMyConducteurList() {
    context
        .read<ConducteurService>()
        .loadMyConducteurList(user!.id!)
        .then((value) {})
        .onError((error, stackTrace) {});
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
