class ItemModel {
  int id;
  String usuario;
  String descricao;
  String quantidade;
  String grupo;
  bool isbought;

  ItemModel({
    required this.id,
    required this.usuario,
    required this.descricao,
    required this.quantidade,
    this.grupo = "Outros",
    this.isbought = false,
  });
}

