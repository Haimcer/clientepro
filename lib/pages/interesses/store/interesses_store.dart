import 'package:mobx/mobx.dart';

import '../../../model/cliente_model.dart';

part 'interesses_store.g.dart';

class InteressesStore = _InteressesStore with _$InteressesStore;

abstract class _InteressesStore with Store {
  @observable
  ObservableList<ClienteModel> listInteresses = ObservableList<ClienteModel>();

  @action
  void setAllListInteresses(List<ClienteModel> listAux) {
    listInteresses.clear();
    listInteresses.addAll(listAux);
  }

  @action
  void listReloadListInteresses() {
    final listAux = List<ClienteModel>.from(listInteresses);
    listInteresses.clear();
    listInteresses.addAll(listAux);
  }

  @action
  void setListInteresses(ClienteModel ficha) {
    listInteresses.add(ficha);
  }

  @action
  void setListInteressesClear() {
    listInteresses.clear();
  }
}
