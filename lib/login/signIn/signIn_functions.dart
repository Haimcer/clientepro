import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/usuario_ids.dart';
import '../../globals/globals_functions.dart';
import '../../globals/globlas_alert.dart';
import '../../request/usuario/post_usuario.dart';
import '../logar/logar_page.dart';

class SignInFunctions {
  BuildContext context;
  SignInFunctions(this.context);

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confSenhaController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginCreateAccount(contextAux, UsuarioIds usuarioIds) async {
    String emailValido = emailController.text.replaceAll(' ', '');

    if (!GlobalsFunctions().validaEmail(emailValido)) {
      GlobalsAlert(contextAux).alertWarning(contextAux, text: "Email inválido");
      return;
    }

    if (senhaController.text.length < 8) {
      GlobalsAlert(contextAux).alertWarning(contextAux,
          text: "Senha deve ter mais que 8 caracteres");
      return;
    }

    if (senhaController.text != confSenhaController.text) {
      GlobalsAlert(contextAux)
          .alertWarning(contextAux, text: "Senhas devem ser iguais");
      return;
    }

    if (!await GlobalsFunctions().verificaConexao()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: emailValido,
          password: senhaController.text,
        );

        final idToken = await _auth.currentUser?.getIdToken();
        final uidUser = await _auth.currentUser?.uid;
        usuarioIds.setIds(idToken, uidUser);
        var jsonUsuarioPost = await PostUsuario().postUsuario(
          contextAux,
          nome: nomeController.text,
          email: emailValido,
          uid: uidUser,
        );

        if (jsonUsuarioPost == null) {
          await limpaControllers();
          GlobalsAlert(contextAux).alertSuccess(contextAux,
              text: "Conta Criada, Efetue login para confirmar seu cadastro",
              ontap: () async {
            await limpaControllers();
            Navigator.of(contextAux).pushReplacement(
                MaterialPageRoute(builder: (_) => const LogarPage()));
          });
          return;
        }
      } catch (err) {
        GlobalsAlert(contextAux)
            .alertWarning(contextAux, text: "Email já cadastrado ou inválido");
      }
    } else {
      GlobalsAlert(contextAux).alertInternet(contextAux);
    }
  }

  Future limpaControllers() async {
    nomeController.clear();
    emailController.clear();
    senhaController.clear();
    confSenhaController.clear();
  }
}
