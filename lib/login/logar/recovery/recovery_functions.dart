import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../globals/globals_functions.dart';
import '../../../globals/globlas_alert.dart';

class RecoveryFunctions {
  BuildContext context;
  RecoveryFunctions(this.context);

  final emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future recoveryFunctionsPrincipal() async {}

  Future enviaEmailRecovery(BuildContext contextAux) async {
    String emailValido = emailController.text.replaceAll(' ', '');
    if (!GlobalsFunctions().validaEmail(emailValido)) {
      GlobalsAlert(contextAux).alertWarning(contextAux, text: "Email inválido");
      return;
    }

    if (!await GlobalsFunctions().verificaConexao()) {
      final userVerify = _auth.sendPasswordResetEmail(email: emailValido);

      userVerify.then((value) {
        limpaControllers();
        GlobalsAlert(contextAux).alertSuccess(contextAux,
            text:
                'Enviamos um email de recuperação de senha. Caso não receba, verifique a caixa de SPAM.');
      }).catchError((onError) {
        GlobalsAlert(contextAux).alertError(contextAux,
            text: 'Ops! Não encontramos um usuário para o email informado');
      });
    } else {
      GlobalsAlert(contextAux).alertInternet(contextAux);
    }
  }

  Future limpaControllers() async {
    emailController.clear();
  }
}
