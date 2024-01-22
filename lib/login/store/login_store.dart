import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  bool obscureTextSenha = true ;
  @action
  setObscureTextSenha() => obscureTextSenha = !obscureTextSenha;

  @observable
  bool obscureTextConfSenha = true ;
  @action
  setObscureTextConfSenha() => obscureTextConfSenha = !obscureTextConfSenha;
}