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
    grupo: 'Padaria',
  ),
  ItemModel(
    id: 2,
    descricao: 'Creme de Ricota',
    quantidade: '2',
    usuario: Usuarios[1],
    grupo: 'Frios',
  ),
  ItemModel(
    id: 3,
    descricao: 'Banana caturra',
    quantidade: '1',
    usuario: Usuarios[2],
    grupo: 'Horti',
  ),
  ItemModel(
    id: 4,
    descricao: 'Manteiga',
    quantidade: '2',
    usuario: Usuarios[2],
    grupo: 'Frios',
  ),
  ItemModel(
    id: 5,
    descricao: 'Molico',
    quantidade: '3',
    usuario: Usuarios[3],
    grupo: 'Frios',
  ),
  ItemModel(
    id: 6,
    descricao: 'Pão de batata',
    quantidade: '3',
    usuario: Usuarios[3],
    grupo: 'Padaria',
  ),
  ItemModel(
    id: 6,
    descricao: 'Arroz',
    quantidade: '2 kg',
    usuario: Usuarios[3],
    grupo: 'Outrosx',
  ),
];

// final List<ItemModel> itemsAmilton =
//     items.where((element) => element.usuario == Usuarios.Amilton).toList();
