import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../controllers/usuario_ids.dart';
import '../../globals/globlas_alert.dart';
import '../../login/login_page.dart';

class GetClienteById {
  Future getClientById(BuildContext contextAux,
      {var novoToken, required String clientid}) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    print("${userIds.idToken}");
    try {
      final returnData = await http.get(
        Uri.parse(
            "https://cliente-pro.onrender.com/consultar-cliente/$clientid"),
        headers: {
          'Authorization': "${userIds.idToken}",
        },
      );
      print(
          'CLIENTE ID *******************************************************************');
      print(returnData.body);

      if (returnData.statusCode >= 200 && returnData.statusCode < 206) {
        if (returnData.body == '') return '';
        var dataReturn = await json.decode(returnData.body);
        print(dataReturn);
        return dataReturn;
      }

      if (returnData.statusCode == 503) {
        // ignore: use_build_context_synchronously
        GlobalsAlert(contextAux).alertWarning(
          contextAux,
          text:
              "Ops! tivemos um problema mas ja estamos trabalhando para resolve-lo.\nTente entrar na página novamente mais tarde",
        );
        return null;
      }

      if (returnData.statusCode == 500) {
        GlobalsAlert(contextAux).alertWarning(contextAux,
            text: "Ops! Erro desconhecido.\nTente novamente mais tarde");
        return false;
      }
      if (returnData.statusCode == 401) {
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          return getClientById(contextAux, clientid: clientid);
        } else {
          // ignore: use_build_context_synchronously
          GlobalsAlert(contextAux).alertWarning(
            contextAux,
            text: "Faça login novamente para continuar usando o aplicativo.",
            onTap: () {
              Navigator.of(contextAux, rootNavigator: true).pop();
            },
          );
        }
        return null;
      }
      GlobalsAlert(contextAux).alertWarning(
        contextAux,
        text: "Faça login novamente para continuar usando o aplicativo.",
        onTap: () {
          //GlobalsFunctions().btnSair(contextAux);
          Navigator.of(contextAux).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    } catch (error) {
      print("error: $error");
    }
    return null;
  }
}
