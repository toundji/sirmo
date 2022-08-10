import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/models/enums/user_role.dart';
import 'package:sirmo/screens/police/police-home.screen.dart';

import 'package:sirmo/screens/welcome/onboarding-first.dart';
import 'package:sirmo/services/amande.service.dart';
import 'package:sirmo/services/arrondissement.service.dart';
import 'package:sirmo/services/commune.service.dart';
import 'package:sirmo/services/compte.service.dart';
import 'package:sirmo/services/departement.service.dart';
import 'package:sirmo/services/licence.service.dart';
import 'package:sirmo/services/police.service.dart';
import 'package:sirmo/services/type-amande.service.dart';
import 'package:sirmo/services/vehicule-service.dart';
import 'package:sirmo/services/user.service.dart';
import 'package:sirmo/services/conducteur.sevice.dart';
import 'package:sirmo/utils/color-const.dart';

import 'models/user.dart';
import 'screens/auth/login.screen.dart';
import 'screens/home/home.screen.dart';
import 'services/appreciation.service.dart';
import 'services/auth.service.dart';
import 'services/constante.service.dart';
import 'utils/app-routes.dart';
import 'utils/network-info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => DepartmentService()),
        ChangeNotifierProvider(create: (context) => CommuneService()),
        ChangeNotifierProvider(create: (context) => ArrondissementService()),
        ChangeNotifierProvider(create: (context) => CompteService()),
        ChangeNotifierProvider(create: (context) => ConducteurService()),
        ChangeNotifierProvider(create: (context) => VehiculeService()),
        ChangeNotifierProvider(create: (context) => AppreciationService()),
        ChangeNotifierProvider(create: (context) => ConstanteService()),
        ChangeNotifierProvider(create: (context) => LicenceService()),
        ChangeNotifierProvider(create: (context) => PoliceService()),
        ChangeNotifierProvider(create: (context) => TypeAmandeService()),
        ChangeNotifierProvider(create: (context) => AmandeService()),
        // ChangeNotifierProvider(create: (context) => AmandeService()),
        // ChangeNotifierProvider(create: (context) => AmandeService()),
      ],
      child: MaterialApp(
          title: 'Zem+',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: ColorConst.primary,
          ),
          home: FutureBuilder<Widget>(
            future: getScreen(context),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!;
              }
              return OnboardingFirst();
            },
          )),
    );
  }

  Future<Widget> getScreen(BuildContext context) async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    if (token == null || token.isEmpty) {
      return OnboardingFirst();
    } else if (Jwt.isExpired(token)) {
      return LoginScreen();
    } else {
      User? user = await context.read<UserService>().profile().then((value) {
        return value;
      }).onError((error, stackTrace) {
        return null;
      });
      if (user == null) {
        return LoginScreen();
      }
      if (UserRole.isConducteur(user)) {
        return await context
            .read<ConducteurService>()
            .myInfo()
            .then<Widget>((value) {
          return PoliceHomeScreen();
        }).onError((error, stackTrace) {
          return HomeScreen();
        });
      }
      if (UserRole.isPolice(user)) {
        return await context
            .read<PoliceService>()
            .myInfo()
            .then<Widget>((value) {
          return PoliceHomeScreen();
        }).onError((error, stackTrace) {
          return HomeScreen();
        });
      }
      return HomeScreen();
    }
  }
}
