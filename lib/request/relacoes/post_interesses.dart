import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../controllers/usuario_ids.dart';
import '../../globals/globlas_alert.dart';

class PostInteresses {
  Future postInteresses(
    BuildContext contextAux, {
    String? title,
    String? path,
    var novoToken,
  }) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    print(title);
    print(path);

    try {
      final response = await http.post(
        Uri.parse("https://cliente-pro.onrender.com/cadastrar-interesses"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "${userIds.idToken}",
        },
        body: jsonEncode({"descricao": title, "pathimage": path}),
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
          return await postInteresses(
            contextAux,
            title: title,
            path: path,
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
