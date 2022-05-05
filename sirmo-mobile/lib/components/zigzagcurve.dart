import 'package:flutter/cupertino.dart';

class ZigZagCurve extends CustomClipper<Path> {
  final double? top;
  final double offset;

  ZigZagCurve({this.top = null, this.offset = 60});
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    if (this.top == null) return getTopPath(size);
    return getButtomPath(size);
  }

  Path getButtomPath(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();

    //démarrage du déssin

    path.moveTo(0, offset);

    path.quadraticBezierTo(width / 4, 2 * offset, width / 2, offset);

    path.quadraticBezierTo(3 * width / 4, 0, width, offset);

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    path.close();
    return path;
  }

  Path getTopPath(Size size) {
    double offset = 130.0;

    double width = size.width;
    double height = size.height;

    Path path = Path();

    //démarrage du déssin

    path.lineTo(0, (height - offset));

    path.quadraticBezierTo(width / 4, height, width / 2, (height - offset));

    path.quadraticBezierTo(
        3 * width / 4, height - (2 * offset), width, (height - offset));
    path.lineTo(width, 0);

    path.close();
    return path;
  }
}
