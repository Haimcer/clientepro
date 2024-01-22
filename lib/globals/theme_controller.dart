import 'package:flutter/material.dart';

import 'themes/globals_colors_dark.dart';
import 'themes/globals_colors_light.dart';
import 'themes/iglobals_colors.dart';

class GlobalsThemeVar extends ChangeNotifier {
  ThemeMode currentThemeMode = ThemeMode.light;

  late IGlobalsColors iGlobalsColors = GlobalsColorsLight();

  void setIGlobalsColors() {
    iGlobalsColors = currentThemeMode == ThemeMode.light
        ? GlobalsColorsLight()
        : GlobalsColorsDark();

    notifyListeners();
  }
}
