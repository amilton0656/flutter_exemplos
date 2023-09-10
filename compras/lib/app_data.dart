import 'package:compras/models/item_model.dart';

List<ItemModel> items = [
  ItemModel(
    id: 'item1',
    descricao: 'Pão de trigo',
    quantidade: 1,
    usuario: Usuarios[1],
  ),
  ItemModel(
    id: 'item2',
    descricao: 'Creme de Ricota',
    quantidade: 2,
    usuario: Usuarios[1],
  ),
  ItemModel(
    id: 'item3',
    descricao: 'Banana caturra',
    quantidade: 1,
    usuario: Usuarios[2],
  ),
  ItemModel(
    id: 'item4',
    descricao: 'Manteiga',
    quantidade: 2,
    usuario: Usuarios[2],
  ),
  ItemModel(
    id: 'item5',
    descricao: 'Molico',
    quantidade: 3,
    usuario: Usuarios[3],
  ),
  ItemModel(
    id: 'item6',
    descricao: 'Pão de batata',
    quantidade: 4,
    usuario: Usuarios[3],
  ),
];

// final List<ItemModel> itemsAmilton =
//     items.where((element) => element.usuario == Usuarios.Amilton).toList();
