import 'package:clientepro/controllers/usuario_infos.dart';
import 'package:clientepro/globals/globals_form.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/globals/globals_users_widget.dart';
import 'package:clientepro/model/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globlas_alert.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import '../../../request/usuario/patch_usuario.dart';

class EditPerfil {
  TextEditingController nomeController = TextEditingController();

  Widget buildEditPerfilWidget(BuildContext context) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    final usurioInfos = Provider.of<UsuarioInfos>(context, listen: false);
    final globalsStore = Provider.of<GlobalsStore>(context);

    return AlertDialog(
      title: Center(
        child: Column(
          children: [
            GlobalsUsersWidget(context)
                .imgPerfilUser(user: usurioInfos.usuarioModel),
            SizedBox(height: GlobalsSizes().marginSize),
            Text('Editar Perfil', style: GlobalsStyles(context).styleSubtitle),
          ],
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome', style: GlobalsStyles(context).styleMenor),
                      SizedBox(height: GlobalsSizes().marginSize / 4),
                      GlobalsForm(context).campoTextFieldTexto(
                          nomeController, usurioInfos.usuarioModel?.nome),
                    ],
                  )),
              SizedBox(height: GlobalsSizes().marginSize),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: GlobalsSizes().marginSize,
        vertical: GlobalsSizes().marginSize,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style:
                TextStyle(color: globalsThemeVar.iGlobalsColors.textColorFraco),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (nomeController.text == '') {
              GlobalsAlert(context).alertWarning(context,
                  text:
                      'Nome ou email estão vazios por favor verifique os dados!');
              return;
            }
            globalsStore.setLoading(true);
            var result = await PatchUsuario().patchUsuario(
              context,
              usurioInfos.usuarioModel?.id ?? '',
              nome: nomeController.text,
            );
            if (result != null) {
              UsuarioModel usuario = UsuarioModel.fromJson(result);
              usurioInfos.setUsuarioModel(usuario);
            }
            globalsStore.setLoading(false);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              globalsThemeVar.iGlobalsColors.secundaryColor,
            ),
          ),
          child: globalsStore.loading
              ? Container(
                  child: SizedBox(
                    height: GlobalsSizes().marginSize,
                    width: GlobalsSizes().marginSize,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: globalsThemeVar
                            .iGlobalsColors.textColorPrimaryInverse,
                      ),
                    ),
                  ),
                )
              : Text(
                  'Salvar',
                  style: TextStyle(
                      color: globalsThemeVar
                          .iGlobalsColors.textColorPrimaryInverse),
                ),
        ),
      ],
    );
  }
}
