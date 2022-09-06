import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/models/auth_storage.dart';
import 'package:sirmo/screens/conducteur/conducteur-home.screen.dart';
import 'package:sirmo/utils/app-util.dart';
import 'package:sirmo/utils/network-info.dart';

import '../../models/enums/user_role.dart';
import '../../models/notifcation_badge.dart';
import '../../models/user.dart';
import '../../services/conducteur.sevice.dart';
import '../../services/police.service.dart';
import '../../services/user.service.dart';
import '../home/home.screen.dart';
import '../police/police-home.screen.dart';
import '../welcome/onboarding-first.dart';
import 'login.screen.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:sirmo/models/push_notis.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging? _messaging;

  int _totalNotifications = 0;

  PushNotification? _notificationInfo;

  @override
  void initState() {
    late int _totalNotifications;
    PushNotification? _notificationInfo;

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
    NotificationSettings? settings = await _messaging?.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings?.authorizationStatus == AuthorizationStatus.authorized) {
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

  @override
  Widget build(BuildContext context) {
    getScreen(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Image.asset("assets/logos/logo.png"),
        ),
      ),
    );
  }

  Future getScreen(BuildContext context) async {
    String? storage = await FlutterSecureStorage().read(key: "authStorage");
    log("storage :$storage");
    if (storage == null) {
      return OnboardingFirst();
    }
    AuthStorage auth = AuthStorage.fromJson(storage);
    if (auth.token == null || auth.token!.isEmpty) {
      AppUtil.changeToScreen(context, LoginScreen());
    } else if (Jwt.isExpired(auth.token!)) {
      AppUtil.changeToScreen(context, LoginScreen());
    }
    NetworkInfo.token = auth.token;
    List<String>? roles = auth.roles;

    if (UserRole.isConducteur(User(roles: roles))) {
      await context.read<ConducteurService>().myInfo().then((value) {
        log("Token is $value");
        context.read<UserService>().setUser(value.user!);
        AppUtil.changeToScreen(context, ConducteurHomeScreen());
      }).onError((error, stackTrace) {
        log("$error");
        AppUtil.changeToScreen(context, LoginScreen());
      });
    }
    if (UserRole.isPolice(User(roles: roles))) {
      await context.read<PoliceService>().myInfo().then((value) {
        context.read<UserService>().setUser(value.user!);
        AppUtil.changeToScreen(context, PoliceHomeScreen());
      }).onError((error, stackTrace) {
        log("$error");
        AppUtil.changeToScreen(context, LoginScreen());
      });
    }
    log("It is a single user");
    await context.read<UserService>().profile().then((value) {
      AppUtil.changeToScreen(context, HomeScreen());
    }).onError((error, stackTrace) {
      log("$error", stackTrace: stackTrace);
      AppUtil.changeToScreen(context, LoginScreen());
    });
  }
}
