import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/model/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/globals_widgets.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'page_clients_functions.dart';
import 'page_clients_widgets.dart';
import 'store/client_store.dart';

class PageClientsPrincipal extends StatefulWidget {
  PageClientsPrincipal({super.key, required this.clienteSelecionado});

  ClienteModel clienteSelecionado;

  @override
  State<PageClientsPrincipal> createState() => _PageClientsPrincipalState();
}

class _PageClientsPrincipalState extends State<PageClientsPrincipal> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  late ClientsPrincipalFunctions clientsPrincipalFunctions;
  late GlobalsStore globalsStore;
  late UsuarioInfos usuarioInfos;
  late ClientStore clientstore;
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    clientsPrincipalFunctions = Provider.of<ClientsPrincipalFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    usuarioInfos = Provider.of<UsuarioInfos>(context);
    clientstore = Provider.of<ClientStore>(context);
    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;
    await clientsPrincipalFunctions.clientsFunctionPrincipal(
        usuarioInfos, widget.clienteSelecionado, clientstore);
    if (!mounted) return;
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: carregando
                ? GlobalsWidgets(context).loading()
                : PageClientsWidget(context).clientsWidget(context),
          ),
          Observer(builder: (_) {
            return Visibility(
              visible: globalsStore.loading,
              child: GlobalsWidgets(context).loading(),
            );
          }),
        ],
      ),
    );
  }
}
