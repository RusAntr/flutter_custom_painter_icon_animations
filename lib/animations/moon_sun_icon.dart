import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoonSunIcon extends StatefulWidget {
  const MoonSunIcon({
    Key? key,
    required this.size,
    required this.color,
    required this.strokeWidth,
    required this.alignment,
    required this.duration,
    required this.raysBegin,
    required this.raysEnd,
    required this.moonBegin,
    required this.moonEnd,
    required this.moonSun,
  })  : assert(
          raysBegin >= 0,
          raysEnd >= 0,
        ),
        super(key: key);
  final Size size;
  final Color color;
  final double strokeWidth;
  final Alignment alignment;
  final Duration duration;
  final double raysBegin;
  final double raysEnd;
  final double moonBegin;
  final double moonEnd;
  final bool moonSun;

  @override
  State<MoonSunIcon> createState() => _MoonSunIconState();
}

class _MoonSunIconState extends State<MoonSunIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    super.initState();
  }

  void _animate() {
    !widget.moonSun
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double>? moonTween;
    Animation<double>? raysTween;

    moonTween = Tween<double>(begin: widget.moonBegin, end: widget.moonEnd)
        .animate(_animationController)
      ..addListener(() => setState(() => moonTween!.value));

    raysTween = Tween<double>(begin: widget.raysBegin, end: widget.raysEnd)
        .animate(_animationController)
      ..addListener(() => setState(() => raysTween!.value));

    _animate();

    return Container(
      alignment: widget.alignment,
      child: AnimatedScale(
        duration: widget.duration,
        scale: _animationController.isAnimating ? 0.95 : 1,
        child: SizedBox(
          height: widget.size.height,
          width: widget.size.width,
          child: CustomPaint(
            willChange: true,
            isComplex: true,
            painter: _MoonSun(
              offsetOne: moonTween,
              offsetTwo: raysTween,
              size: widget.size,
              strokeWidth: widget.strokeWidth,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _MoonSun extends CustomPainter {
  _MoonSun({
    required this.offsetOne,
    required this.offsetTwo,
    required this.color,
    required this.size,
    required this.strokeWidth,
  });
  Animation<double> offsetOne;
  Animation<double> offsetTwo;
  Color color;
  Size size;
  double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = this.size;
    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = color;
    paintFill.strokeCap = StrokeCap.round;
    paintFill.strokeJoin = StrokeJoin.round;
    paintFill.strokeWidth = strokeWidth;
    var center = size.center(Offset.zero);
    double radius = center.distance / 3;

    Path path1 = Path();
    path1.addOval(Rect.fromCircle(center: center, radius: radius));
    path1.close();

    Path path2 = Path();
    path2.addOval(Rect.fromCircle(
        center: center - (Offset(offsetOne.value, size.height * 0.03)),
        radius: radius));
    path2.close();

    /// Moon/Sun
    canvas.drawPath(
      Path.combine(PathOperation.difference, path1, path2),
      paintFill,
    );

    var animVal = offsetTwo.value;
    Paint paintRays = Paint()..style = PaintingStyle.fill;
    paintRays.color =
        offsetTwo.value == 0 ? const Color.fromARGB(0, 255, 255, 255) : color;

    paintRays.strokeWidth = strokeWidth;
    paintRays.strokeCap = StrokeCap.round;

    /// "|" top
    canvas.drawLine(Offset(size.width / 2, size.height * 0.2 - animVal),
        Offset(size.width / 2, size.height * 0.18), paintRays);

    /// "|" bottom
    canvas.drawLine(Offset(size.width / 2, size.height * 0.8 + animVal),
        Offset(size.width / 2, size.height * 0.82), paintRays);

    /// "-" right
    canvas.drawLine(Offset(size.width * 0.8 + animVal, size.height / 2),
        Offset(size.width * 0.82, size.height / 2), paintRays);

    /// "-" left
    canvas.drawLine(Offset(size.width * 0.2 - animVal, size.height / 2),
        Offset(size.width * 0.18, size.height / 2), paintRays);

    double dxy = center.distance * 0.46;

    /// "/" top
    canvas.drawLine(
        center + Offset(dxy + animVal, -dxy - animVal) * cos(45 * pi / 180),
        center + Offset(dxy, -dxy) * cos(45 * pi / 180),
        paintRays);

    /// "\" top
    canvas.drawLine(
        center + Offset(dxy + animVal, dxy + animVal) * cos(135 * pi / 180),
        center + Offset(dxy, dxy) * cos(135 * pi / 180),
        paintRays);

    /// "/" bottom
    canvas.drawLine(
        center + Offset(dxy + animVal, -dxy - animVal) * cos(225 * pi / 180),
        center + Offset(dxy, -dxy) * cos(225 * pi / 180),
        paintRays);

    /// "\" bottom
    canvas.drawLine(
        center + Offset(dxy + animVal, dxy + animVal) * cos(315 * pi / 180),
        center + Offset(dxy, dxy) * cos(315 * pi / 180),
        paintRays);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
