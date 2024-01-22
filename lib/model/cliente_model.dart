import 'interesses_model.dart';

class ClienteModel {
  final String id;
  final String nome;
  final String email;
  final List<InteressesModel>? interesse;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.email,
    this.interesse,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? interessesJson = json['interesses'];
    List<InteressesModel>? interesses;

    if (interessesJson != null) {
      interesses = interessesJson
          .map((interesse) => InteressesModel.fromJson(interesse))
          .toList();
    }

    return ClienteModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      interesse: interesses,
    );
  }
}
