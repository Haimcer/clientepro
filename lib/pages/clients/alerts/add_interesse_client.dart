// ignore_for_file: unnecessary_null_comparison
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/model/cliente_model.dart';
import 'package:clientepro/request/relacoes/post_interesses_cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:clientepro/pages/home/store/home_store.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import '../../home/options/grid_image_client.dart';
import '../store/client_store.dart';

class AddInteresseClient {
  Widget buildAddInteresseClientWidget(BuildContext context,
      {required String id}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    final homestore = Provider.of<HomeStore>(context, listen: false);
    final clientstore = Provider.of<ClientStore>(context, listen: false);
    final globalsStore = Provider.of<GlobalsStore>(context, listen: false);
    List<String> listInteresses = [];
    homestore.restartSelectedListInteresse();

    return AlertDialog(
      title: Center(
        child: Text('Adicionar ao Cliente',
            style: GlobalsStyles(context).styleSubtitle),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            globalsStore.setLoading(true);
            final result = await PostInteressesCliente().postInteressesCliente(
                context,
                clienteId: id,
                listInteresses: listInteresses);
            final client = ClienteModel.fromJson(result);
            if (client != null) {
              clientstore.setClient(client);
            }
            clientstore.setAllListInteresses(client.interesse ?? []);
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
