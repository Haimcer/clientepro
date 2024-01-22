import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../controllers/usuario_ids.dart';
import '../../controllers/usuario_infos.dart';
import '../../globals/globlas_alert.dart';

class PostCliente {
  Future postCliente(
    BuildContext contextAux, {
    String? nome,
    String? email,
    var novoToken,
  }) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    final usurioInfos = Provider.of<UsuarioInfos>(contextAux, listen: false);
    print(nome);
    print(email);

    try {
      final response = await http.post(
        Uri.parse("https://cliente-pro.onrender.com/cadastrar-cliente"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "${userIds.idToken}",
        },
        body: jsonEncode({
          "nome": nome,
          "usuario_id": usurioInfos.usuarioModel?.id,
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
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          //tem que ser a primeira tentativa, por isso novoToken == null
          return await postCliente(
            contextAux,
            nome: nome,
            email: email,
            novoToken: novoToken,
          );
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
    } catch (error) {
      print("error: $error");
    }
    // ignore: use_build_context_synchronously
    GlobalsAlert(contextAux).alertError(
      contextAux,
      text: "Ops! Erro ao criar usuário.\nTente novamente mais tarde",
    );
    return null;
  }
}
