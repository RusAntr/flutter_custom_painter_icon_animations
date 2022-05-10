import 'package:flutter/material.dart';

class RecordStopIcon extends StatefulWidget {
  const RecordStopIcon({
    Key? key,
    required this.size,
    required this.colorBegin,
    required this.colorEnd,
    required this.alignment,
    required this.duration,
    required this.roundingBegin,
    required this.roundingEnd,
    required this.recordStop,
  }) : assert(
          roundingBegin >= 0,
          roundingEnd >= 0,
        );
  final Size size;
  final Color colorBegin;
  final Color colorEnd;
  final Alignment alignment;
  final Duration duration;
  final double roundingBegin;
  final double roundingEnd;
  final bool recordStop;

  @override
  State<RecordStopIcon> createState() => _RecordStopIconState();
}

class _RecordStopIconState extends State<RecordStopIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Animation<Color?>? colorTween;
  Animation<double>? roundingTween;

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
    !widget.recordStop
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    roundingTween =
        Tween<double>(begin: widget.roundingBegin, end: widget.roundingEnd)
            .animate(_animationController)
          ..addListener(() => setState(() => roundingTween!.value));
    colorTween = ColorTween(begin: widget.colorBegin, end: widget.colorEnd)
        .animate(_animationController)
      ..addListener(() => setState(() => colorTween!.value));
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
            painter: _RecordStop(
              offsetOne: roundingTween!,
              offsetTwo: colorTween,
              size: widget.size,
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

class _RecordStop extends CustomPainter {
  _RecordStop({
    required this.offsetOne,
    required this.size,
    required this.offsetTwo,
  });
  Animation<double> offsetOne;
  Animation<Color?>? offsetTwo;

  Size size;
  @override
  void paint(Canvas canvas, Size size) {
    size = this.size;
    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = offsetTwo!.value!;

    paintFill.strokeCap = StrokeCap.round;
    paintFill.strokeJoin = StrokeJoin.round;

    var center = size.center(Offset.zero);
    Rect r = Rect.fromCenter(
        center: center, width: size.width / 2, height: size.height / 2);
    RRect rr = RRect.fromRectAndRadius(r, Radius.circular(offsetOne.value));
    Path knife = Path();

    knife.addRRect(rr);

    canvas.drawPath(knife, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
