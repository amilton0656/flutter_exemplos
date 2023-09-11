import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:compras/app_data.dart' as app_data;
import 'package:compras/models/item_model.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

class ItemsProvider with ChangeNotifier {
  final _baseUrl = 'https://compras-home-default-rtdb.firebaseio.com/compras';

  List<ItemModel> items = []; //app_data.items;
  List<ItemModel> itemsUsuario = [];

  Future<List<ItemModel>> loadItems() async {
    items = [];

    final response = await http.get(Uri.parse('$_baseUrl.json'));

    if (jsonDecode(response.body) == null) {
      return [];
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((itemId, itemData) {
      items.add(
        ItemModel(
          id: itemId,
          descricao: itemData['descricao'] as String,
          quantidade: itemData['quantidade'] as double,
          usuario: itemData['usuario'],
          isBought: itemData['isBought'],
        ),
      );
    });

    notifyListeners();
    return items;
  }

  List<ItemModel> getItems(String usuario) {
    if ('Amilton,Selene,Eduardo'.contains(usuario)) {
      itemsUsuario =
          items.where((element) => element.usuario == usuario).toList();
    } else {
      itemsUsuario = items;
    }
    return itemsUsuario;
  }

  Future<void> saveItem(Map<String, Object> registro, String usuario) {
    final hasId = registro['id'] != null;

    final ItemModel item = ItemModel(
      id: hasId ? registro['id'].toString() : Random().nextDouble().toString(),
      descricao: registro['descricao'] as String,
      quantidade: registro['quantidade'] as double,
      usuario: registro['usuario'] as String,
      isBought: registro['isBought'] as bool,
    );

    if (hasId) {
      return updateItem(item);
    } else {
      return addItem(item, usuario);
    }
  }

  Future<void> addItem(ItemModel item, String usuario) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode({
        "descricao": item.descricao,
        "quantidade": item.quantidade,
        "usuario": item.usuario.toString(),
        "isBought": false,
      }),
    );
    final id = jsonDecode(response.body)['name'];
    final ItemModel registro = ItemModel(
      id: id,
      descricao: item.descricao,
      quantidade: item.quantidade,
      usuario: item.usuario,
      isBought: false,
    );
    items.add(registro);
    itemsUsuario.add(registro);
    notifyListeners();
  }

  Future<void> updateItem(ItemModel item) async {
    final index = items.indexWhere((element) => element.id == item.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${item.id}.json'),
        body: jsonEncode({
          "descricao": item.descricao,
          "quantidade": item.quantidade,
        }),
      );

      items[index] = item;
      itemsUsuario[index] = item;
      notifyListeners();
    }
  }

  Future<void> removeItem(String id) async {
    final index = items.indexWhere((element) => element.id == id);
    final indexUsuario = itemsUsuario.indexWhere((element) => element.id == id);

    if (index >= 0) {
      await http.delete(
        Uri.parse('$_baseUrl/$id.json'),
      );
      items.removeWhere((item) => id == item.id);
    }

    if (indexUsuario >= 0) {
      itemsUsuario.removeWhere((item) => id == item.id);
    }

    notifyListeners();
  }

  void itemBought(ItemModel item) async {
    final index = items.indexWhere((element) => element.id == item.id);
    final indexUsuario =
        itemsUsuario.indexWhere((element) => element.id == item.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${item.id}.json'),
        body: jsonEncode({
          "isBought": !item.isBought,
        }),
      );

      items[index].isBought = !items[index].isBought;
      items[index] = item;
      notifyListeners();
    }

    if (indexUsuario >= 0) {
      itemsUsuario[indexUsuario] = item;
    }
    notifyListeners();
  }
}
