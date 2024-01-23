import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/pages/home/store/home_store.dart';
import 'package:clientepro/request/clientes/get_clientes.dart';
import 'package:clientepro/request/relacoes/get_interesses.dart';
import 'package:flutter/material.dart';

import '../../model/cliente_model.dart';
import '../../model/interesses_model.dart';

class HomePrincipalFunctions {
  BuildContext context;
  HomePrincipalFunctions(this.context);

  List<ClienteModel> listCliente = [];

  Future homeFunctionPrincipal(
      UsuarioInfos usuarioInfos, HomeStore homeStore) async {
    homeStore.setListInteressesClear();
    listCliente = [];
    try {
      var result = await GetAllClientes().getAllClientes(context,
          usuarioid: usuarioInfos.usuarioModel?.id ?? '');

      if (result != null) {
        result.forEach((cliente) {
          listCliente.add(ClienteModel.fromJson(cliente));
        });
      }

      var resultInteresses = await GetAllInteresses().getAllInteresses(context);
      if (resultInteresses != null) {
        resultInteresses.forEach((interesse) {
          homeStore.setListInteresses(InteressesModel.fromJson(interesse));
        });
      }

      print(homeStore.listInteresses);
    } catch (e) {
      print(e);
    }
  }
}
