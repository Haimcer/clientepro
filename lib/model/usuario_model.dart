class UsuarioModel {
  String? id;
  String? uid;
  String? nome;
  String? email;

  UsuarioModel({
    this.id,
    this.uid,
    this.nome,
    this.email,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      uid: json['uid'],
      nome: json['nome'],
      email: json['email'],
    );
  }
}
