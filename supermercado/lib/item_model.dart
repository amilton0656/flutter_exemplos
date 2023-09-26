class ItemModel {
  int id;
  String usuario;
  String descricao;
  String quantidade;
  String grupo;
  bool isBought;

  ItemModel({
    required this.id,
    required this.usuario,
    required this.descricao,
    required this.quantidade,
    this.grupo = "Outros",
    this.isBought = false,
  });
}
