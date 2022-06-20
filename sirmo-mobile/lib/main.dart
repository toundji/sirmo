import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:sirmo/models/onboarding.dart';
import 'package:sirmo/screens/welcome/onboarding-first.dart';
import 'package:sirmo/services/arrondissement.service.dart';
import 'package:sirmo/services/commune.service.dart';
import 'package:sirmo/services/departement.service.dart';
import 'package:sirmo/services/user.service.dart';
import 'package:sirmo/utils/color-const.dart';

import 'screens/auth/login.screen.dart';
import 'screens/home/home.screen.dart';
import 'services/auth.service.dart';
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
        // ChangeNotifierProvider(create: (context) => DepartmentService()),
      ],
      child: MaterialApp(
        title: 'Sirmo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: ColorConst.primary,
        ),
        routes: routes,
        initialRoute: OnboardingFirst.routeName,
        // onGenerateInitialRoutes: (settings) {
        //   return [MaterialPageRoute(builder: (_) => authGuard)];
        // },
      ),
    );
  }
}

enum AuthState {
  PENDING,
  AUTHENTICATED,
  UNAUTHENTICATED,
  UNSIGNED,
}

StreamBuilder authGuard = StreamBuilder(
  stream: Auth.authState$,
  builder: (context, snapshot) {
    switch (snapshot.data) {
      case AuthState.PENDING:
        return LoginScreen();
      case AuthState.UNSIGNED:
        return LoginScreen();
      case AuthState.UNAUTHENTICATED:
        return LoginScreen();
      case AuthState.AUTHENTICATED:
        context.read<AuthService>().loadUserInfo();
        return HomeScreen();
      default:
        return LoginScreen();
    }
  },
);

class Auth {
  static Stream<AuthState> authState$ =
      Stream<AuthState>.fromFuture(getAuthSate());
}

Future<AuthState> getAuthSate() async {
  String? token = await const FlutterSecureStorage().read(key: "token");
  if (token == null || token.isEmpty) {
    log("token not found");

    return AuthState.UNAUTHENTICATED;
  }
  if (Jwt.isExpired(token)) {
    log("token is expiered");
    const FlutterSecureStorage().delete(key: "token");
    return AuthState.UNAUTHENTICATED;
  }

  NetworkInfo.token = token;
  return AuthState.AUTHENTICATED;
}
