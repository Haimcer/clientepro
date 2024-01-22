import 'dart:math';

import 'package:clientepro/globals/globals_sizes.dart';
import 'package:clientepro/globals/globals_styles.dart';
import 'package:flutter/material.dart';

import '../model/interesses_model.dart';

class CustomCard {
  BuildContext context;
  CustomCard(this.context);

  Widget cardLateral(
    BuildContext context, {
    String? name,
    List<InteressesModel>? interesses,
  }) {
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

    String getDescricaocard() {
      String stringInteresses = '';
      if (interesses == null) {
        return '';
      } else {
        for (var j = 0; j < interesses.length; j++) {
          if (interesses.isNotEmpty) {
            if (interesses.length - 1 == j) {
              interesses[j].descricao != 'null'
                  ? stringInteresses += '${interesses[j].descricao}'
                  : '';
            } else {
              interesses[j].descricao != 'null'
                  ? stringInteresses += '${interesses[j].descricao} - '
                  : '';
            }
          }
        }
        return stringInteresses;
      }
    }

    String descricaoCard = getDescricaocard();
    String corAleatoria = getRandomColor();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GlobalsSizes().borderSize),
      ),
      elevation: 5.0,
      child: Row(
        children: [
          SizedBox(width: GlobalsSizes().marginSize / 3),
          Container(
            margin: EdgeInsets.all(GlobalsSizes().marginSize / 2),
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalsSizes().borderSize),
              image: DecorationImage(
                image: NetworkImage(
                    "https://ui-avatars.com/api/?name=$name&background=${corAleatoria}&color=FFFFFF"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(GlobalsSizes().marginSize / 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    name ?? '',
                    style: GlobalsStyles(context).styleTitleAlternative,
                  ),
                  SizedBox(height: GlobalsSizes().marginSize / 2),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    descricaoCard,
                    style: GlobalsStyles(context).styleMedio,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
