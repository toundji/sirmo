import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/screens/auth/splash.screen.dart';

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

import 'services/appreciation.service.dart';
import 'services/auth.service.dart';
import 'services/constante.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          home: SplashScreen()),
    );
  }
}
