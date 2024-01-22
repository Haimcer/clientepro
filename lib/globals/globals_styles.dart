import 'package:clientepro/globals/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'globals_sizes.dart';

class GlobalsStyles {
  late BuildContext context;
  final GlobalsThemeVar globalsThemeVar;
  late TextStyle styleTitle;
  late TextStyle styleTitleAlternative;
  late TextStyle styleSubtitle;
  late TextStyle styleSubtitleInverse;
  late TextStyle styleMedio;
  late TextStyle styleMenor;
  late dynamic negritoFont;

  GlobalsStyles(this.context)
      : globalsThemeVar = Provider.of<GlobalsThemeVar>(context, listen: false) {
    styleTitle = TextStyle(
        color: globalsThemeVar.iGlobalsColors.primaryColor,
        fontSize: GlobalsSizes().sizeTitulo);
    styleTitleAlternative = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeTitulo);
    styleSubtitle = TextStyle(
        fontWeight: FontWeight.w500,
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeSubtitulo);
    styleMedio = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeTextMedio);
    styleMenor = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeText);
    negritoFont = FontWeight.w500;
    styleSubtitleInverse = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
        fontSize: GlobalsSizes().sizeSubtitulo);
  }
}
