import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/globals/globals_cards.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/theme_controller.dart';
import 'package:clientepro/pages/home/page_home_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../globals/globals_users_widget.dart';
import '../../globals/globals_widgets.dart';

class PagePrincipalWidget {
  BuildContext context;
  PagePrincipalWidget(this.context);

  Widget principalWidget(BuildContext contextAux) {
    final homeprincipalfunctions = Provider.of<HomePrincipalFunctions>(context);
    final globlasThemesVar = Provider.of<GlobalsThemeVar>(context);
    final usuarioInfos = Provider.of<UsuarioInfos>(context);
    return Column(
      children: [
        GlobalsWidgets(context).appBarDescTitulo(
          context,
          descTitulo: 'Clientes',
          titulo: 'Clientes',
          prefixWidget: Container(
              margin: EdgeInsets.only(top: GlobalsSizes().marginSize / 2),
              child: GlobalsUsersWidget(context)
                  .imgPerfilUser(user: usuarioInfos.usuarioModel)),
          sufixWidget: GestureDetector(
              child: Container(
            margin: EdgeInsets.only(top: GlobalsSizes().marginSize / 2),
            child: GestureDetector(
              onTap: () => Scaffold.of(contextAux).openDrawer(),
              child: Icon(
                FontAwesomeIcons.bars,
                color: globlasThemesVar.iGlobalsColors.textColorPrimaryInverse,
              ),
            ),
          )),
        ),
        Expanded(
            child: homeprincipalfunctions.listCliente.isEmpty
                ? GlobalsWidgets(context).imgEmpty()
                : ListView.builder(
                    itemCount: homeprincipalfunctions.listCliente.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: GlobalsSizes().marginSize),
                        child: CustomCard(context).cardLateral(context,
                            interesses: homeprincipalfunctions
                                .listCliente[index].interesse,
                            name:
                                homeprincipalfunctions.listCliente[index].nome),
                      );
                    },
                  ))
      ],
    );
  }
}
