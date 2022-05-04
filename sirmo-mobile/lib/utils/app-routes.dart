import 'package:flutter/material.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/auth/login.screen.dart';

import '../screens/home/home.screen.dart';

final Map<String, WidgetBuilder> routes = {
  // Splashscreen.routeName: (BuildContext context) => Splashscreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  UnbuildScreen.routeName: (context) => UnbuildScreen(),
};
