import 'dart:math';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return Color.fromRGBO(r, g, b, 1);
  }
}
