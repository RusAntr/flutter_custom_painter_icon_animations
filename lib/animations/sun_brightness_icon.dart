import 'dart:math';
import 'package:flutter/material.dart';

class SunBrightnessIcon extends StatefulWidget {
  const SunBrightnessIcon({
    Key? key,
    required this.size,
    required this.color,
    required this.strokeWidth,
    required this.alignment,
    required this.duration,
    required this.raysBegin,
    required this.raysEnd,
  }) : assert(
          raysBegin >= 0 && raysBegin >= 0,
        );
  final Size size;
  final Color color;
  final double strokeWidth;
  final Alignment alignment;
  final Duration duration;
  final double raysBegin;
  final double raysEnd;

  @override
  State<SunBrightnessIcon> createState() => _SunBrightnessIconState();
}

class _SunBrightnessIconState extends State<SunBrightnessIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late double begin;

  @override
  void initState() {
    begin = widget.raysBegin;
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    super.initState();
  }

  void backAndForth() async {
    await _animationController.reverse();
    await _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant SunBrightnessIcon oldWidget) {
    if (oldWidget.raysEnd != widget.raysEnd) {
      begin = widget.raysEnd - 2;
      _animationController.isCompleted
          ? backAndForth()
          : _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Animation<double>? _rayLengthTween;
    _rayLengthTween = Tween<double>(begin: begin, end: widget.raysEnd)
        .animate(_animationController)
      ..addListener(() => setState(() => _rayLengthTween!.value));
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
            painter: _SunBrightness(
              offsetOne: _rayLengthTween,
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

class _SunBrightness extends CustomPainter {
  _SunBrightness({
    required this.offsetOne,
    required this.color,
    required this.size,
    required this.strokeWidth,
  });
  Animation<double> offsetOne;
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
    double a = offsetOne.value;
    double radius = center.distance / 3.5;

    /// "O"
    canvas.drawCircle(size.center(Offset.zero), radius, paintFill);

    /// "|" top
    canvas.drawLine(Offset(size.width / 2, size.height * 0.22 - a),
        Offset(size.width / 2, size.height * 0.22), paintFill);

    /// "|" bottom
    canvas.drawLine(Offset(size.width / 2, size.height * 0.78 + a),
        Offset(size.width / 2, size.height * 0.78), paintFill);

    /// "-" right
    canvas.drawLine(Offset(size.width * 0.78 + a, size.height / 2),
        Offset(size.width * 0.78, size.height / 2), paintFill);

    /// "-" left
    canvas.drawLine(Offset(size.width * 0.22 - a, size.height / 2),
        Offset(size.width * 0.22, size.height / 2), paintFill);

    double dxy = center.distance * 0.4;

    /// "/" top
    canvas.drawLine(center + Offset(dxy + a, -dxy - a) * cos(45 * pi / 180),
        center + Offset(dxy, -dxy) * cos(45 * pi / 180), paintFill);

    /// "\" top
    canvas.drawLine(center + Offset(dxy + a, dxy + a) * cos(135 * pi / 180),
        center + Offset(dxy, dxy) * cos(135 * pi / 180), paintFill);

    /// "/" bottom
    canvas.drawLine(center + Offset(dxy + a, -dxy - a) * cos(225 * pi / 180),
        center + Offset(dxy, -dxy) * cos(225 * pi / 180), paintFill);

    /// "\" bottom
    canvas.drawLine(center + Offset(dxy + a, dxy + a) * cos(315 * pi / 180),
        center + Offset(dxy, dxy) * cos(315 * pi / 180), paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
