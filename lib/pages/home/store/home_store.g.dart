// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$listInteressesAtom =
      Atom(name: '_HomeStore.listInteresses', context: context);

  @override
  ObservableList<InteressesModel> get listInteresses {
    _$listInteressesAtom.reportRead();
    return super.listInteresses;
  }

  @override
  set listInteresses(ObservableList<InteressesModel> value) {
    _$listInteressesAtom.reportWrite(value, super.listInteresses, () {
      super.listInteresses = value;
    });
  }

  late final _$listModelMobXClientAtom =
      Atom(name: '_HomeStore.listModelMobXClient', context: context);

  @override
  ObservableList<ClienteModel> get listModelMobXClient {
    _$listModelMobXClientAtom.reportRead();
    return super.listModelMobXClient;
  }

  @override
  set listModelMobXClient(ObservableList<ClienteModel> value) {
    _$listModelMobXClientAtom.reportWrite(value, super.listModelMobXClient, () {
      super.listModelMobXClient = value;
    });
  }

  late final _$isSelectedAtom =
      Atom(name: '_HomeStore.isSelected', context: context);

  @override
  bool get isSelected {
    _$isSelectedAtom.reportRead();
    return super.isSelected;
  }

  @override
  set isSelected(bool value) {
    _$isSelectedAtom.reportWrite(value, super.isSelected, () {
      super.isSelected = value;
    });
  }

  late final _$isSelectedInteresseAtom =
      Atom(name: '_HomeStore.isSelectedInteresse', context: context);

  @override
  bool get isSelectedInteresse {
    _$isSelectedInteresseAtom.reportRead();
    return super.isSelectedInteresse;
  }

  @override
  set isSelectedInteresse(bool value) {
    _$isSelectedInteresseAtom.reportWrite(value, super.isSelectedInteresse, () {
      super.isSelectedInteresse = value;
    });
  }

  late final _$listImageAtom =
      Atom(name: '_HomeStore.listImage', context: context);

  @override
  ObservableList<Map<String, dynamic>> get listImage {
    _$listImageAtom.reportRead();
    return super.listImage;
  }

  @override
  set listImage(ObservableList<Map<String, dynamic>> value) {
    _$listImageAtom.reportWrite(value, super.listImage, () {
      super.listImage = value;
    });
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setAllListModelMobXClient(List<ClienteModel> list) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setAllListModelMobXClient');
    try {
      return super.setAllListModelMobXClient(list);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReloadModelMobXClient() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.listReloadModelMobXClient');
    try {
      return super.listReloadModelMobXClient();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListModelMobXClient(ClienteModel ficha) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setListModelMobXClient');
    try {
      return super.setListModelMobXClient(ficha);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListModelMobXClientXClear() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setListModelMobXClientXClear');
    try {
      return super.setListModelMobXClientXClear();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restartSelectedListImage() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.restartSelectedListImage');
    try {
      return super.restartSelectedListImage();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restartSelectedListInteresse() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.restartSelectedListInteresse');
    try {
      return super.restartSelectedListInteresse();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsSelectedInteresse(bool value, int index) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setIsSelectedInteresse');
    try {
      return super.setIsSelectedInteresse(value, index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsSelected(bool value, int index) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setIsSelected');
    try {
      return super.setIsSelected(value, index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllListMobX(List<Map<String, dynamic>> list) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setAllListMobX');
    try {
      return super.setAllListMobX(list);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReload() {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.listReload');
    try {
      return super.listReload();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllListInteresses(List<InteressesModel> listAux) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setAllListInteresses');
    try {
      return super.setAllListInteresses(listAux);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReloadListInteresses() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.listReloadListInteresses');
    try {
      return super.listReloadListInteresses();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListInteresses(InteressesModel ficha) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setListInteresses');
    try {
      return super.setListInteresses(ficha);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListInteressesClear() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setListInteressesClear');
    try {
      return super.setListInteressesClear();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listInteresses: ${listInteresses},
listModelMobXClient: ${listModelMobXClient},
isSelected: ${isSelected},
isSelectedInteresse: ${isSelectedInteresse},
listImage: ${listImage}
    ''';
  }
}
