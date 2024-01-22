import 'package:clientepro/login/signIn/signIn_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/usuario_ids.dart';
import '../../globals/globals_buttons.dart';
import '../../globals/globals_form.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/globals_styles.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import '../login_component.dart';
import '../store/login_store.dart';

class SignInWidget {
  BuildContext context;
  SignInWidget(this.context);

  Widget signInWidgetPrincipal() {
    return ListView(
      children: [
        LoginComponent(context).topoPage(),
        SizedBox(height: GlobalsSizes().marginSize),
        _textos(),
        SizedBox(height: GlobalsSizes().marginSize),
        _formulario(),
        SizedBox(height: GlobalsSizes().marginSize),
        btnConfirmar(),
        SizedBox(height: GlobalsSizes().marginSize),
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
            'Criar Conta',
            style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.primaryColor,
                fontSize: GlobalsSizes().sizeTitulo,
                fontWeight: GlobalsStyles(context).negritoFont),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: GlobalsSizes().marginSize / 2),
          Text(
            "Entre com sua melhor rede social",
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

  Widget _formulario() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final signInFunctions = Provider.of<SignInFunctions>(context);
    final loginStore = Provider.of<LoginStore>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ou, insira seus dados:',
            style: TextStyle(
              color: globalsThemeVar.iGlobalsColors.textColorMedio,
              fontSize: GlobalsSizes().sizeTextMedio,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: GlobalsSizes().marginSize),
          GlobalsForm(context).campoTextFieldTexto(
            signInFunctions.nomeController,
            "Nome",
            prefixIcon: Icon(
              FontAwesomeIcons.user,
              size: GlobalsSizes().sizeTextMedio,
            ),
          ),
          SizedBox(height: GlobalsSizes().marginSize),
          GlobalsForm(context).campoTextFieldTexto(
            signInFunctions.emailController,
            "Email",
            prefixIcon: Icon(
              FontAwesomeIcons.envelope,
              size: GlobalsSizes().sizeTextMedio,
            ),
          ),
          SizedBox(height: GlobalsSizes().marginSize),
          Observer(builder: (_) {
            return LoginComponent(context).campoTextFieldSenha(
              signInFunctions.senhaController,
              "Senha",
              loginStore.setObscureTextSenha,
              loginStore.obscureTextSenha,
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                size: GlobalsSizes().sizeTextMedio,
              ),
            );
          }),
          SizedBox(height: GlobalsSizes().marginSize),
          Observer(builder: (_) {
            return LoginComponent(context).campoTextFieldSenha(
              signInFunctions.confSenhaController,
              "Confirmar Senha",
              loginStore.setObscureTextConfSenha,
              loginStore.obscureTextConfSenha,
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

  Widget btnConfirmar() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final globalsStore = Provider.of<GlobalsStore>(context);
    final signInFunctions = Provider.of<SignInFunctions>(context);
    final usuarioIds = Provider.of<UsuarioIds>(context);

    return GlobalsButtons(context).buttonPrimary(
        globalsThemeVar.iGlobalsColors.primaryColor,
        globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
        'Confirmar', () async {
      globalsStore.setLoading(true);
      await signInFunctions.loginCreateAccount(context, usuarioIds);
      signInFunctions.limpaControllers();
      globalsStore.setLoading(false);
    });
  }
}
