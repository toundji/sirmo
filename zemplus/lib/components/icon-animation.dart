import 'package:flutter/material.dart';

class IconAnimation extends StatefulWidget {
  const IconAnimation({Key? key}) : super(key: key);

  @override
  State<IconAnimation> createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = new AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..repeat(reverse: true);
  late Animation<Offset> _animationVartical =
      Tween(begin: Offset.zero, end: Offset(0.1, 0.9)).animate(_controller);
  late Animation<Offset> _animationHorizontal =
      Tween(begin: Offset(-0.5, 0.0), end: Offset(0.5, 0.0))
          .animate(_controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: _animationVartical,
          child: Icon(Icons.keyboard_capslock, size: 64),
        ),
        SizedBox(
          height: 100,
        ),
        SlideTransition(
            position: _animationHorizontal,
            child: Icon(Icons.arrow_left_sharp)),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
