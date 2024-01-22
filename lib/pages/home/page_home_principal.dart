import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/pages/home/options/custom_drawer.dart';
import 'package:clientepro/pages/home/page_home_functions.dart';
import 'package:clientepro/pages/home/page_home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/globals_widgets.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'store/home_store.dart';

class PageHomePrincipal extends StatefulWidget {
  const PageHomePrincipal({super.key});

  @override
  State<PageHomePrincipal> createState() => _PageHomePrincipalState();
}

class _PageHomePrincipalState extends State<PageHomePrincipal> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  late HomePrincipalFunctions homePrincipalFunctions;
  late GlobalsStore globalsStore;
  late HomeStore homeStore;
  late UsuarioInfos usuarioInfos;
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    homeStore = Provider.of<HomeStore>(context);
    usuarioInfos = Provider.of<UsuarioInfos>(context);
    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;
    await homePrincipalFunctions.homeFunctionPrincipal(usuarioInfos, homeStore);
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
      body: Stack(
        children: [
          Builder(
            builder: (innerContext) {
              return SizedBox(
                height: MediaQuery.of(innerContext).size.height,
                width: MediaQuery.of(innerContext).size.width,
                child: carregando
                    ? GlobalsWidgets(innerContext).loading()
                    : PagePrincipalWidget(innerContext)
                        .principalWidget(innerContext),
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
    );
  }
}
