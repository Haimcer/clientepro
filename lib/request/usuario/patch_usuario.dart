import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controllers/usuario_ids.dart';
import '../../globals/globlas_alert.dart';
import '../../login/login_page.dart';

class PatchUsuario {
  //atualizar apenas o FCM TOKEN
  Future patchUsuario(
    BuildContext contextAux,
    String idUsuario, {
    String? nome,
    String? email,
    var novoToken,
  }) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    try {
      final response = await http.patch(
        Uri.parse("https://cliente-pro.onrender.com/atualizarperfil"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "${userIds.idToken}",
        },
        body: jsonEncode({"id": idUsuario, "nome": nome}),
      );

      if (response.statusCode >= 200 && response.statusCode < 206) {
        var dataReturn = await json.decode(response.body);
        return dataReturn;
      }

      if (response.statusCode == 500) {
        GlobalsAlert(contextAux).alertWarning(contextAux,
            text: "Ops! Erro desconhecido.\nTente novamente mais tarde");
        return false;
      }

      if (response.statusCode == 503) {
        // ignore: use_build_context_synchronously
        GlobalsAlert(contextAux).alertWarning(
          contextAux,
          text:
              "Ops! tivemos um problema mas ja estamos trabalhando para resolve-lo.\nTente entrar na página novamente mais tarde",
        );
        return null;
      }

      if (response.statusCode == 401) {
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          //tem que ser a primeira tentativa, por isso novoToken == null
          // ignore: use_build_context_synchronously
          return patchUsuario(contextAux, idUsuario,
              nome: nome, email: email, novoToken: novoTokenAux);
        } else {
          // ignore: use_build_context_synchronously
          GlobalsAlert(contextAux).alertWarning(
            contextAux,
            text: "Faça login novamente para continuar usando o aplicativo.",
            onTap: () {
              //GlobalsFunctions().btnSair(contextAux);
              Navigator.of(contextAux, rootNavigator: true).pop();
            },
          );
        }
        return null;
      }
      print(response.body);
    } catch (e) {
      print(e);
      GlobalsAlert(contextAux).alertWarning(
        contextAux,
        text: "Faça login novamente para continuar usando o aplicativo.",
        onTap: () {
          //GlobalsFunctions().btnSair(contextAux);
          Navigator.of(contextAux).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    }
  }
}
