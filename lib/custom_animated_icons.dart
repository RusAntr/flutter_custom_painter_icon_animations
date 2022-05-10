import 'package:flutter/material.dart';
import 'package:flutter_custom_painter_icon_animations/animations/record_stop_icon.dart';
import 'package:flutter_custom_painter_icon_animations/animations/sound_on_off_icon.dart';
import 'package:flutter_custom_painter_icon_animations/animations/sun_brightness_icon.dart';
import 'animations/done_close_icon.dart';
import 'animations/lightbulb_brightness_icon.dart';
import 'animations/moon_sun_icon.dart';

abstract class CustomAnimatedIcons {
  static Widget doneClose({
    Size size = const Size(24, 24),
    double strokeWidth = 2,
    Color color = Colors.black,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 350),
    bool doneClose = false,
  }) =>
      DoneCloseIcon(
        size: size,
        strokeWidth: strokeWidth,
        color: color,
        alignment: alignment,
        duration: duration,
        doneClose: doneClose,
      );

  static Widget lightbulbBrightness({
    Size size = const Size(24, 24),
    double strokeWidth = 1,
    Color color = Colors.black,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 350),
    double begin = 0,
    double? end,
  }) =>
      LightbulbBrightnessIcon(
        size: size,
        strokeWidth: strokeWidth,
        color: color,
        alignment: alignment,
        duration: duration,
        begin: begin,
        end: end ?? size.shortestSide * 0.1,
      );
  static Widget moonSun({
    Size size = const Size(24, 24),
    double strokeWidth = 1,
    Color color = Colors.black,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 350),
    double raysBegin = 0,
    double? raysEnd,
    double? moonBegin,
    double? moonEnd,
    bool moonSun = false,
  }) =>
      MoonSunIcon(
        size: size,
        strokeWidth: strokeWidth,
        color: color,
        alignment: alignment,
        duration: duration,
        raysBegin: raysBegin,
        raysEnd: raysEnd ?? size.shortestSide * 0.1,
        moonBegin: moonBegin ?? size.width * 0.2,
        moonEnd: moonEnd ?? size.center(Offset.zero).dx,
        moonSun: moonSun,
      );

  static Widget recordStop({
    Size size = const Size(24, 24),
    Color colorBegin = Colors.black,
    Color colorEnd = Colors.red,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 350),
    double? roundingBegin,
    double? roundingEnd,
    bool recordStop = false,
  }) =>
      RecordStopIcon(
        size: size,
        colorBegin: colorBegin,
        colorEnd: colorEnd,
        alignment: alignment,
        duration: duration,
        roundingBegin: roundingBegin ?? size.height * 0.1,
        roundingEnd: roundingEnd ?? size.width / 2,
        recordStop: recordStop,
      );

  static Widget soundOnOff({
    Size size = const Size(24, 24),
    double strokeWidth = 2,
    Color iconColor = Colors.black,
    Color? lineColor,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 350),
    bool onOff = false,
  }) =>
      SoundOnOffIcon(
        size: size,
        strokeWidth: strokeWidth,
        iconColor: iconColor,
        lineColor: lineColor ?? iconColor.withOpacity(0.3),
        alignment: alignment,
        duration: duration,
        onOff: onOff,
      );

  static Widget sunBrightness({
    Size size = const Size(24, 24),
    double strokeWidth = 1,
    Color color = Colors.black,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 350),
    double raysBegin = 0,
    double? raysEnd,
  }) =>
      SunBrightnessIcon(
        size: size,
        strokeWidth: strokeWidth,
        color: color,
        alignment: alignment,
        duration: duration,
        raysBegin: raysBegin,
        raysEnd: raysEnd ?? size.shortestSide * 0.1,
      );
}
