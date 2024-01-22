import 'package:clientepro/globals/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'globals_sizes.dart';
import 'globals_widgets.dart';

class GlobalsForm {
  BuildContext context;
  GlobalsForm(this.context);

  Widget campoTextFieldTexto(TextEditingController controller, hintText,
      {Widget? prefixIcon,
      Widget? suffixIcon,
      Color? corBorda,
      int? maxLines,
      bool isSombreado = true,
      void Function()? functionSuffix,
      onChanged,
      TextInputType? textInputType}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      //margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: globalsThemeVar.iGlobalsColors.tertiaryColor,
        borderRadius:
            BorderRadius.all(Radius.circular(GlobalsSizes().borderSize)),
        boxShadow: [
          isSombreado
              ? GlobalsWidgets(context).sombreadoBoxShadow()
              : BoxShadow(),
        ],
        border: Border.all(
            color: corBorda ?? Colors.transparent,
            style: BorderStyle.solid,
            width: corBorda == null ? 0 : 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            maxLines: maxLines,
            keyboardType: textInputType,
            style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.textColorForte,
                fontSize: GlobalsSizes().sizeTextMedio),
            decoration: prefixIcon == null && suffixIcon == null
                ? InputDecoration(
                    border: InputBorder.none,
                    hintText: '$hintText',
                    hintStyle: TextStyle(
                      color: globalsThemeVar.iGlobalsColors.textColorFraco,
                    ),
                  )
                : suffixIcon == null
                    ? InputDecoration(
                        border: InputBorder.none,
                        hintText: '$hintText',
                        hintStyle: TextStyle(
                          color: globalsThemeVar.iGlobalsColors.textColorFraco,
                        ),
                        prefixIcon: prefixIcon,
                        prefixIconColor:
                            globalsThemeVar.iGlobalsColors.textColorFraco,
                      )
                    : InputDecoration(
                        border: InputBorder.none,
                        hintText: '$hintText',
                        hintStyle: TextStyle(
                          color: globalsThemeVar.iGlobalsColors.textColorFraco,
                        ),
                        prefixIcon: prefixIcon,
                        prefixIconColor:
                            globalsThemeVar.iGlobalsColors.textColorFraco,
                        suffixIcon: GestureDetector(
                            onTap: functionSuffix ?? () {}, child: suffixIcon),
                        suffixIconColor:
                            globalsThemeVar.iGlobalsColors.secundaryColor,
                      ),
            onChanged: onChanged ??
                (_value) {
                  // print(controller.text);
                  //print(loginFunctions.loginController.text);
                },
            controller: controller,
          ),
        ],
      ),
    );
  }
}
