import 'package:flutter/material.dart';

class DoneCloseIcon extends StatefulWidget {
  const DoneCloseIcon({
    Key? key,
    required this.size,
    required this.color,
    required this.strokeWidth,
    required this.alignment,
    required this.duration,
    required this.doneClose,
  }) : super(key: key);
  final Size size;
  final Color color;
  final double strokeWidth;
  final Alignment alignment;
  final Duration duration;
  final bool doneClose;

  @override
  State<DoneCloseIcon> createState() => _DoneCloseIconState();
}

class _DoneCloseIconState extends State<DoneCloseIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Animation<Offset>? _firstTween;
  Animation<Offset>? _secondTween;
  Animation<Offset>? _lineOne;
  Animation<Offset>? _lineTwo;

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
    !widget.doneClose
        ? _animationController.reverse()
        : _animationController.forward();
  }

  void _initAnim() {
    _firstTween = Tween<Offset>(
            begin: Offset(widget.size.width * 0.8, widget.size.height * 0.8),
            end: Offset(widget.size.width * 0.2, widget.size.height * 0.8))
        .animate(_animationController)
      ..addListener(() => setState(() => _firstTween!.value));

    _secondTween = Tween<Offset>(
            begin: Offset(widget.size.width * 0.2, widget.size.height * 0.2),
            end: Offset(widget.size.width * 0.8, widget.size.height * 0.2))
        .animate(_animationController)
      ..addListener(() => setState(() => _secondTween!.value));

    _lineOne = Tween<Offset>(
            begin: Offset(widget.size.width * 0.2, widget.size.height * 0.8),
            end: Offset(widget.size.width * 0.01, widget.size.height * 0.6))
        .animate(_animationController)
      ..addListener(() => setState(() => _lineOne!.value));

    _lineTwo = Tween<Offset>(
            begin: Offset(widget.size.width * 0.2, widget.size.height * 0.8),
            end: Offset(widget.size.width * 0.2, widget.size.height * 0.8))
        .animate(_animationController)
      ..addListener(() => setState(() => _lineTwo!.value));
    _animate();
  }

  @override
  Widget build(BuildContext context) {
    _initAnim();
    return Container(
      alignment: widget.alignment,
      child: AnimatedScale(
        duration: widget.duration,
        scale: _animationController.isAnimating ? 0.9 : 1,
        child: SizedBox(
          height: widget.size.height,
          width: widget.size.width,
          child: CustomPaint(
            willChange: true,
            isComplex: true,
            painter: CloseToDone(
              offsetOne: _firstTween!.value,
              offsetTwo: _secondTween!.value,
              lineOneOffset: _lineOne!.value,
              lineTwoOffset: _lineTwo!.value,
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

class CloseToDone extends CustomPainter {
  CloseToDone({
    required this.offsetOne,
    required this.offsetTwo,
    required this.lineOneOffset,
    required this.lineTwoOffset,
    required this.color,
    required this.size,
    required this.strokeWidth,
  });
  Offset offsetOne;
  Offset offsetTwo;
  Offset lineOneOffset;
  Offset lineTwoOffset;
  Color color;
  Size size;
  double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = this.size;
    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = color;
    paintFill.strokeCap = StrokeCap.round;
    paintFill.strokeWidth = strokeWidth;

    /// "/"
    canvas.drawLine(offsetOne, offsetTwo, paintFill);

    /// "\"
    canvas.drawLine(Offset(size.width * 0.2, size.height * 0.8),
        Offset(size.width * 0.8, size.height * 0.2), paintFill);

    /// "\" small
    canvas.drawLine(lineOneOffset, lineTwoOffset, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
