import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoundOnOffIcon extends StatefulWidget {
  const SoundOnOffIcon({
    Key? key,
    required this.size,
    required this.iconColor,
    required this.lineColor,
    required this.strokeWidth,
    required this.alignment,
    required this.duration,
    required this.onOff,
  }) : super(key: key);

  final Size size;
  final Color iconColor;
  final Color lineColor;
  final double strokeWidth;
  final Alignment alignment;
  final Duration duration;
  final bool onOff;

  @override
  State<SoundOnOffIcon> createState() => _SoundOnOffIconState();
}

class _SoundOnOffIconState extends State<SoundOnOffIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Animation<double>? _lineTween;

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
    !widget.onOff
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    _lineTween = Tween<double>(begin: 0, end: widget.size.height)
        .animate(_animationController)
      ..addListener(() => setState(() => _lineTween!.value));
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
            painter: _SoundOnOff(
              offsetOne: _lineTween!,
              size: widget.size,
              strokeWidth: widget.strokeWidth,
              iconColor: widget.iconColor,
              lineColor: widget.lineColor,
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

class _SoundOnOff extends CustomPainter {
  _SoundOnOff({
    required this.offsetOne,
    required this.iconColor,
    required this.size,
    required this.strokeWidth,
    required this.lineColor,
  });
  Animation<double> offsetOne;
  Color iconColor;
  Color lineColor;
  Size size;
  double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = this.size;
    Paint iconFill = Paint()..style = PaintingStyle.fill;
    iconFill.color = iconColor;
    iconFill.strokeJoin = StrokeJoin.round;

    Paint lineFill = Paint()..style = PaintingStyle.fill;
    lineFill.strokeCap = StrokeCap.round;
    lineFill.strokeWidth = strokeWidth;
    lineFill.color = offsetOne.value == 0.0
        ? const Color.fromARGB(0, 255, 255, 255)
        : lineColor;

    Path icon = Path();
    icon.moveTo(size.width * 0.29166, size.height * 0.4166);
    icon.lineTo(size.width * 0.29166, size.height * 0.5833);
    icon.cubicTo(
        size.width * 0.29166,
        size.height * 0.60625,
        size.width * 0.3104167,
        size.height * 0.625,
        size.width * 0.33,
        size.height * 0.625);
    icon.lineTo(size.width * 0.45833, size.height * 0.625);
    icon.lineTo(size.width * 0.5954167, size.height * 0.7620833);
    icon.cubicTo(size.width * 0.62166, size.height * 0.7883, size.width * 0.66,
        size.height * 0.7695833, size.width * 0.66, size.height * 0.7325);
    icon.lineTo(size.width * 0.66, size.height * 0.2670833);
    icon.cubicTo(size.width * 0.66, size.height * 0.23, size.width * 0.6216,
        size.height * 0.21125, size.width * 0.5954167, size.height * 0.2375);
    icon.lineTo(size.width * 0.4583, size.height * 0.375);
    icon.lineTo(size.width * 0.33, size.height * 0.375);
    icon.cubicTo(
        size.width * 0.3104167,
        size.height * 0.375,
        size.width * 0.2916,
        size.height * 0.39375,
        size.width * 0.2916,
        size.height * 0.416);
    icon.close();

    canvas.drawPath(icon, iconFill);
    canvas.drawLine(
        Offset(size.width * 0.2 + offsetOne.value * 0.6,
            size.height * 0.2 + offsetOne.value * 0.6),
        Offset(size.width * 0.2, size.height * 0.2),
        lineFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
