import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../globals/globals_loading_widget.dart';
import '../globals/store/globals_store.dart';
import '../globals/theme_controller.dart';
import 'login_functions.dart';
import 'login_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, this.isReturnPage = false});

  bool isReturnPage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginFunctions loginFunctions;
  late GlobalsThemeVar globalsThemeVar;
  late GlobalsStore globalsStore;

  bool carregando = true;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() {
    loginFunctions = Provider.of<LoginFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;

    await loginFunctions.loginFunctionsPrincipal(widget.isReturnPage);

    if (!mounted) return;
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              carregando
                  ? GlobalsLoadingWidget(context).loagingPageInicio(
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width)
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: LoginWidget(context).loginWidgetPrincipal()),
              Observer(builder: (_) {
                return Visibility(
                    visible: globalsStore.loading || carregando,
                    child: GlobalsLoadingWidget(context).loagingPageInicio(
                        MediaQuery.of(context).size.height,
                        MediaQuery.of(context).size.width));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
