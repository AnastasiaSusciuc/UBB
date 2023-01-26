import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> _color = {
  50: const Color.fromRGBO(239, 108, 49, .1),
  100: const Color.fromRGBO(239, 108, 49, .2),
  200: const Color.fromRGBO(239, 108, 49, .3),
  300: const Color.fromRGBO(239, 108, 49, .4),
  400: const Color.fromRGBO(239, 108, 49, .5),
  500: const Color.fromRGBO(239, 108, 49, .6),
  600: const Color.fromRGBO(239, 108, 49, .7),
  700: const Color.fromRGBO(239, 108, 49, .8),
  800: const Color.fromRGBO(239, 108, 49, .9),
  900: const Color.fromRGBO(239, 108, 49, 1.0),
};

class AppColors {
  static final MaterialColor primarySwatch = MaterialColor(0xffec7725, _color);
  static const Color primaryColor = Color(0xffec7725);
  static const Color backgroundColor = Color(0xFFFFFFFF);
}
