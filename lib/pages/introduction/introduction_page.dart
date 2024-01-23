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
import '../../login/login_page.dart';

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
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  Widget _buildImage(String assetName, double width) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
        margin: EdgeInsets.all(GlobalsSizes().marginSize),
        padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
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
        pageColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        imageAlignment: Alignment.center,
        bodyAlignment: Alignment.bottomCenter);

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      pages: [
        PageViewModel(
          reverse: true,
          image: _buildImage('assets/introduction/intro_tela1.png', widthSize),
          title: "Bem-Vindo ao ClientePRO!",
          body:
              "Aqui, você gerencia seus clientes e seus interesses, como video games, séries, etc... Descubra novas maneiras de se conectar com seus clientes e ofereça experiências personalizadas.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          reverse: true,
          title: "Clientes e Interesses Ilimitados",
          body:
              "Explore receitas incríveis para manter seus clientes engajados. Encontre a combinação perfeita entre seus serviços e os interesses deles.",
          image: _buildImage('assets/introduction/intro_tela2.png', widthSize),
          decoration: pageDecoration,
        ),
        PageViewModel(
          reverse: true,
          title: "Conecte-se através dos Interesses",
          body:
              "Conecte-se com seus clientes através de seus interesses. Descubra o poder de um gerenciador que entende as preferências individuais, como video games e séries. Transforme suas interações em algo único!",
          image: _buildImage('assets/introduction/intro_tela3.png', widthSize),
          decoration: pageDecoration,
        ),
        PageViewModel(
          reverse: true,
          title: "Vamos Começar?",
          body:
              "Agora é a hora de transformar a gestão de clientes em algo ainda mais especial. Vamos lá! A próxima emocionante aventura está a um toque de distância. Gerencie clientes e interesses de forma eficaz com o ClientePRO!",
          image: _buildImage('assets/logo.png', widthSize / 2),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: Icon(Icons.arrow_back_ios_new_rounded,
          color: globalsThemeVar.iGlobalsColors.primaryColor),
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
