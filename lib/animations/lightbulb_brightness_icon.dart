import 'dart:math';
import 'package:flutter/material.dart';

class LightbulbBrightnessIcon extends StatefulWidget {
  const LightbulbBrightnessIcon({
    Key? key,
    required this.size,
    required this.color,
    required this.strokeWidth,
    required this.alignment,
    required this.duration,
    required this.begin,
    required this.end,
  })  : assert(
          begin >= 0 && end >= 0,
        ),
        super(key: key);
  final Size size;
  final Color color;
  final double strokeWidth;
  final Alignment alignment;
  final Duration duration;
  final double begin;
  final double end;

  @override
  State<LightbulbBrightnessIcon> createState() =>
      _LightbulbBrightnessIconState();
}

class _LightbulbBrightnessIconState extends State<LightbulbBrightnessIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Animation<double>? firstTween;

  late double begin;

  @override
  void initState() {
    begin = widget.begin;
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
  void didUpdateWidget(covariant LightbulbBrightnessIcon oldWidget) {
    if (oldWidget.end != widget.end) {
      begin = widget.end - 2;
      _animationController.isCompleted
          ? backAndForth()
          : _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    firstTween = Tween<double>(begin: begin, end: widget.end)
        .animate(_animationController)
      ..addListener(() => setState(() => firstTween!.value));

    return Container(
      alignment: widget.alignment,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _animationController.isAnimating ? 0.95 : 1,
        child: SizedBox(
          height: widget.size.height,
          width: widget.size.width,
          child: GestureDetector(
            onTap: () {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();
            },
            child: CustomPaint(
              willChange: true,
              isComplex: true,
              painter: _LightbulbBrightness(
                offsetOne: firstTween!,
                size: widget.size,
                strokeWidth: widget.strokeWidth,
                color: widget.color,
              ),
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

class _LightbulbBrightness extends CustomPainter {
  _LightbulbBrightness({
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
    double animVal = offsetOne.value;
    double radius = center.distance / 3.5;
    double dx = center.dx * 0.6;
    double dy = center.dy * 0.7;

    Rect rect = Rect.fromCenter(
        center: center - Offset(0, size.height * 0.17),
        width: size.width / 5,
        height: size.height / 4);
    RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(10));

    /// "Rect"
    canvas.drawRRect(rRect, paintFill);

    /// "O"
    canvas.drawCircle(
        size.center(Offset(0, size.height * 0.02)), radius, paintFill);

    /// "|" bottom
    canvas.drawLine(Offset(size.width / 2, size.height * 0.8 + animVal),
        Offset(size.width / 2, size.height * 0.8), paintFill);

    /// "-" right
    canvas.drawLine(Offset(size.width * 0.8 + animVal, size.height * 0.6),
        Offset(size.width * 0.8, size.height * 0.6), paintFill);

    /// "-" left
    canvas.drawLine(Offset(size.width * 0.20 - animVal, size.height * 0.6),
        Offset(size.width * 0.20, size.height * 0.6), paintFill);

    /// "/" bottom
    canvas.drawLine(
        center + Offset(dx + animVal, -dy - animVal) * cos(225 * pi / 180),
        center + Offset(dx, -dy) * cos(225 * pi / 180),
        paintFill);

    /// "\" bottom
    canvas.drawLine(
        center + Offset(dx + animVal, dy + animVal) * cos(315 * pi / 180),
        center + Offset(dx, dy) * cos(315 * pi / 180),
        paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
