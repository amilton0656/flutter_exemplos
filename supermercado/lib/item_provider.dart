import 'package:flutter/material.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/app_data.dart' as app_data;

class ItemProvider with ChangeNotifier {
  final _baseUrl = '';

  List<ItemModel> items = app_data.items;
  List<ItemModel> itemsUsuario = [];

  Future<List<ItemModel>> loadItems() async {
    items = app_data.items;

    // final response = await http.get(Uri.parse('$_baseUrl.json'));

    // if (jsonDecode(response.body) == null) {
    //   return [];
    // }

    // Map<String, dynamic> data = jsonDecode(response.body);
    // data.forEach((itemId, itemData) {
    //   items.add(
    //     ItemModel(
    //       id: itemId,
    //       descricao: itemData['descricao'] as String,
    //       quantidade: itemData['quantidade'] as double,
    //       usuario: itemData['usuario'],
    //       isBought: itemData['isBought'],
    //     ),
    //   );
    // });

    notifyListeners();
    return items;
  }

  List<ItemModel> getItems(String usuario) {
    notifyListeners();
    return [];
  }

  Future<void> saveItem(Map<String, Object> registro, String usuario) async {}

  void itemBought(ItemModel item) async {
    // final index = items.indexWhere((element) => element.id == item.id);
    // final indexUsuario =
    //     itemsUsuario.indexWhere((element) => element.id == item.id);

    // if (index >= 0) {
    //   await http.patch(
    //     Uri.parse('$_baseUrl/${item.id}.json'),
    //     body: jsonEncode({
    //       "isBought": !item.isBought,
    //     }),
    //   );

    //   items[index].isBought = !items[index].isBought;
    //   items[index] = item;
    //   notifyListeners();
    // }

    // if (indexUsuario >= 0) {
    //   itemsUsuario[indexUsuario] = item;
    // }
    notifyListeners();
  }

  Future<void> removeItem(int id) async {}
}
