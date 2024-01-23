import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/request/filtro/get_filtro_interesses_client.dart';
import 'package:flutter/material.dart';

import '../../model/cliente_model.dart';
import '../../model/interesses_model.dart';
import 'store/interesses_store.dart';

class InteressesPrincipalFunctions {
  BuildContext context;
  InteressesPrincipalFunctions(this.context);

  Future interessesFunctionPrincipal(UsuarioInfos usuarioInfos,
      InteressesStore interessesStore, InteressesModel interessesModel) async {
    interessesStore.setListInteressesClear();
    try {
      var result = await GetIntessesClientes().getInteressesClientes(context,
          interesseId: interessesModel.id,
          usuarioid: usuarioInfos.usuarioModel?.id ?? '');

      if (result != null) {
        result.forEach((cliente) {
          interessesStore.setListInteresses(ClienteModel.fromJson(cliente));
        });
      }

      print(interessesStore.listInteresses);
    } catch (e) {
      print(e);
    }
  }
}
