import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/usuario_ids.dart';
import '../../globals/globlas_alert.dart';
import '../../login/login_page.dart';

class GetUsuarioById {
  Future getUsuarioById(
    BuildContext contextAux, {
    var novoToken,
    String? uid,
  }) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    try {
      final returnData = await http.get(
        Uri.parse("https://cliente-pro.onrender.com/consultarperfil?uid=$uid"),
        headers: {
          'Authorization': "${userIds.idToken}",
        },
      );

      print(
          'USUARIO *******************************************************************');
      print(returnData.body);

      if (returnData.statusCode >= 200 && returnData.statusCode < 206) {
        if (returnData.body == '') return '';
        var dataReturn = await json.decode(returnData.body);
        return dataReturn;
      }

      if (returnData.statusCode == 503) {
        return null;
      }

      if (returnData.statusCode == 500) {
        GlobalsAlert(contextAux).alertWarning(contextAux,
            text: "Ops! Erro desconhecido.\nTente novamente mais tarde");
        return false;
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

      if (returnData.statusCode == 401) {
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          return getUsuarioById(contextAux, uid: uid);
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
      print('AAAAAAAAAAAAAAAAAAAAAAAAAA');
      print(returnData.body);
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
      }
      return null;
    }
  }
}
