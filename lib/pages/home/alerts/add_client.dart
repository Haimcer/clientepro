// ignore_for_file: unnecessary_null_comparison

import 'package:clientepro/globals/globals_form.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/globals/globlas_alert.dart';
import 'package:clientepro/model/cliente_model.dart';
import 'package:clientepro/request/clientes/post_cliente.dart';
import 'package:clientepro/request/relacoes/post_interesses_cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:clientepro/pages/home/store/home_store.dart';
import '../../../globals/globals_functions.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import '../options/grid_image_client.dart';

class AddClient {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Widget buildAddClientWidget(BuildContext context) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    final homestore = Provider.of<HomeStore>(context, listen: false);
    final globalsStore = Provider.of<GlobalsStore>(context);
    List<String> listInteresses = [];
    homestore.restartSelectedListInteresse();

    return AlertDialog(
      title: Center(
        child: Text('Adicionar Cliente',
            style: GlobalsStyles(context).styleSubtitle),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome do cliente',
                          style: GlobalsStyles(context).styleMenor),
                      SizedBox(height: GlobalsSizes().marginSize / 4),
                      GlobalsForm(context).campoTextFieldTexto(
                          nomeController, 'Digite o nome do cliente'),
                    ],
                  )),
              SizedBox(height: GlobalsSizes().marginSize),
              Padding(
                  padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email do cliente',
                          style: GlobalsStyles(context).styleMenor),
                      SizedBox(height: GlobalsSizes().marginSize / 4),
                      GlobalsForm(context).campoTextFieldTexto(
                          emailController, 'Digite o email do cliente'),
                    ],
                  )),
              Text('Escolha um interesse',
                  style: GlobalsStyles(context).styleMedio),
              SizedBox(height: GlobalsSizes().marginSize / 2),
              Observer(builder: (_) {
                return ImageClienteGridAlertDialog(
                  title: 'Selecione uma imagem',
                  images: homestore.listInteresses,
                  onImageSelected: (int index, String idInteresse) {
                    if (listInteresses.contains(idInteresse)) {
                      listInteresses.remove(idInteresse);
                      homestore.setIsSelectedInteresse(false, index);
                    } else {
                      listInteresses.add(idInteresse);
                      homestore.setIsSelectedInteresse(true, index);
                    }
                    homestore.listReloadListInteresses();
                  },
                );
              }),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: GlobalsSizes().marginSize,
        vertical: GlobalsSizes().marginSize,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Fechar',
            style:
                TextStyle(color: globalsThemeVar.iGlobalsColors.textColorFraco),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (emailController.text == '' || nomeController.text == '') {
              GlobalsAlert(context).alertWarning(context,
                  text:
                      'Nome ou email estão vazios por favor verifique os dados!');
              return;
            }
            if (!GlobalsFunctions().validaEmail(emailController.text)) {
              GlobalsAlert(context).alertWarning(context,
                  text: 'Email inválido por favor verifique os dados!');
              return;
            }
            globalsStore.setLoading(true);
            var result = await PostCliente().postCliente(context,
                email: emailController.text, nome: nomeController.text);
            ClienteModel cliente = ClienteModel.fromJson(result);
            if (cliente.id != null) {
              PostInteressesCliente().postInteressesCliente(context,
                  clienteId: cliente.id, listInteresses: listInteresses);
            }
            globalsStore.setLoading(false);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              globalsThemeVar.iGlobalsColors.secundaryColor,
            ),
          ),
          child: globalsStore.loading
              ? Container(
                  child: SizedBox(
                    height: GlobalsSizes().marginSize,
                    width: GlobalsSizes().marginSize,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: globalsThemeVar
                            .iGlobalsColors.textColorPrimaryInverse,
                      ),
                    ),
                  ),
                )
              : Text(
                  'Adicionar',
                  style: TextStyle(
                      color: globalsThemeVar
                          .iGlobalsColors.textColorPrimaryInverse),
                ),
        ),
      ],
    );
  }
}
