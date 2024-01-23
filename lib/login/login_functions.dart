import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/usuario_ids.dart';
import '../controllers/usuario_infos.dart';
import '../globals/globals_functions.dart';
import '../globals/globlas_alert.dart';
import '../model/usuario_model.dart';
import '../pages/home/page_home_principal.dart';
import '../request/usuario/get_usuario_by_id.dart';

class LoginFunctions {
  BuildContext context;
  LoginFunctions(this.context);

  bool? isReturnPage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginFunctionsPrincipal(bool? isReturnPageAux) async {
    isReturnPage = isReturnPageAux;
  }

  Future logarEmailPass(
      contextAux,
      String emailText,
      String senhaText,
      VoidCallback? funcLimpaControllers,
      UsuarioIds usuarioIds,
      UsuarioInfos usuarioInfos) async {
    if (!GlobalsFunctions().validaEmail(emailText)) {
      GlobalsAlert(contextAux).alertWarning(contextAux, text: "Email inválido");
      return;
    }
    if (senhaText.length < 8) {
      GlobalsAlert(contextAux).alertWarning(contextAux,
          text: "Senha deve ter mais que 8 caracteres");
      return;
    }

    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(contextAux).alertInternet(contextAux);
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailText,
        password: senhaText,
      );

      var dadosUser = await GetUsuarioById()
          .getUsuarioById(contextAux, uid: usuarioIds.uidUser);

      if (dadosUser == null) {
        //nao se cadastrou no app ainda
        GlobalsAlert(contextAux).alertError(contextAux,
            text: "Erro ao logar, confira seus dados e tente novamente");
        return;
      } else {
        funcLimpaControllers;
        usuarioInfos.setUsuarioModel(UsuarioModel.fromJson(dadosUser));
        Navigator.pushAndRemoveUntil(
          contextAux,
          MaterialPageRoute(builder: (contextAux) => PageHomePrincipal()),
          (route) => false,
        );
        return;
      }
    } catch (_err) {
      print(_err);
      GlobalsAlert(contextAux).alertWarning(contextAux, text: "Login Inválido");
    }
  }
}
