import 'dart:math';

import 'package:clientepro/globals/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/usuario_infos.dart';
import '../model/usuario_model.dart';

class GlobalsUsersWidget {
  BuildContext context;
  GlobalsUsersWidget(this.context);

  Widget imgPerfilUser({
    double? sizeImg,
    VoidCallback? onTap,
    String? imageUser,
    bool? otherImgae,
    UsuarioModel? user,
    bool? exibirImagem,
  }) {
    final usuarioInfos = Provider.of<UsuarioInfos>(context);
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: sizeImg ?? 40,
          width: sizeImg ?? 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: globalsThemeVar.iGlobalsColors.primaryColor,
              border: Border.all(
                color: globalsThemeVar.iGlobalsColors.tertiaryColor,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(500)),
            child: Image.network(
              "https://ui-avatars.com/api/?name=${user?.nome == 'null' || user?.nome == null ? usuarioInfos.usuarioModel?.nome : user?.nome}&background=${globalsThemeVar.iGlobalsColors.colorBackgroundImage}&color=FFFFFF",
              fit: BoxFit.cover,
            ),
          )),
    );
  }

  Widget imgNameUser(double sizeText,
      {String? networkImage,
      double? sizeTextName,
      String? nome,
      Color? color}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Row(
      children: [
        Container(
            height: sizeText,
            width: sizeText,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: globalsThemeVar.iGlobalsColors.primaryColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(500)),
              child: Image.network(
                "https://ui-avatars.com/api/?name=$nome&background=${globalsThemeVar.iGlobalsColors.colorBackgroundImage}&color=FFFFFF",
                fit: BoxFit.cover,
              ),
            )),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  nome == 'null' || nome == null ? '' : nome,
                  style: TextStyle(color: color, fontSize: sizeTextName),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget imgRedondaUser(double size,
      {String? networkImage, String? nome, bool? borda, bool? colorborda}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    print(globalsThemeVar.iGlobalsColors.colorBackgroundImage);
    String getRandomColor() {
      final List<String> coresHex = [
        'E379BD',
        '5Eb0E5',
        '8CD790',
        'f5A623',
        '57606F',
        '4CAF50',
        '673AB7',
        '2196F3',
        'FF9800',
        'F44336',
      ];

      final Random random = Random();
      String corEscolhida = coresHex[random.nextInt(coresHex.length)];

      return corEscolhida;
    }

    String corAleatoria = getRandomColor();
    print(corAleatoria); // Exibe a cor hexadecimal aleatória escolhida
    return Row(
      children: [
        Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              border: borda == true
                  ? Border.all(
                      width: 5.2,
                      color: colorborda ??
                          globalsThemeVar.iGlobalsColors.tertiaryColor)
                  : Border.all(),
              shape: BoxShape.circle,
              color: globalsThemeVar.iGlobalsColors.primaryColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(500)),
              child: Image.network(
                "https://ui-avatars.com/api/?name=$nome&background=${corAleatoria}&color=FFFFFF",
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }
}
