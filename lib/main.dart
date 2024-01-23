import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/usuario_ids.dart';
import 'controllers/usuario_infos.dart';
import 'globals/globals_functions.dart';
import 'globals/globals_loading_widget.dart';
import 'globals/globals_local_storage.dart';
import 'globals/globlas_alert.dart';
import 'globals/store/globals_store.dart';
import 'globals/theme_controller.dart';
import 'login/login_functions.dart';
import 'login/login_page.dart';
import 'login/logar/logar_functions.dart';
import 'login/logar/recovery/recovery_functions.dart';
import 'login/signIn/signIn_functions.dart';
import 'login/store/login_store.dart';
import 'model/usuario_model.dart';
import 'pages/clients/page_clients_functions.dart';
import 'pages/clients/store/client_store.dart';
import 'pages/home/page_home_functions.dart';
import 'pages/home/page_home_principal.dart';
import 'pages/home/store/home_store.dart';
import 'pages/interesses/page_interesses_functions.dart';
import 'pages/interesses/store/interesses_store.dart';
import 'pages/introduction/introduction_page.dart';
import 'request/usuario/get_usuario_by_id.dart';
import 'request/usuario/post_usuario.dart';
import 'tela_error/tela_error.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return TelaErroPage(
      text:
          'Ops!\n ${details.exception}\n\n Dica:\n Reabra o app novamente para continuar utilizando',
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<GlobalsThemeVar>(create: (context) => GlobalsThemeVar()),
        Provider<GlobalsStore>(create: (context) => GlobalsStore()),
        Provider<SignInFunctions>(
            create: (context) => SignInFunctions(context)),
        Provider<UsuarioIds>(create: (context) => UsuarioIds()),
        Provider<LogarFunctions>(create: (context) => LogarFunctions(context)),
        Provider<UsuarioInfos>(create: (context) => UsuarioInfos()),
        Provider<RecoveryFunctions>(
            create: (context) => RecoveryFunctions(context)),
        Provider<LoginStore>(create: (context) => LoginStore()),
        Provider<HomePrincipalFunctions>(
            create: (context) => HomePrincipalFunctions(context)),
        Provider<InteressesPrincipalFunctions>(
            create: (context) => InteressesPrincipalFunctions(context)),
        Provider<ClientsPrincipalFunctions>(
            create: (context) => ClientsPrincipalFunctions(context)),
        Provider<HomeStore>(create: (context) => HomeStore()),
        Provider<InteressesStore>(create: (context) => InteressesStore()),
        Provider<ClientStore>(create: (context) => ClientStore()),
        Provider<LoginFunctions>(
          create: (context) => LoginFunctions(context),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalsThemeVar>(
          create: (context) => GlobalsThemeVar(),
        ),
        ChangeNotifierProvider<UsuarioInfos>(
          create: (context) => UsuarioInfos(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GlobalsThemeVar globalsThemeVar;
  late UsuarioIds usuarioIds;
  late UsuarioInfos usuarioInfos;
  late SharedPreferences prefs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() {
    if (!entrouIniciaPage) {
      globalsThemeVar = context.read<GlobalsThemeVar>();
      usuarioIds = context.read<UsuarioIds>();
      usuarioInfos = context.read<UsuarioInfos>();

      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future<void> _iniciaPage() async {
    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(context).alertWarning(
        context,
        onTap: () {
          SystemNavigator.pop();
        },
        text:
            "Ops! Parece que você está sem conexão com a internet. \nPor favor, verifique sua conexão e tente novamente.",
      );
      return;
    }

    prefs = await SharedPreferences.getInstance();
    entrouIniciaPage = true;

    await _iniciaTheme();
    await _entrarNoApp();
  }

  Future<void> _iniciaTheme() async {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;

    final int? temaApp = prefs.getInt('theme');
    print("TEMA APP: $temaApp");

    if (!mounted) return;

    setState(() {
      globalsThemeVar.currentThemeMode = temaApp == null
          ? brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light
          : temaApp == 0
              ? ThemeMode.light
              : ThemeMode.dark;
      globalsThemeVar.setIGlobalsColors();
    });
  }

  Future<void> _entrarNoApp() async {
    User? user = _auth.currentUser;
    bool isViewed = await GlobalsLocalStorage().isPageViewed('introduction');
    print('AAAAAAAAAAA');
    print(user);

    if (await GlobalsFunctions().verificaConexao()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              isViewed ? PageHomePrincipal() : const Introduction()));
      return;
    } else {
      if (user != null) {
        try {
          final idToken = await user.getIdToken();
          final uidUser = await user.uid;

          usuarioIds.setIds(idToken, uidUser);

          var dadosUser = await GetUsuarioById()
              .getUsuarioById(context, uid: usuarioIds.uidUser);

          if (dadosUser == null || dadosUser == '' || dadosUser == "null") {
            var jsonUsuarioPost = await PostUsuario().postUsuario(
              context,
              nome: user.displayName,
              email: user.email,
              uid: uidUser,
            );

            if (jsonUsuarioPost != null) {
              usuarioInfos
                  .setUsuarioModel(UsuarioModel.fromJson(jsonUsuarioPost));
            }

            Navigator.of(context).push(MaterialPageRoute(
                builder: (_context) =>
                    isViewed ? PageHomePrincipal() : const Introduction()));
            return;
          } else {
            usuarioInfos.setUsuarioModel(UsuarioModel.fromJson(dadosUser));
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_context) =>
                    isViewed ? PageHomePrincipal() : const Introduction()));
            return;
          }
        } catch (err) {
          print("Erro ao tentar autenticar ou obter usuário: $err");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  isViewed ? PageHomePrincipal() : const Introduction()));
          return;
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                isViewed ? LoginPage() : const Introduction()));
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalsLoadingWidget(context).loagingPageInicio(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width,
      ),
    );
  }
}
