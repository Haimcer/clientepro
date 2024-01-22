import 'package:clientepro/globals/globals_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../globals/theme_controller.dart';

class ImageGridAlertDialog extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> images;
  final void Function(int, String)? onImageSelected;

  ImageGridAlertDialog({
    required this.title,
    required this.images,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            onImageSelected?.call(index, images[index]['image']);
          },
          child: Observer(builder: (_) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: images[index]['isSelected'] ?? false
                      ? globalsThemeVar.iGlobalsColors.secundaryColor
                      : Colors.transparent,
                  width: 2.0,
                ),
              ),
              elevation: 5.0,
              child: Container(
                margin: EdgeInsets.all(GlobalsSizes().marginSize),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(images[index]['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
