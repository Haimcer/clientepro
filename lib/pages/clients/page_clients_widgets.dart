import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/globals/globals_users_widget.dart';
import 'package:clientepro/globals/globals_widgets.dart';
import 'package:clientepro/globals/globlas_alert.dart';
import 'package:clientepro/globals/theme_controller.dart';
import 'package:clientepro/model/cliente_model.dart';
import 'package:clientepro/request/clientes/get_clientes_by_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../controllers/usuario_infos.dart';
import '../../globals/globals_buttons.dart';
import '../../globals/store/globals_store.dart';
import '../../request/clientes/delete_cliente.dart';
import '../../request/clientes/get_clientes.dart';
import '../../request/relacoes/delete_interesse.dart';
import '../home/page_home_principal.dart';
import '../home/store/home_store.dart';
import 'alerts/add_interesse_client.dart';
import 'alerts/edit_client.dart';
import 'store/client_store.dart';

class PageClientsWidget {
  BuildContext context;
  PageClientsWidget(this.context);

  Widget clientsWidget(BuildContext contextAux) {
    final sizeMediaQ = MediaQuery.of(contextAux).size;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  SizedBox(
                    height: sizeMediaQ.height / 3.6,
                    child: GlobalsWidgets(context).appBarDescTitulo(
                      contextAux,
                      descTitulo: 'Detalhes',
                      titulo: 'Cliente',
                      prefixWidget: GlobalsButtons(context).btnVoltarFundo(
                        context,
                        corFundo: Colors.transparent,
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PageHomePrincipal())),
                      ),
                    ),
                  ),
                  cardUsuario(),
                ],
              ),
              SizedBox(height: GlobalsSizes().marginSize / 2),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
                child: GlobalsWidgets(context).divisoria(),
              ),
              SizedBox(height: GlobalsSizes().marginSize / 2),
              interessesCard(),
            ],
          ),
        ),
        optionsBar(),
      ],
    );
  }

  Widget cardUsuario() {
    final clientstore = Provider.of<ClientStore>(context, listen: false);

    return Observer(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          left: GlobalsSizes().marginSize,
        ),
        child: Row(
          children: [
            GlobalsUsersWidget(context).imgRedondaUser(
                GlobalsSizes().marginSize * 4,
                borda: true,
                nome: clientstore.client.nome),
            SizedBox(
              width: GlobalsSizes().marginSize / 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientstore.client.nome,
                  style: GlobalsStyles(context).styleTitleAlternative,
                ),
                SizedBox(height: GlobalsSizes().marginSize / 4),
                Text(
                  clientstore.client.email,
                  style: GlobalsStyles(context).styleMedio,
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget interessesCard() {
    final globlasThemesVar = Provider.of<GlobalsThemeVar>(context);
    final clientstore = Provider.of<ClientStore>(context);
    final sizeMediaQ = MediaQuery.of(context).size;
    final globalsStore = Provider.of<GlobalsStore>(context);
    return Padding(
      padding: EdgeInsets.all(GlobalsSizes().marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalsSizes().marginSize / 2),
          Padding(
            padding: EdgeInsets.only(left: GlobalsSizes().marginSize),
            child: Text(
              'Interesses',
              style: GlobalsStyles(context).styleTitleAlternative,
            ),
          ),
          GlobalsWidgets(context).divisoria(),
          Observer(builder: (context) {
            return SizedBox(
              height: sizeMediaQ.height / 2.1,
              child: GridView.builder(
                shrinkWrap: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: clientstore.isEdit
                    ? clientstore.listInteresses.length + 1
                    : clientstore.listInteresses
                        .length, // Adicione 1 para o card extra no final
                itemBuilder: (BuildContext context, int index) {
                  if (index == clientstore.listInteresses.length &&
                      clientstore.isEdit) {
                    // Último item, adicione o card "Adicionar"
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddInteresseClient()
                                    .buildAddInteresseClientWidget(context,
                                        id: clientstore.client.id);
                              },
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            elevation: 5.0,
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.all(GlobalsSizes().marginSize),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/icons/adicionar.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Adicionar',
                            style: GlobalsStyles(context).styleMenor,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Itens da lista
                    return Column(
                      children: [
                        IgnorePointer(
                          ignoring: clientstore.isEdit ? false : true,
                          child: GestureDetector(
                            onTap: () {
                              GlobalsAlert(context).alertWarning(
                                context,
                                title: 'Aviso!',
                                text:
                                    'Deseja confirmar a exclusão do interesse selecionado ?',
                                onTap: () async {
                                  await DeleteInteresseCliente()
                                      .deleteInteresseCliente(context,
                                          clientId: clientstore.client.id,
                                          interesseId: clientstore
                                              .listInteresses[index].id);
                                  var result = await GetClienteById()
                                      .getClientById(context,
                                          clientid: clientstore.client.id);

                                  if (result != null) {
                                    clientstore.setClient(
                                        ClienteModel.fromJson(result));
                                  }

                                  clientstore.setAllListInteresses(
                                      clientstore.client.interesse ?? []);
                                  clientstore.listReloadListInteresses();
                                },
                                onTapCancel: () {
                                  globalsStore.setLoading(false);
                                },
                              );
                            },
                            child: badges.Badge(
                              showBadge: clientstore.isEdit,
                              position:
                                  badges.BadgePosition.custom(top: 7, end: 5),
                              badgeContent: Icon(
                                Icons.delete,
                                color: globlasThemesVar
                                    .iGlobalsColors.textColorPrimaryInverse,
                                size: GlobalsSizes().sizeTextMedio,
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                elevation: 5.0,
                                child: Container(
                                  height: 60,
                                  margin:
                                      EdgeInsets.all(GlobalsSizes().marginSize),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage(clientstore
                                              .listInteresses[index]
                                              .pathImage ??
                                          'assets/interesses/foto.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            clientstore.listInteresses[index].descricao,
                            style: GlobalsStyles(context).styleMenor,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          }),
          SizedBox(height: GlobalsSizes().marginSize * 3),
        ],
      ),
    );
  }

  Widget optionsBar() {
    final clientstore = Provider.of<ClientStore>(context);
    final globalsStore = Provider.of<GlobalsStore>(context, listen: false);
    final homestore = Provider.of<HomeStore>(context, listen: false);
    final usurioInfos = Provider.of<UsuarioInfos>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildOption('Editar Cliente', 'assets/icons/editarusuario.png', () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditClient().buildEditClientWidget(context,
                  clientAux: clientstore.client);
            },
          );
        }),
        buildOption('Editar Interesse', 'assets/icons/editar.png', () {
          clientstore.setIsEdit(!clientstore.isEdit);
          clientstore.listReloadListInteresses();
        }),
        buildOption('Excluir Cliente', 'assets/icons/excluir.png', () {
          globalsStore.setLoading(true);
          GlobalsAlert(context).alertWarning(context,
              title: 'Aviso!',
              text: 'Deseja excluir o cliente ?', onTap: () async {
            if (await DeleteCliente()
                .deleteCliente(context, clientId: clientstore.client.id)) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => PageHomePrincipal()));

              List<ClienteModel> listCliente = [];
              try {
                var result = await GetAllClientes().getAllClientes(context,
                    usuarioid: usurioInfos.usuarioModel?.id ?? '');
                if (result != null) {
                  result.forEach((cliente) {
                    listCliente.add(ClienteModel.fromJson(cliente));
                  });
                }

                homestore.setAllListModelMobXClient(listCliente);

                globalsStore.setLoading(false);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageHomePrincipal()));
              } catch (e) {}
            }
            ;
          }, onTapCancel: () {
            globalsStore.setLoading(false);
          });
        }),
      ],
    );
  }

  Widget buildOption(String title, String imagePath, VoidCallback onTap) {
    final globlasThemesVar = Provider.of<GlobalsThemeVar>(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            bottom: GlobalsSizes().marginSize / 4,
            top: GlobalsSizes().marginSize / 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: globlasThemesVar.iGlobalsColors.textColorFraco,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: GlobalsSizes().marginSize * 2,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: GlobalsSizes().marginSize / 2),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GlobalsStyles(context).styleMedio,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
