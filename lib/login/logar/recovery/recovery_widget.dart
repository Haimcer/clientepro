import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../globals/globals_buttons.dart';
import '../../../globals/globals_form.dart';
import '../../../globals/globals_sizes.dart';
import '../../../globals/globals_styles.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import '../../login_component.dart';
import 'recovery_functions.dart';

class RecoveryWidget {
  BuildContext context;
  RecoveryWidget(this.context);

  Widget recoveryWidgetPrincipal(contextAux) {
    return ListView(
      children: [
        LoginComponent(context).topoPage(),
        SizedBox(height: GlobalsSizes().marginSize),
        _textos(),
        SizedBox(height: GlobalsSizes().marginSize),
        _formulario(),
        SizedBox(height: GlobalsSizes().marginSize),
        _btnConfirmar(),
      ],
    );
  }

  Widget _textos() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      padding: EdgeInsets.only(bottom: GlobalsSizes().marginSize * 2),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recuperar Senha',
            style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.primaryColor,
                fontSize: GlobalsSizes().sizeTitulo,
                fontWeight: GlobalsStyles(context).negritoFont),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _formulario() {
    final recoveryFunctions = Provider.of<RecoveryFunctions>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      padding: EdgeInsets.only(bottom: GlobalsSizes().marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlobalsForm(context).campoTextFieldTexto(
            recoveryFunctions.emailController,
            "Email",
            prefixIcon: Icon(
              FontAwesomeIcons.envelope,
              size: GlobalsSizes().sizeTextMedio,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnConfirmar() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final globalsStore = Provider.of<GlobalsStore>(context);
    final recoveryFunctions = Provider.of<RecoveryFunctions>(context);
    return GlobalsButtons(context).buttonPrimary(
      globalsThemeVar.iGlobalsColors.tertiaryColor,
      globalsThemeVar.iGlobalsColors.primaryColor,
      'Recuperar',
      () async {
        globalsStore.setLoading(true);
        await recoveryFunctions.enviaEmailRecovery(context);
        //Navigator.pop(context);
        globalsStore.setLoading(false);
      },
      corBorda: globalsThemeVar.iGlobalsColors.primaryColor,
    );
  }
}
