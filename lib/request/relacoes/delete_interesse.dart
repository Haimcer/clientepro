import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../controllers/usuario_ids.dart';
import '../../globals/globlas_alert.dart';
import '../../login/login_page.dart';

class DeleteInteresseCliente {
  Future<bool> deleteInteresseCliente(BuildContext context,
      {var novoToken,
      required String? clientId,
      required String? interesseId}) async {
    final userIds = Provider.of<UsuarioIds>(context, listen: false);
    try {
      final response = await http.delete(
        Uri.parse(
            "https://cliente-pro.onrender.com/excluir-interesses-cliente/$interesseId?clienteId=$clientId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "${userIds.idToken}",
        },
      );
      print("response.statusCode: ${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode < 206) {
        return true;
      }

      if (response.statusCode == 500) {
        GlobalsAlert(context).alertWarning(context,
            text: "Ops! Erro desconhecido.\nTente novamente mais tarde");
        return false;
      }

      if (response.statusCode == 503) {
        // ignore: use_build_context_synchronously
        GlobalsAlert(context).alertWarning(
          context,
          text:
              "Ops! tivemos um problema mas ja estamos trabalhando para resolve-lo.\nTente entrar na página novamente mais tarde",
        );
        return false;
      }

      if (response.statusCode == 400) {
        GlobalsAlert(context).alertWarning(
          context,
          text: "Ocorreu um erro. Por favor, efetue o login novamente.",
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          },
        );
        Navigator.pop(context);
        return false;
      }

      if (response.statusCode == 404) {
        print(response.body);
        // GlobalsAlert(context).alertWarning(
        //   context,
        //   text: "Conta não localizada. Por favor, efetue o login novamente.",
        //   onTap: () {
        //     Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(builder: (context) => LoginPage()),
        //       (route) => false,
        //     );
        //   },
        // );
        return false;
      }

      if (response.statusCode == 401) {
        // TOKEN INVÁLIDO: tenta renovar o token
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null && novoToken == null) {
          //tem que ser a primeira tentativa, por isso novoToken == null
          // ignore: use_build_context_synchronously
          return deleteInteresseCliente(context,
              clientId: clientId, interesseId: interesseId);
        } else {
          // ignore: use_build_context_synchronously
          GlobalsAlert(context).alertWarning(
            context,
            text: "Faça login novamente para continuar usando o aplicativo.",
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          );
        }
        return false;
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "Ocorreu um erro. Por favor, efetue o login novamente.",
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
          );
        },
      );
      return false;
    } catch (e) {
      GlobalsAlert(context).alertWarning(context,
          text: "Ops! Erro ao excluir conta.\nTente novamente mais tarde");
      return false;
    }
  }
}
