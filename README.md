# Flutter Custom Painter Icon Animations

A showcase of working with CustomPainter to create simple animations

 ![gif](https://github.com/RusAntr/flutter_custom_painter_icon_animations/blob/master/assets/example.gif)

## Table of Contents:
* [General Info](#general-info)
* [How to install](#how-to-install)
* [How to use](#how-to-use)

## General info
This project is just a showcase of how to utilize CustomPainter to create simple animations. It wasn't made with an intent to use it in a real app, however you're free to do with it whatever you want :)
Made with [Flutter](https://flutter.dev) & [Dart](https://dart.dev).

## How to install
#### Step 1:

Fork this project:

```
'git clone https://github.com/RusAntr/flutter_custom_painter_icon_animations.git'
```
#### Step 2:

Open the project folder with VS Code and execute the following command to install the dependency package:
```
flutter pub get
```
#### Step 3:

Open the main.dart file in the lib folder, F5 or Ctrl + F5 to run the project.

## How to use:
There are 2 types of icons, those that take a bool to start an animation:
```
CustomAnimatedIcons.doneClose(
              size: Size(50,50),
              strokeWidth: 3,
              color: const Color.fromARGB(255, 193, 192, 192),
              duration: const Duration(milliseconds: 350),
              /// represents 1 of 2 animation statuses - dismissed and completed
              doneClose: false,
            ),
```
and those that take 2 numbers of type double to animate between values:
```
CustomAnimatedIcons.lightbulbBrightness(
              size: Size(50,50),
              strokeWidth: 3,
              color: const Color.fromARGB(255, 193, 192, 192),
              duration: const Duration(milliseconds: 350),
              /// min length of light rays >=0
              begin: 0,
              /// max length of light rays >=0
              end: 30,
            ),
```
If you don't want to create any checkboxes/sliders you can wrap it in a GestureDetector widget:
```
 GestureDetector(
              onTap: () {
                setState(() {
                  _moonSun = _moonSun ? false : true;
                });
              },
              child: CustomAnimatedIcons.moonSun(
                size: Size(50,50),
                strokeWidth: 3,
                color: Colors.white.withOpacity(0.5),
                duration: const Duration(milliseconds: 300),
                moonSun: _moonSun,
              ),
            ),
```

