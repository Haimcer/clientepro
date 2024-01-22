import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../globals/globals_local_storage.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/globals_styles.dart';
import '../../globals/globals_widgets.dart';
import '../../globals/theme_controller.dart';
import '../home/page_home_principal.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  IntroductionState createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _togglePageViewedStatus() async {
    await GlobalsLocalStorage().markPageAsViewed("introduction");
  }

  void _onIntroEnd(context) {
    _togglePageViewedStatus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => PageHomePrincipal()),
    );
  }

  Widget _buildImage(String assetName, double width) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
        margin: EdgeInsets.all(GlobalsSizes().marginSize),
        padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
        // width: width,
        decoration: BoxDecoration(
          boxShadow: [
            GlobalsWidgets(context).sombreadoBoxShadow(),
          ],
          borderRadius:
              BorderRadius.all(Radius.circular(GlobalsSizes().borderSize)),
          color: globalsThemeVar.iGlobalsColors.tertiaryColor,
        ),
        child: Image.asset(assetName, width: width));
  }

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    double widthSize = MediaQuery.of(context).size.width;
    final bodyStyle = TextStyle(
        fontSize: GlobalsSizes().sizeTextMedio /** 1.2*/,
        color: globalsThemeVar.iGlobalsColors.textColorForte);

    final pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: GlobalsSizes().sizeTitulo,
            fontWeight: GlobalsStyles(context).negritoFont,
            color: globalsThemeVar.iGlobalsColors.primaryColor),
        bodyTextStyle: bodyStyle,
        //bodyPadding: EdgeInsets.all(GlobalsSizes().marginSize),
        pageColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        //imagePadding: EdgeInsets.only(top: GlobalsSizes().marginSize*4),
        imageAlignment: Alignment.center,
        bodyAlignment: Alignment.bottomCenter);

    return IntroductionScreen(
      key: introKey,

      globalBackgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      // allowImplicitScrolling: true,
      // autoScrollDuration: 2000000,
      // infiniteAutoScroll: true,
      /*globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: GlobalsSizes().marginSize,
                right: GlobalsSizes().marginSize),
            child: _buildImage('assets/images/app/logo-512-lar-transp.png', 80),
          ),
        ),
      ),*/
      /*globalHeader: const SizedBox(
        width: double.infinity,
        height: 30,
      ),*/
      /*globalFooter: const SizedBox(
        width: double.infinity,
        height: 30,
      ),*/
      pages: [
        PageViewModel(
          reverse: true,
          image: _buildImage(
              'assets/images/introduction/intro_tela1.png', widthSize),
          title: "Bem-Vindo ao ClientePRO!",
          body:
              "Com o ClientePRO você encontra receitas Incríveis e pode gerar novas receitas com os INGREDIENTES que tiver em CASA.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          reverse: true,
          title: "Ingredientes Limitados, Receitas Ilimitadas",
          body: "Receitas deliciosas estão a um toque de distância!",
          image: _buildImage(
              'assets/images/introduction/intro_tela2.png', widthSize),
          decoration: pageDecoration,
        ),
        PageViewModel(
          reverse: true,
          title: "Cozinhe, Compartilhe, Conecte-se",
          body:
              "Siga outros cozinheiros apaixonados para descobrir suas criações únicas, compartilhe suas próprias receitas para conquistar seguidores e celebrar juntos a arte de cozinhar.",
          image: _buildImage(
              'assets/images/introduction/intro_tela3.png', widthSize),
          decoration: pageDecoration,
        ),
        PageViewModel(
          reverse: true,
          title: "Vamos Lá?",
          body:
              "Agora, é hora de transformar sua jornada na cozinha em algo ainda mais especial. Vamos lá, a próxima deliciosa aventura está apenas a um toque de distância!",
          image: _buildImage(
              'assets/images/app/logo-512-lar-transp.png', widthSize / 2),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,

      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Icon(Icons.arrow_back_ios_new_rounded,
          color: globalsThemeVar.iGlobalsColors.primaryColor),
      /*skip: Text('Pular',
          style: TextStyle(
              fontWeight: GlobalsStyles().negritoFont,
              color: globalsThemeVar.iGlobalsColors.primaryColor)),*/
      next: Icon(Icons.arrow_forward_ios_rounded,
          color: globalsThemeVar.iGlobalsColors.primaryColor),
      done: Text('Finalizar',
          style: TextStyle(
              fontWeight: GlobalsStyles(context).negritoFont,
              color: globalsThemeVar.iGlobalsColors.primaryColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(GlobalsSizes().marginSize),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        activeColor: globalsThemeVar.iGlobalsColors.primaryColor,
        size: const Size(10.0, 10.0),
        color: globalsThemeVar.iGlobalsColors.textColorFraco,
        activeSize: const Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(GlobalsSizes().borderSize * 1.8)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: globalsThemeVar.iGlobalsColors.tertiaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(GlobalsSizes().borderSize)),
        ),
      ),
    );
  }
}
