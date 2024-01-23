import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/usuario_ids.dart';
import '../../controllers/usuario_infos.dart';
import '../../globals/globlas_alert.dart';
import '../../login/login_page.dart';

class PatchClient {
  //atualizar apenas o FCM TOKEN
  Future patchClient(
    BuildContext contextAux, {
    String? nome,
    String? email,
    String? idClient,
    var novoToken,
  }) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    final userInfos = Provider.of<UsuarioInfos>(contextAux, listen: false);
    try {
      final response = await http.patch(
        Uri.parse("https://cliente-pro.onrender.com/atualizar-cliente"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "${userIds.idToken}",
        },
        body: email == null
            ? jsonEncode({
                "id": idClient,
                "nome": nome,
                "usuario_id": userInfos.usuarioModel?.id,
              })
            : jsonEncode({
                "id": idClient,
                "nome": nome,
                "usuario_id": userInfos.usuarioModel?.id,
                "email": email
              }),
      );

      if (response.statusCode >= 200 && response.statusCode < 206) {
        var dataReturn = await json.decode(response.body);
        return dataReturn;
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

      if (response.statusCode == 500) {
        GlobalsAlert(contextAux).alertWarning(contextAux,
            text: "Ops! Erro desconhecido.\nTente novamente mais tarde");
        return false;
      }

      if (response.statusCode == 401) {
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          //tem que ser a primeira tentativa, por isso novoToken == null
          // ignore: use_build_context_synchronously
          return patchClient(contextAux,
              nome: nome,
              email: email,
              idClient: idClient,
              novoToken: novoTokenAux);
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
      print('AAAAAAAAAAAAAAAAAAAAAAAAAA');
      print(response.body);
      GlobalsAlert(contextAux).alertWarning(
        contextAux,
        text: "Faça login novamente para continuar usando o aplicativo.",
        onTap: () {
          //GlobalsFunctions().btnSair(contextAux);
          Navigator.of(contextAux).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    } catch (e) {
      print(e);
      if (e is FirebaseAuthException && e.code == 'auth/id-token-revoked') {
        GlobalsAlert(contextAux).alertWarning(
          contextAux,
          text: "Faça login novamente para continuar usando o aplicativo.",
          onTap: () {
            //GlobalsFunctions().btnSair(contextAux);
            Navigator.of(contextAux).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
        );
      } else {
        print(e);
      }
    }
  }
}
