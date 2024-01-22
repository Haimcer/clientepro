class InteressesModel {
  final String id;
  final String descricao;
  final String? pathImage;
  bool? isSelected;

  InteressesModel(
      {required this.id,
      required this.descricao,
      this.pathImage,
      this.isSelected});

  factory InteressesModel.fromJson(Map<String, dynamic> json) {
    return InteressesModel(
      id: json['id'] ?? '',
      descricao: json['descricao'] ?? '',
      pathImage: json['pathimage'],
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'pathimage': pathImage,
    };
  }
}
