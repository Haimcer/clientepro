import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../globals/globals_buttons.dart';
import '../globals/globals_sizes.dart';
import '../globals/globals_widgets.dart';
import '../globals/theme_controller.dart';

class LoginComponent {
  BuildContext context;
  LoginComponent(this.context);

  Widget topoPage() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          gradient: globalsThemeVar.iGlobalsColors.colorGradiente),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(GlobalsSizes().borderSize)),
                    gradient: globalsThemeVar.iGlobalsColors.colorGradiente,
                  ),
                  child: Image.asset(
                    'assets/images/app/logo-512-bco-transp.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(GlobalsSizes().marginSize),
            child: GlobalsButtons(context).btnVoltarFundo(context),
          ),
        ],
      ),
    );
  }

  Widget campoTextFieldSenha(TextEditingController controller, hintText,
      setObscureTextSenha, bool obscureTextSenha,
      {Widget? prefixIcon}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: globalsThemeVar.iGlobalsColors.tertiaryColor,
        borderRadius:
            BorderRadius.all(Radius.circular(GlobalsSizes().borderSize)),
        boxShadow: [
          GlobalsWidgets(context).sombreadoBoxShadow(),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            style:
                TextStyle(color: globalsThemeVar.iGlobalsColors.textColorForte),
            obscureText: obscureTextSenha,
            decoration: prefixIcon == null
                ? InputDecoration(
                    border: InputBorder.none,
                    hintText: '$hintText',
                    suffixIcon: IconButton(
                      onPressed: setObscureTextSenha,
                      icon: Icon(
                        obscureTextSenha
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 20,
                        color: globalsThemeVar.iGlobalsColors.textColorFraco,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: globalsThemeVar.iGlobalsColors.textColorFraco,
                    ),
                  )
                : InputDecoration(
                    border: InputBorder.none,
                    hintText: '$hintText',
                    hintStyle: TextStyle(
                      color: globalsThemeVar.iGlobalsColors.textColorFraco,
                    ),
                    suffixIcon: IconButton(
                      onPressed: setObscureTextSenha,
                      icon: Icon(
                        obscureTextSenha
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 20,
                        color: globalsThemeVar.iGlobalsColors.textColorFraco,
                      ),
                    ),
                    prefixIcon: prefixIcon,
                    prefixIconColor:
                        globalsThemeVar.iGlobalsColors.textColorFraco),
            onChanged: (_value) {},
            controller: controller,
          ),
        ],
      ),
    );
  }
}
