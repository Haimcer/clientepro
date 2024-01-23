import 'package:clientepro/globals/globals_buttons.dart';
import 'package:clientepro/globals/globals_cards.dart';
import 'package:clientepro/globals/globals_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/globals_widgets.dart';
import '../clients/page_clients_principal.dart';
import 'store/interesses_store.dart';

class PageInteressesWidget {
  BuildContext context;
  String? title;
  PageInteressesWidget(this.context, this.title);

  Widget principalWidget(BuildContext contextAux) {
    final interessesStore = Provider.of<InteressesStore>(context);
    final sizeMediaQ = MediaQuery.of(context).size;

    return SizedBox(
      height: sizeMediaQ.height,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // AppBar
              GlobalsWidgets(context).appBarDescTitulo(
                context,
                descTitulo: 'Detalhes',
                titulo: title ?? 'Clientes',
                prefixWidget: Container(
                  margin: EdgeInsets.only(top: GlobalsSizes().marginSize / 2),
                  child: GlobalsButtons(context)
                      .btnVoltarFundo(context, corFundo: Colors.transparent),
                ),
              ),
              SizedBox(
                height: GlobalsSizes().marginSize / 2,
              ),

              SizedBox(
                height: sizeMediaQ.height / 1.5,
                child: interessesStore.listInteresses.isEmpty
                    ? GlobalsWidgets(context).imgEmpty()
                    : ListView.builder(
                        itemCount: interessesStore.listInteresses.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: GlobalsSizes().marginSize),
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PageClientsPrincipal(
                                    clienteSelecionado:
                                        interessesStore.listInteresses[index],
                                  ),
                                ),
                              ),
                              child: CustomCard(context).cardLateral(
                                context,
                                interesses: interessesStore
                                    .listInteresses[index].interesse,
                                name:
                                    interessesStore.listInteresses[index].nome,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
