const Usuarios = [
  'Todos',
  'Amilton',
  'Selene',
  'Eduardo',
];

class ItemModel {
  String id;
  String descricao;
  double quantidade;
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
