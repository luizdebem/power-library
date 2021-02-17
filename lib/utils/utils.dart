import 'package:flutter/material.dart';

// Retornando um swatch com base numa cor (hex) passada no parâmetro.
MaterialColor CreateMaterialColor(Color color) {
  List levels = <double>[.05];
  Map swatch = <int, Color>{};

  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 0; i < 10; i++) {
    levels.add(0.1 * i);
  }

  levels.forEach((level) {
    double factor = 0.5 - level;
    swatch[(level * 1000).round()] = Color.fromRGBO(
        r + ((factor < 0 ? r : (255 - r)) * factor).round(),
        g + ((factor < 0 ? g : (255 - g)) * factor).round(),
        b + ((factor < 0 ? b : (255 - b)) * factor).round(),
        1);
  });

  return MaterialColor(color.value, swatch);
}
