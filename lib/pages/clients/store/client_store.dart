import 'package:clientepro/model/cliente_model.dart';
import 'package:clientepro/model/interesses_model.dart';
import 'package:mobx/mobx.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStore with _$ClientStore;

abstract class _ClientStore with Store {
  @observable
  ObservableList<InteressesModel> listInteresses =
      ObservableList<InteressesModel>();

  @observable
  bool isSelected = false;

  @observable
  bool isEdit = false;

  @observable
  bool isSelectedInteresse = false;

  @observable
  ClienteModel client = ClienteModel(email: '', id: '', nome: '');

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
  void setIsEdit(bool value) => isEdit = value;

  @action
  void setClient(ClienteModel value) => client = value;

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
  void removeListInteresses(int index) {
    listInteresses.removeAt(index);
  }

  @action
  void setListInteressesClear() {
    listInteresses.clear();
  }
}
