import 'package:flutter/cupertino.dart';

class CurvePathClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    double offset = 100.0;

    double width = size.width;
    double height = size.height;

    Path path = Path();

    //démarrage du déssin

    path.lineTo(0, height - offset / 2);
    path.quadraticBezierTo(width / 2, height, width, height - offset / 2);
    path.lineTo(width, 0);

    path.close();
    return path;
  }
}
