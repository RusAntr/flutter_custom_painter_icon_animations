import 'package:flutter/material.dart';
import '../custom_animated_icons.dart';
import 'icon_holder.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Size(MediaQuery.of(context).size.height * 0.15,
        MediaQuery.of(context).size.height * 0.15);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'CustomPainter Interactive Icons',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: _iconsGrid(screenSize, screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  bool _doneClose = false;
  double _bulbValue = 0;
  bool _moonSun = false;
  bool _recordStop = false;
  bool _soundOnOff = false;
  double _sunValue = 0;

  int getAxisCount(double screenWidth) {
    if (screenWidth >= 1100) {
      return 5;
    } else if (screenWidth >= 880) {
      return 4;
    } else if (screenWidth >= 650) {
      return 3;
    } else if (screenWidth >= 450) {
      return 2;
    }
    return 1;
  }

  GridView _iconsGrid(Size screenSize, double screenWidth) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getAxisCount(screenWidth),
      ),
      children: [
        IconHolder(
          label: 'Done - Close',
          children: [
            GestureDetector(
              onTap: () =>
                  setState(() => _doneClose = _doneClose ? false : true),
              child: CustomAnimatedIcons.doneClose(
                size: screenSize,
                strokeWidth: 7,
                color: const Color.fromARGB(255, 193, 192, 192),
                duration: const Duration(milliseconds: 350),
                doneClose: _doneClose,
              ),
            ),
            Checkbox(
              value: _doneClose,
              onChanged: (value) => setState(() => _doneClose = value!),
            ),
          ],
        ),
        IconHolder(
          label: 'Lightbulb Brightness',
          children: [
            CustomAnimatedIcons.lightbulbBrightness(
              size: screenSize,
              strokeWidth: 4,
              color: const Color.fromARGB(255, 193, 192, 192),
              begin: 0,
              end: _bulbValue,
              duration: const Duration(milliseconds: 350),
            ),
            Slider.adaptive(
              min: 0,
              max: 30,
              value: _bulbValue,
              onChanged: (value) => setState(() => _bulbValue = value),
            ),
          ],
        ),
        IconHolder(
          label: 'Moon - Sun',
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _moonSun = _moonSun ? false : true;
                });
              },
              child: CustomAnimatedIcons.moonSun(
                size: screenSize,
                strokeWidth: 4,
                color: Colors.white.withOpacity(0.5),
                duration: const Duration(milliseconds: 300),
                moonSun: _moonSun,
              ),
            ),
            Checkbox(
              value: _moonSun,
              onChanged: (value) => setState(() => _moonSun = value!),
            ),
          ],
        ),
        IconHolder(
          label: 'Record - Stop',
          children: [
            GestureDetector(
              onTap: () =>
                  setState(() => _recordStop = _recordStop ? false : true),
              child: CustomAnimatedIcons.recordStop(
                size: screenSize,
                colorBegin: Colors.white.withOpacity(0.6),
                colorEnd: Colors.red,
                duration: const Duration(milliseconds: 350),
                recordStop: _recordStop,
              ),
            ),
            Checkbox(
              value: _recordStop,
              onChanged: (value) => setState(() => _recordStop = value!),
            ),
          ],
        ),
        IconHolder(
          label: 'Sound On/Off',
          children: [
            GestureDetector(
              onTap: () =>
                  setState(() => _soundOnOff = _soundOnOff ? false : true),
              child: CustomAnimatedIcons.soundOnOff(
                size: screenSize,
                strokeWidth: 7,
                iconColor: Colors.white.withOpacity(0.6),
                lineColor: Colors.white.withOpacity(0.3),
                duration: const Duration(milliseconds: 350),
                onOff: _soundOnOff,
              ),
            ),
            Checkbox(
              value: _soundOnOff,
              onChanged: (value) => setState(() => _soundOnOff = value!),
            ),
          ],
        ),
        IconHolder(
          label: 'Sun Brightness',
          children: [
            CustomAnimatedIcons.sunBrightness(
              size: screenSize,
              strokeWidth: 4,
              color: Colors.white.withOpacity(0.6),
              raysBegin: 0,
              raysEnd: _sunValue,
              duration: const Duration(milliseconds: 350),
            ),
            Slider.adaptive(
              min: 0,
              max: 15,
              value: _sunValue,
              onChanged: (value) => setState(() => _sunValue = value),
            ),
          ],
        ),
      ],
    );
  }
}
