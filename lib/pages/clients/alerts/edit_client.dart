// ignore_for_file: unnecessary_null_comparison

import 'package:clientepro/globals/globals_form.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/globals/globlas_alert.dart';
import 'package:clientepro/model/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clientepro/pages/home/store/home_store.dart';
import '../../../globals/globals_functions.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import '../../../request/clientes/patch_cliente.dart';
import '../store/client_store.dart';

class EditClient {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Widget buildEditClientWidget(BuildContext context,
      {required ClienteModel clientAux}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    final homestore = Provider.of<HomeStore>(context, listen: false);
    final clientstore = Provider.of<ClientStore>(context, listen: false);
    final globalsStore = Provider.of<GlobalsStore>(context);
    homestore.restartSelectedListInteresse();
    nomeController.text = clientAux.nome;
    emailController.text = clientAux.email;
    return AlertDialog(
      title: Center(
        child:
            Text('Editar Cliente', style: GlobalsStyles(context).styleSubtitle),
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
                      GlobalsForm(context)
                          .campoTextFieldTexto(nomeController, clientAux.nome),
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
                          emailController, clientAux.email),
                    ],
                  )),
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
            if (nomeController.text == '') {
              GlobalsAlert(context).alertWarning(context,
                  text:
                      'Nome ou email estão vazios por favor verifique os dados!');
              return;
            }
            if (emailController.text != '') {
              if (!GlobalsFunctions().validaEmail(emailController.text)) {
                GlobalsAlert(context).alertWarning(context,
                    text: 'Email inválido por favor verifique os dados!');
                return;
              }
            }
            globalsStore.setLoading(true);
            var result = await PatchClient().patchClient(context,
                idClient: clientAux.id,
                email: emailController.text != '' ? emailController.text : null,
                nome: nomeController.text);
            if (result != null) {
              ClienteModel cliente = ClienteModel.fromJson(result);
              clientstore.setClient(cliente);
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
              ? SizedBox(
                  height: GlobalsSizes().marginSize,
                  width: GlobalsSizes().marginSize,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: globalsThemeVar
                          .iGlobalsColors.textColorPrimaryInverse,
                    ),
                  ),
                )
              : Text(
                  'Salvar',
                  style: TextStyle(
                      color: globalsThemeVar
                          .iGlobalsColors.textColorPrimaryInverse),
                ),
        ),
      ],
    );
  }
}
