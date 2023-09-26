class ItemModel {
  int id;
  String descricao;
  String quantidade;
  String usuario;
  bool isBought;

  ItemModel({
    required this.id,
    required this.descricao,
    required this.quantidade,
    required this.usuario,
    this.isBought = false,
  });
}
