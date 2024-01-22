import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/pages/home/options/options_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/usuario_infos.dart';
import '../../../globals/theme_controller.dart';
import '../../../globals/globals_users_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globlasThemesVar = Provider.of<GlobalsThemeVar>(context);
    final usuarioInfos = Provider.of<UsuarioInfos>(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            color: globlasThemesVar.iGlobalsColors.secundaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: GlobalsSizes().marginSize,
                      left: GlobalsSizes().marginSize),
                  child: GlobalsUsersWidget(context).imgNameUser(
                    GlobalsSizes().marginSize * 2,
                    nome: usuarioInfos.usuarioModel?.nome,
                    sizeTextName: GlobalsSizes().sizeTitulo,
                    color:
                        globlasThemesVar.iGlobalsColors.textColorPrimaryInverse,
                  ),
                ),
                SizedBox(height: GlobalsSizes().marginSize),
                Padding(
                  padding: EdgeInsets.only(top: GlobalsSizes().marginSize),
                  child: Text(
                    'Menu',
                    style: GlobalsStyles(context).styleSubtitleInverse,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ListDrawer(context).itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Icon(ListDrawer(context).itemList[index].icon),
                      SizedBox(
                        width: GlobalsSizes().marginSize,
                      ),
                      Text(ListDrawer(context).itemList[index].title),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ListDrawer(context).itemList[index].route ??
                              Container();
                        });
                    if (ListDrawer(context).itemList[index].route != null) {
                      print(
                          'cliquei no ${ListDrawer(context).itemList[index].title} ');
                      ListDrawer(context).itemList[index].route;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
