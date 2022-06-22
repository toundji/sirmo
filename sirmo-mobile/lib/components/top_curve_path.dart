import 'package:flutter/cupertino.dart';

class TopCurvePathClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    double offset = 80.0;

    double width = size.width;
    double height = size.height;

    Path path = Path();

    //démarrage du déssin

    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.quadraticBezierTo(width / 2, offset, 0, 0);

    path.close();
    return path;
  }
}
