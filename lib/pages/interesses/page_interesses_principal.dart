import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/model/interesses_model.dart';
import 'package:clientepro/pages/home/options/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/globals_widgets.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'page_interesses_functions.dart';
import 'page_interesses_widgets.dart';
import 'store/interesses_store.dart';

class PageInteressesPrincipal extends StatefulWidget {
  PageInteressesPrincipal({super.key, required this.interesseModel});

  InteressesModel interesseModel;

  @override
  State<PageInteressesPrincipal> createState() =>
      _PageInteressesPrincipalState();
}

class _PageInteressesPrincipalState extends State<PageInteressesPrincipal> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  late InteressesPrincipalFunctions interessesPrincipalFunctions;
  late GlobalsStore globalsStore;
  late InteressesStore interessesStore;
  late UsuarioInfos usuarioInfos;
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    interessesPrincipalFunctions =
        Provider.of<InteressesPrincipalFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    interessesStore = Provider.of<InteressesStore>(context);
    usuarioInfos = Provider.of<UsuarioInfos>(context);
    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;
    await interessesPrincipalFunctions.interessesFunctionPrincipal(
        usuarioInfos, interessesStore, widget.interesseModel);
    if (!mounted) return;
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      resizeToAvoidBottomInset: false,
      backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      body: RefreshIndicator(
        color: globalsThemeVar.iGlobalsColors.primaryColor,
        onRefresh: () async {
          interessesStore.setListInteressesClear();
          await interessesPrincipalFunctions.interessesFunctionPrincipal(
              usuarioInfos, interessesStore, widget.interesseModel);
        },
        child: Stack(
          children: [
            Builder(
              builder: (innerContext) {
                return SizedBox(
                  height: MediaQuery.of(innerContext).size.height,
                  width: MediaQuery.of(innerContext).size.width,
                  child: carregando
                      ? GlobalsWidgets(innerContext).loading()
                      : PageInteressesWidget(
                              innerContext, widget.interesseModel.descricao)
                          .principalWidget(
                          innerContext,
                        ),
                );
              },
            ),
            Observer(builder: (_) {
              return Visibility(
                visible: globalsStore.loading,
                child: GlobalsWidgets(context).loading(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
