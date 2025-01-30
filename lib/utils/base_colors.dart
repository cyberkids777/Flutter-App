import 'package:flutter/material.dart';

class NoteColors {
  static final List<Color> lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  static Color getColorForIndex(int index) {
    return lightColors[index % lightColors.length];
  }
}

class CustomColors {
  static const purpleColor = Color(0xFF471AA0);
  static const lightPurpleColor = Color(0xFF9747FF);
}