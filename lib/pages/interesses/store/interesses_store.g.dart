// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interesses_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InteressesStore on _InteressesStore, Store {
  late final _$listInteressesAtom =
      Atom(name: '_InteressesStore.listInteresses', context: context);

  @override
  ObservableList<ClienteModel> get listInteresses {
    _$listInteressesAtom.reportRead();
    return super.listInteresses;
  }

  @override
  set listInteresses(ObservableList<ClienteModel> value) {
    _$listInteressesAtom.reportWrite(value, super.listInteresses, () {
      super.listInteresses = value;
    });
  }

  late final _$_InteressesStoreActionController =
      ActionController(name: '_InteressesStore', context: context);

  @override
  void setAllListInteresses(List<ClienteModel> listAux) {
    final _$actionInfo = _$_InteressesStoreActionController.startAction(
        name: '_InteressesStore.setAllListInteresses');
    try {
      return super.setAllListInteresses(listAux);
    } finally {
      _$_InteressesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReloadListInteresses() {
    final _$actionInfo = _$_InteressesStoreActionController.startAction(
        name: '_InteressesStore.listReloadListInteresses');
    try {
      return super.listReloadListInteresses();
    } finally {
      _$_InteressesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListInteresses(ClienteModel ficha) {
    final _$actionInfo = _$_InteressesStoreActionController.startAction(
        name: '_InteressesStore.setListInteresses');
    try {
      return super.setListInteresses(ficha);
    } finally {
      _$_InteressesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListInteressesClear() {
    final _$actionInfo = _$_InteressesStoreActionController.startAction(
        name: '_InteressesStore.setListInteressesClear');
    try {
      return super.setListInteressesClear();
    } finally {
      _$_InteressesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listInteresses: ${listInteresses}
    ''';
  }
}
