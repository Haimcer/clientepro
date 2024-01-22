import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:clientepro/model/interesses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../globals/theme_controller.dart';

class ImageClienteGridAlertDialog extends StatelessWidget {
  final String title;
  final List<InteressesModel> images;
  final void Function(int, String)? onImageSelected;

  ImageClienteGridAlertDialog({
    required this.title,
    required this.images,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return SingleChildScrollView(
      child: Container(
        height: 200, // Altura desejada para o GridView
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.9,
          ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                onImageSelected?.call(index, images[index].id);
              },
              child: Observer(builder: (_) {
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: images[index].isSelected ?? false
                              ? globalsThemeVar.iGlobalsColors.secundaryColor
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      elevation: 5.0,
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.all(GlobalsSizes().marginSize),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(images[index].pathImage ??
                                'assets/interesses/foto.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        images[index].descricao,
                        style: GlobalsStyles(context).styleMenor,
                      ),
                    )
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
