import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/globals/globals_cards.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../globals/globals_styles.dart';
import '../../globals/globals_users_widget.dart';
import '../../globals/globals_widgets.dart';
import '../clients/page_clients_principal.dart';
import '../interesses/page_interesses_principal.dart';
import 'store/home_store.dart';

class PagePrincipalWidget {
  BuildContext context;
  PagePrincipalWidget(this.context);

  Widget principalWidget(BuildContext contextAux) {
    final globlasThemesVar = Provider.of<GlobalsThemeVar>(context);
    final usuarioInfos = Provider.of<UsuarioInfos>(context);
    final homestore = Provider.of<HomeStore>(context);
    final sizeMediaQ = MediaQuery.of(context).size;

    return SizedBox(
      height: sizeMediaQ.height,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // AppBar
              GlobalsWidgets(context).appBarDescTitulo(
                context,
                descTitulo: 'Página Principal',
                titulo: 'Todos clientes',
                prefixWidget: Container(
                  margin: EdgeInsets.only(top: GlobalsSizes().marginSize / 2),
                  child: GlobalsUsersWidget(context)
                      .imgPerfilUser(user: usuarioInfos.usuarioModel),
                ),
                sufixWidget: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: GlobalsSizes().marginSize / 2),
                    child: GestureDetector(
                      onTap: () => Scaffold.of(contextAux).openDrawer(),
                      child: Icon(
                        FontAwesomeIcons.bars,
                        color: globlasThemesVar
                            .iGlobalsColors.textColorPrimaryInverse,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: GlobalsSizes().marginSize / 2,
              ),

              // Lista de Interesses
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: GlobalsSizes().marginSize,
                    ),
                    child: Text(
                      'Interesses',
                      style: GlobalsStyles(context).styleSubtitle,
                    ),
                  ),
                  SizedBox(
                    height: GlobalsSizes().marginSize / 2,
                  ),
                  Container(
                    height: GlobalsSizes().marginSize * 3.5,
                    margin: EdgeInsets.symmetric(
                      horizontal: GlobalsSizes().marginSize,
                    ),
                    child: homestore.listInteresses.isEmpty
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homestore.listInteresses.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PageInteressesPrincipal(
                                      interesseModel:
                                          homestore.listInteresses[index],
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      GlobalsSizes().marginSize / 4),
                                  child: Column(
                                    children: [
                                      GlobalsUsersWidget(context)
                                          .imgRedondaUser(
                                        GlobalsSizes().marginSize * 2,
                                        img: homestore
                                            .listInteresses[index].pathImage,
                                        isImageLocal: true,
                                        borda: true,
                                        colorborda: globlasThemesVar
                                            .iGlobalsColors.textColorFraco,
                                        widthBorda: 1.2,
                                      ),
                                      Text(
                                        homestore
                                            .listInteresses[index].descricao,
                                        style:
                                            GlobalsStyles(context).styleMenor,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  GlobalsWidgets(context).divisoria(),
                ],
              ),

              SizedBox(
                height: GlobalsSizes().marginSize / 2,
              ),

              // Lista de Clientes
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: GlobalsSizes().marginSize,
                ),
                child: Text(
                  'Clientes',
                  style: GlobalsStyles(context).styleSubtitle,
                ),
              ),

              SizedBox(
                height: sizeMediaQ.height / 1.5,
                child: homestore.listModelMobXClient.isEmpty
                    ? GlobalsWidgets(context).imgEmpty()
                    : ListView.builder(
                        itemCount: homestore.listModelMobXClient.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: GlobalsSizes().marginSize),
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PageClientsPrincipal(
                                    clienteSelecionado:
                                        homestore.listModelMobXClient[index],
                                  ),
                                ),
                              ),
                              child: CustomCard(context).cardLateral(
                                context,
                                interesses: homestore
                                    .listModelMobXClient[index].interesse,
                                name: homestore.listModelMobXClient[index].nome,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
