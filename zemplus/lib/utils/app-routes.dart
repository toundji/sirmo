import 'package:flutter/material.dart';
import 'package:sirmo/components/unbuild.screen.dart';
import 'package:sirmo/screens/auth/login.screen.dart';
import 'package:sirmo/screens/welcome/onboarding-first.dart';
import 'package:sirmo/screens/welcome/onboarding-second.dart';
import 'package:sirmo/screens/welcome/onboarding-third.dart';

import '../screens/home/home.screen.dart';

final Map<String, WidgetBuilder> routes = {
  // Splashscreen.routeName: (BuildContext context) => Splashscreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  HomeScreen.debugRouteName: (context) => HomeScreen(debug: true),

  LoginScreen.routeName: (context) => LoginScreen(),
  OnboardingFirst.routeName: (context) => OnboardingFirst(),
  OnboardingSecond.routeName: (context) => OnboardingSecond(),
  OnboardingThird.routeName: (context) => OnboardingThird(),

  UnbuildScreen.routeName: (context) => UnbuildScreen(),
};
