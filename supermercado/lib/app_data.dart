import 'package:supermercado/item_model.dart';

const Usuarios = [
  'Todos',
  'Amilton',
  'Selene',
  'Eduardo',
];

List<ItemModel> items = [
  ItemModel(
    id: 1,
    descricao: 'Pão de trigo',
    quantidade: '1',
    usuario: Usuarios[1],
  ),
  ItemModel(
    id: 2,
    descricao: 'Creme de Ricota',
    quantidade: '2',
    usuario: Usuarios[1],
  ),
  ItemModel(
    id: 3,
    descricao: 'Banana caturra',
    quantidade: '1',
    usuario: Usuarios[2],
  ),
  ItemModel(
    id: 4,
    descricao: 'Manteiga',
    quantidade: '2',
    usuario: Usuarios[2],
  ),
  ItemModel(
    id: 5,
    descricao: 'Molico',
    quantidade: '3',
    usuario: Usuarios[3],
  ),
  ItemModel(
    id: 6,
    descricao: 'Pão de batata',
    quantidade: '4',
    usuario: Usuarios[3],
  ),
];

// final List<ItemModel> itemsAmilton =
//     items.where((element) => element.usuario == Usuarios.Amilton).toList();
