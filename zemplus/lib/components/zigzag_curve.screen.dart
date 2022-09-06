import 'package:flutter/material.dart';
import 'package:sirmo/components/zigzagcurve.dart';

import 'curve_path_clipper.dart';

class ZigZagCureScreen extends StatelessWidget {
  const ZigZagCureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClipPath(
      clipper: CurvePathClipper(),
      child: Container(
        height: 300,
        color: Colors.black,
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            clipper: ZigZagCurve(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,
              color: Colors.green,
            ),
          ),
          ClipPath(
            clipper: ZigZagCurve(top: 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
