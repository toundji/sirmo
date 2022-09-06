import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 992 &&
      MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 992;

  static responsiveValue(context, {mobile, tablet, desktop}) {
    final Size _size = MediaQuery.of(context).size;
    if (Responsive.isMobile(context)) return mobile;
    if (Responsive.isTablet(context)) return tablet ?? mobile;
    return desktop ?? mobile;
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if (_size.width >= 1100) return desktop;
    if (_size.width >= 850 && tablet != null) return tablet!;
    return mobile;
  }
}
