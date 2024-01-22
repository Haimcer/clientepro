import 'package:firebase_auth/firebase_auth.dart';

class UsuarioIds {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  var idToken;
  var uidUser;

  void setIds(idTokenAux, uidUserAux){
    this.idToken = idTokenAux; 
    this.uidUser = uidUserAux;
  }

  Future setRenovaToken() async {
    print("token antigo $idToken");
    final idTokenAux = await _auth.currentUser?.getIdToken();
    print("token nove $idTokenAux");
    
    this.idToken = idTokenAux;
    return idTokenAux;
  }
}