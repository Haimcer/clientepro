import 'package:clientepro/pages/home/alerts/add_interesse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../alerts/add_client.dart';
import '../alerts/edit_perfil.dart';

class Item {
  final String title;
  final IconData icon;
  final Widget? route;

  Item({
    required this.title,
    required this.icon,
    this.route,
  });
}

class ListDrawer {
  BuildContext context;
  List<Item> itemList = [];

  ListDrawer(this.context) {
    itemList = [
      Item(
        title: 'Adicionar cliente',
        icon: FontAwesomeIcons.userPlus,
        route: AddClient().buildAddClientWidget(context),
      ),
      Item(
        title: 'Adicionar interesse',
        icon: FontAwesomeIcons.circlePlus,
        route: AddInterest().buildAddInterestWidget(context),
      ),
      Item(
        title: 'Editar perfil',
        icon: FontAwesomeIcons.pen,
        route: EditPerfil().buildEditPerfilWidget(context),
      ),
    ];
  }
}
