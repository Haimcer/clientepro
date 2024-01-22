import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../globals/globals_loading_widget.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import 'recovery_widget.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPage();
}

class _RecoveryPage extends State<RecoveryPage> {
  late GlobalsThemeVar globalsThemeVar;
  late GlobalsStore globalsStore;

  bool carregando = true;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() {
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;

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
        backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              carregando
                  ? GlobalsLoadingWidget(context).loagingPageInicio(
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width)
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: RecoveryWidget(context)
                          .recoveryWidgetPrincipal(context),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
