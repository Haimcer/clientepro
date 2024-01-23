// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClientStore on _ClientStore, Store {
  late final _$listInteressesAtom =
      Atom(name: '_ClientStore.listInteresses', context: context);

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

  late final _$isSelectedAtom =
      Atom(name: '_ClientStore.isSelected', context: context);

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

  late final _$isEditAtom = Atom(name: '_ClientStore.isEdit', context: context);

  @override
  bool get isEdit {
    _$isEditAtom.reportRead();
    return super.isEdit;
  }

  @override
  set isEdit(bool value) {
    _$isEditAtom.reportWrite(value, super.isEdit, () {
      super.isEdit = value;
    });
  }

  late final _$isSelectedInteresseAtom =
      Atom(name: '_ClientStore.isSelectedInteresse', context: context);

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

  late final _$clientAtom = Atom(name: '_ClientStore.client', context: context);

  @override
  ClienteModel get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(ClienteModel value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

  late final _$listImageAtom =
      Atom(name: '_ClientStore.listImage', context: context);

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

  late final _$_ClientStoreActionController =
      ActionController(name: '_ClientStore', context: context);

  @override
  void setIsEdit(bool value) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setIsEdit');
    try {
      return super.setIsEdit(value);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClient(ClienteModel value) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setClient');
    try {
      return super.setClient(value);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restartSelectedListImage() {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.restartSelectedListImage');
    try {
      return super.restartSelectedListImage();
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restartSelectedListInteresse() {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.restartSelectedListInteresse');
    try {
      return super.restartSelectedListInteresse();
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsSelectedInteresse(bool value, int index) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setIsSelectedInteresse');
    try {
      return super.setIsSelectedInteresse(value, index);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsSelected(bool value, int index) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setIsSelected');
    try {
      return super.setIsSelected(value, index);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllListMobX(List<Map<String, dynamic>> list) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setAllListMobX');
    try {
      return super.setAllListMobX(list);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReload() {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.listReload');
    try {
      return super.listReload();
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllListInteresses(List<InteressesModel> listAux) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setAllListInteresses');
    try {
      return super.setAllListInteresses(listAux);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReloadListInteresses() {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.listReloadListInteresses');
    try {
      return super.listReloadListInteresses();
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListInteresses(InteressesModel ficha) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setListInteresses');
    try {
      return super.setListInteresses(ficha);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeListInteresses(int index) {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.removeListInteresses');
    try {
      return super.removeListInteresses(index);
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListInteressesClear() {
    final _$actionInfo = _$_ClientStoreActionController.startAction(
        name: '_ClientStore.setListInteressesClear');
    try {
      return super.setListInteressesClear();
    } finally {
      _$_ClientStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listInteresses: ${listInteresses},
isSelected: ${isSelected},
isEdit: ${isEdit},
isSelectedInteresse: ${isSelectedInteresse},
client: ${client},
listImage: ${listImage}
    ''';
  }
}
