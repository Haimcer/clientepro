import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../controllers/usuario_ids.dart';
import '../../globals/globlas_alert.dart';

class GetAllClientes {
  Future getAllClientes(BuildContext contextAux,
      {var novoToken, required String usuarioid}) async {
    final userIds = Provider.of<UsuarioIds>(contextAux, listen: false);
    print("${userIds.idToken}");
    try {
      final returnData = await http.get(
        Uri.parse(
            "https://cliente-pro.onrender.com/consultar-all-clientes/$usuarioid"),
        headers: {
          'Authorization': "${userIds.idToken}",
        },
      );
      print(
          'CLIENTE *******************************************************************');
      print(returnData.body);

      if (returnData.statusCode >= 200 && returnData.statusCode < 206) {
        if (returnData.body == '') return '';
        var dataReturn = await json.decode(returnData.body);
        print(dataReturn);
        return dataReturn;
      }

      if (returnData.statusCode == 503) {
        return null;
      }
      if (returnData.statusCode == 500) {
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          return getAllClientes(contextAux, usuarioid: usuarioid);
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
    } catch (error) {
      print("error: $error");
    }
    return null;
  }
}
