import 'package:clientepro/model/interesses_model.dart';
import 'package:mobx/mobx.dart';

import '../../../model/cliente_model.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  ObservableList<InteressesModel> listInteresses =
      ObservableList<InteressesModel>();

  @observable
  ObservableList<ClienteModel> listModelMobXClient =
      ObservableList<ClienteModel>();

  @observable
  bool isSelected = false;

  @observable
  bool isSelectedInteresse = false;

  @observable
  ObservableList<Map<String, dynamic>> listImage =
      ObservableList<Map<String, dynamic>>.of([
    {'image': 'assets/interesses/bar.png', 'isSelected': false},
    {'image': 'assets/interesses/esportes.png', 'isSelected': false},
    {'image': 'assets/interesses/filmes.png', 'isSelected': false},
    {'image': 'assets/interesses/games.png', 'isSelected': false},
    {'image': 'assets/interesses/musica.png', 'isSelected': false},
    {'image': 'assets/interesses/serie.png', 'isSelected': false},
    {'image': 'assets/interesses/viajando.png', 'isSelected': false},
  ]);

  @action
  void setAllListModelMobXClient(List<ClienteModel> list) {
    listModelMobXClient.clear();
    listModelMobXClient.addAll(list);
  }

  @action
  void listReloadModelMobXClient() {
    final list = List<ClienteModel>.from(listModelMobXClient);
    listModelMobXClient.clear();
    setAllListModelMobXClient(list);
  }

  @action
  void setListModelMobXClient(ClienteModel ficha) {
    listModelMobXClient.add(ficha);
  }

  @action
  void setListModelMobXClientXClear() {
    listModelMobXClient.clear();
  }

  @action
  void restartSelectedListImage() {
    for (int i = 0; i < listImage.length; i++) {
      listImage[i]['isSelected'] = false;
    }
  }

  @action
  void restartSelectedListInteresse() {
    for (int i = 0; i < listInteresses.length; i++) {
      listInteresses[i].isSelected = false;
    }
  }

  @action
  void setIsSelectedInteresse(bool value, int index) {
    listInteresses[index].isSelected = value;
  }

  @action
  void setIsSelected(bool value, int index) {
    for (int i = 0; i < listImage.length; i++) {
      listImage[i]['isSelected'] = false;
    }
    listImage[index]['isSelected'] = value;
  }

  @action
  void setAllListMobX(List<Map<String, dynamic>> list) {
    listImage.clear();
    listImage.addAll(list);
  }

  @action
  void listReload() {
    final list = List<Map<String, dynamic>>.from(listImage);
    setAllListMobX(list);
  }

  @action
  void setAllListInteresses(List<InteressesModel> listAux) {
    listInteresses.clear();
    listInteresses.addAll(listAux);
  }

  @action
  void listReloadListInteresses() {
    final listAux = List<InteressesModel>.from(listInteresses);
    listInteresses.clear();
    listInteresses.addAll(listAux);
  }

  @action
  void setListInteresses(InteressesModel ficha) {
    listInteresses.add(ficha);
  }

  @action
  void setListInteressesClear() {
    listInteresses.clear();
  }
}
