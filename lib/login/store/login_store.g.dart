// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  late final _$obscureTextSenhaAtom =
      Atom(name: '_LoginStoreBase.obscureTextSenha', context: context);

  @override
  bool get obscureTextSenha {
    _$obscureTextSenhaAtom.reportRead();
    return super.obscureTextSenha;
  }

  @override
  set obscureTextSenha(bool value) {
    _$obscureTextSenhaAtom.reportWrite(value, super.obscureTextSenha, () {
      super.obscureTextSenha = value;
    });
  }

  late final _$obscureTextConfSenhaAtom =
      Atom(name: '_LoginStoreBase.obscureTextConfSenha', context: context);

  @override
  bool get obscureTextConfSenha {
    _$obscureTextConfSenhaAtom.reportRead();
    return super.obscureTextConfSenha;
  }

  @override
  set obscureTextConfSenha(bool value) {
    _$obscureTextConfSenhaAtom.reportWrite(value, super.obscureTextConfSenha,
        () {
      super.obscureTextConfSenha = value;
    });
  }

  late final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase', context: context);

  @override
  dynamic setObscureTextSenha() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setObscureTextSenha');
    try {
      return super.setObscureTextSenha();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setObscureTextConfSenha() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setObscureTextConfSenha');
    try {
      return super.setObscureTextConfSenha();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscureTextSenha: ${obscureTextSenha},
obscureTextConfSenha: ${obscureTextConfSenha}
    ''';
  }
}
