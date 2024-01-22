import 'package:clientepro/login/logar/recovery/recovery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../controllers/usuario_ids.dart';
import '../../controllers/usuario_infos.dart';
import '../../globals/globals_buttons.dart';
import '../../globals/globals_form.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/globals_styles.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import '../login_component.dart';
import '../login_functions.dart';
import '../store/login_store.dart';
import 'logar_functions.dart';

class LogarWidget {
  BuildContext context;
  LogarWidget(this.context);

  Widget logarWidgetPrincipal(contextAux) {
    return ListView(
      children: [
        LoginComponent(context).topoPage(),
        SizedBox(height: GlobalsSizes().marginSize),
        _textos(),
        SizedBox(height: GlobalsSizes().marginSize),
        _formulario(),
        SizedBox(height: GlobalsSizes().marginSize),
        btnConfirmar(contextAux),
        SizedBox(height: GlobalsSizes().marginSize),
        _esqueciSenha(),
        SizedBox(height: GlobalsSizes().marginSize * 1.5),
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
            'Logar',
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
    final logarFunctions = Provider.of<LogarFunctions>(context);
    final loginStore = Provider.of<LoginStore>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlobalsForm(context).campoTextFieldTexto(
            logarFunctions.emailController,
            "Email",
            prefixIcon: Icon(
              FontAwesomeIcons.envelope,
              size: GlobalsSizes().sizeTextMedio,
            ),
          ),
          SizedBox(height: GlobalsSizes().marginSize),
          Observer(builder: (_) {
            return LoginComponent(context).campoTextFieldSenha(
              logarFunctions.senhaController,
              "Senha",
              loginStore.setObscureTextSenha,
              loginStore.obscureTextSenha,
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                size: GlobalsSizes().sizeTextMedio,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget btnConfirmar(contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final globalsStore = Provider.of<GlobalsStore>(context);
    final loginFunctions = Provider.of<LoginFunctions>(context);
    final logarFunctions = Provider.of<LogarFunctions>(context);
    final userIds = Provider.of<UsuarioIds>(context);
    final usuarioInfos = Provider.of<UsuarioInfos>(context);

    return GlobalsButtons(contextAux).buttonPrimary(
        globalsThemeVar.iGlobalsColors.primaryColor,
        globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
        'Confirmar', () async {
      globalsStore.setLoading(true);
      await loginFunctions.logarEmailPass(
        contextAux,
        logarFunctions.emailController.text,
        logarFunctions.senhaController.text,
        logarFunctions.limpaControllers,
        userIds,
        usuarioInfos,
      );
      globalsStore.setLoading(false);
    });
  }

  Widget _esqueciSenha() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecoveryPage()),
              );
            },
            child: Text(
              "Esqueci minha Senha",
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.primaryColor,
                  fontSize: GlobalsSizes().sizeTextMedio),
            ),
          ),
        ],
      ),
    );
  }
}
