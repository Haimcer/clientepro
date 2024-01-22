import 'package:clientepro/globals/globals_form.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/request/relacoes/post_interesses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:clientepro/pages/home/store/home_store.dart';
import '../../../globals/store/globals_store.dart';
import '../../../globals/theme_controller.dart';
import '../options/grid_image_interesse.dart';

class AddInterest {
  TextEditingController titleController = TextEditingController();

  Widget buildAddInterestWidget(BuildContext context) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    final homestore = Provider.of<HomeStore>(context, listen: false);
    final globalsStore = Provider.of<GlobalsStore>(context);
    var path = '';
    homestore.restartSelectedListImage();

    return AlertDialog(
      title: Center(
        child: Text('Adicionar Interesse',
            style: GlobalsStyles(context).styleSubtitle),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.all(GlobalsSizes().marginSize / 2),
                  child: GlobalsForm(context).campoTextFieldTexto(
                      titleController, 'Digite o nome do interesse')),
              SizedBox(height: GlobalsSizes().marginSize),
              Text('Escolha uma imagem',
                  style: GlobalsStyles(context).styleMedio),
              SizedBox(height: GlobalsSizes().marginSize / 2),
              Observer(builder: (_) {
                return ImageGridAlertDialog(
                  title: 'Selecione uma imagem',
                  images: homestore.listImage,
                  onImageSelected: (int index, String imagePath) {
                    homestore.setIsSelected(true, index);
                    homestore.listReload();
                    path = imagePath;
                  },
                );
              }),
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
            'Fechar',
            style:
                TextStyle(color: globalsThemeVar.iGlobalsColors.textColorFraco),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            globalsStore.setLoading(true);
            await PostInteresses().postInteresses(context,
                title: titleController.text, path: path);
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
                  'Adicionar',
                  style: TextStyle(
                      color: globalsThemeVar
                          .iGlobalsColors.textColorPrimaryInverse),
                ),
        ),
      ],
    );
  }
}
