import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/request/clientes/get_clientes_by_id.dart';
import 'package:flutter/material.dart';
import '../../model/cliente_model.dart';
import 'store/client_store.dart';

class ClientsPrincipalFunctions {
  BuildContext context;
  ClientsPrincipalFunctions(this.context);

  ClienteModel client = ClienteModel(
      id: '', nome: 'Não informado', email: 'Não informado', interesse: []);

  Future clientsFunctionPrincipal(UsuarioInfos usuarioInfos,
      ClienteModel clientSelecionado, ClientStore clientstore) async {
    clientstore.setListInteressesClear();
    try {
      var result = await GetClienteById()
          .getClientById(context, clientid: clientSelecionado.id);

      if (result != null) {
        client = ClienteModel.fromJson(result);
      }
      clientstore.setClient(client);
      clientstore.setAllListInteresses(client.interesse ?? []);
    } catch (e) {
      print(e);
    }
  }
}
