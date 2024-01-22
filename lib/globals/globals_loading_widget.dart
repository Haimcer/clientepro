import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'globals_sizes.dart';
import 'globals_styles.dart';
import 'theme_controller.dart';

class GlobalsLoadingWidget {
  BuildContext context;
  GlobalsLoadingWidget(this.context);

  Widget loagingPageInicio(double sizeHeight, double sizeWidth,
      {String? text}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Stack(
      children: [
        Container(
          height: sizeHeight,
          width: sizeWidth,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 4),
          decoration: BoxDecoration(
            color: globalsThemeVar.iGlobalsColors.tertiaryColor,
          ),
          child: LoadingAnimationWidget.inkDrop(
            color: globalsThemeVar.iGlobalsColors.primaryColor,
            size: GlobalsSizes().marginSize * 2,
          ),
        ),
        text == null
            ? Container(
                height: sizeHeight,
                width: sizeWidth,
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 6),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: GlobalsSizes().marginSize * 3),
                      child: Text('Dicas:',
                          style: TextStyle(
                            color:
                                globalsThemeVar.iGlobalsColors.textColorForte,
                            fontSize: GlobalsSizes().sizeTextMedio,
                            fontWeight: GlobalsStyles(context).negritoFont,
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: GlobalsSizes().marginSize,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText(
                                textAlign: TextAlign.center,
                                duration: const Duration(seconds: 8),
                                alignment: Alignment.center,
                                'Use uma colher de pau ao cozinhar em panelas antiaderentes para evitar arranhões.',
                                textStyle: TextStyle(
                                  color: globalsThemeVar
                                      .iGlobalsColors.textColorForte,
                                  fontSize: GlobalsSizes().sizeTextMedio,
                                  fontWeight:
                                      GlobalsStyles(context).negritoFont,
                                ),
                              ),
                              RotateAnimatedText(
                                textAlign: TextAlign.center,
                                duration: const Duration(seconds: 8),
                                alignment: Alignment.center,
                                'Descasque alho mais facilmente pressionando o dente de alho com a lâmina de uma faca larga.',
                                textStyle: TextStyle(
                                  color: globalsThemeVar
                                      .iGlobalsColors.textColorForte,
                                  fontSize: GlobalsSizes().sizeTextMedio,
                                  fontWeight:
                                      GlobalsStyles(context).negritoFont,
                                ),
                              ),
                              RotateAnimatedText(
                                textAlign: TextAlign.center,
                                duration: const Duration(seconds: 8),
                                alignment: Alignment.center,
                                'Para evitar que a cebola faça você chorar, coloque-a no congelador por alguns minutos antes de cortá-la.',
                                textStyle: TextStyle(
                                  color: globalsThemeVar
                                      .iGlobalsColors.textColorForte,
                                  fontSize: GlobalsSizes().sizeTextMedio,
                                  fontWeight:
                                      GlobalsStyles(context).negritoFont,
                                ),
                              ),
                              RotateAnimatedText(
                                textAlign: TextAlign.center,
                                duration: const Duration(seconds: 8),
                                alignment: Alignment.center,
                                'Ao ferver ovos, adicione um pouco de vinagre à água para ajudar a evitar que se quebrem.',
                                textStyle: TextStyle(
                                  color: globalsThemeVar
                                      .iGlobalsColors.textColorForte,
                                  fontSize: GlobalsSizes().sizeTextMedio,
                                  fontWeight:
                                      GlobalsStyles(context).negritoFont,
                                ),
                              ),
                              RotateAnimatedText(
                                textAlign: TextAlign.center,
                                duration: const Duration(seconds: 8),
                                alignment: Alignment.center,
                                'Use uma peneira para retirar pequenos pedaços de casca de ovo que caíram na tigela ao quebrar os ovos.',
                                textStyle: TextStyle(
                                  color: globalsThemeVar
                                      .iGlobalsColors.textColorForte,
                                  fontSize: GlobalsSizes().sizeTextMedio,
                                  fontWeight:
                                      GlobalsStyles(context).negritoFont,
                                ),
                              ),
                            ],
                            pause: const Duration(milliseconds: 300),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(
                height: sizeHeight,
                width: sizeWidth,
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: globalsThemeVar.iGlobalsColors.textColorMedio,
                        fontSize: GlobalsSizes().sizeTextMedio,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
