import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals/globals_buttons.dart';
import '../globals/globals_sizes.dart';
import '../globals/globals_styles.dart';
import '../globals/theme_controller.dart';
import 'logar/logar_page.dart';
import 'login_component.dart';
import 'login_functions.dart';
import 'signIn/signIn_page.dart';

class LoginWidget {
  BuildContext context;
  LoginWidget(this.context);

  Widget loginWidgetPrincipal() {
    return ListView(
      children: [
        LoginComponent(context).topoPage(),
        SizedBox(height: GlobalsSizes().marginSize * 2),
        _textos(),
        SizedBox(height: GlobalsSizes().marginSize * 2),
        _botoes(),
        SizedBox(height: GlobalsSizes().marginSize * 2),
      ],
    );
  }

  Widget _textos() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bem vindo !',
            style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.primaryColor,
                fontSize: GlobalsSizes().sizeTitulo,
                fontWeight: GlobalsStyles(context).negritoFont),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: GlobalsSizes().marginSize / 2),
          Text(
            'Bem vindo !!',
            style: TextStyle(
              color: globalsThemeVar.iGlobalsColors.textColorMedio,
              fontSize: GlobalsSizes().sizeTextMedio,
              //fontWeight: GlobalsStyles().negritoFont
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _botoes() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final loginFunctions = Provider.of<LoginFunctions>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GlobalsButtons(context).buttonPrimary(
              globalsThemeVar.iGlobalsColors.primaryColor,
              globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
              'Criar Conta', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInPage(
                          isReturnPage: loginFunctions.isReturnPage ?? false,
                        )));
          }),
          SizedBox(height: GlobalsSizes().marginSize),
          GlobalsButtons(context).buttonPrimary(
              globalsThemeVar.iGlobalsColors.tertiaryColor,
              globalsThemeVar.iGlobalsColors.primaryColor,
              'Acessar minha Conta', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LogarPage()));
          }, corBorda: globalsThemeVar.iGlobalsColors.primaryColor),
        ],
      ),
    );
  }
}
