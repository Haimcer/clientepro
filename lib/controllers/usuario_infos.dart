import 'package:flutter/material.dart';

import '../model/usuario_model.dart';

class UsuarioInfos extends ChangeNotifier {
  UsuarioModel? usuarioModel;

  void setUsuarioModel(UsuarioModel? usuarioModelAux) {
    usuarioModel = usuarioModelAux;
    notifyListeners();
  }
}
