import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/app_data.dart' as app_data;

class ItemProvider with ChangeNotifier {
  // final _baseUrl = '';

  List<String> compras = ['feijão', 'arroz', 'carne moída', 'café'];
  List<ItemModel> items = app_data.items;
  List<ItemModel> itemsUsuario = [];

  Future<void> sortCompras() async {
    compras.sort();
  }

  Future<List<ItemModel>> loadItems() async {
    items = app_data.items;

    items.sort((a, b) {
      // Primeiro, comparar pelo campo nome
      int comparacao = a.grupo.compareTo(b.grupo);
      if (comparacao != 0) {
        return comparacao;
      }
      // Se os nomes forem iguais, comparar pelo campo idade
      return a.descricao.compareTo(b.descricao);
    });

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

    // notifyListeners();
    return items;
  } //load

  List<ItemModel> getItems(String usuario) {
    if ('Amilton,Selene,Eduardo'.contains(usuario)) {
      itemsUsuario =
          items.where((element) => element.usuario == usuario).toList();
    } else {
      itemsUsuario = items;
    }
    return itemsUsuario;
  } //getItems

  Future<void> saveItem(Map<String, Object> registro, String usuario) {
    var hasId = registro['id'] != null;

    final ItemModel item = ItemModel(
      id: hasId ? registro['id'] as int : Random().nextInt(5000),
      usuario: registro['usuario'] as String,
      descricao: registro['descricao'] as String,
      quantidade: registro['quantidade'] as String,
      grupo: registro['grupo'] as String,
      isBought: registro['isBought'] as bool,
    );

    if (hasId) {
      return updateItem(item);
    } else {
      return addItem(item, usuario);
    }
  }

  Future<void> addItem(ItemModel item, String usuario) async {
    // final response = await http.post(
    //   Uri.parse('$_baseUrl.json'),
    //   body: jsonEncode({
    //     "descricao": item.descricao,
    //     "quantidade": item.quantidade,
    //     "usuario": item.usuario.toString(),
    //     "isBought": false,
    //   }),
    // );
    // final id = jsonDecode(response.body)['name'];
    final ItemModel registro = ItemModel(
      id: item.id,
      usuario: item.usuario,
      descricao: item.descricao,
      quantidade: item.quantidade,
      grupo: item.grupo,
      isBought: false,
    );
    items.add(registro);
    itemsUsuario.add(registro);
    if (!compras.contains(item.descricao)) {
      compras.add(item.descricao);
    }
    notifyListeners();
  }

  Future<void> updateItem(ItemModel item) async {
    final index = items.indexWhere((element) => element.id == item.id);
    final indexUsuario =
        itemsUsuario.indexWhere((element) => element.id == item.id);

    // if (index >= 0) {
    //   await http.patch(
    //     Uri.parse('$_baseUrl/${item.id}.json'),
    //     body: jsonEncode({
    //       "descricao": item.descricao,
    //       "quantidade": item.quantidade,
    //     }),
    //   );

    items[index] = item;
    itemsUsuario[indexUsuario] = item;
    notifyListeners();
  }

  void itemBought(ItemModel item) async {
    final index = items.indexWhere((element) => element.id == item.id);
    final indexUsuario =
        itemsUsuario.indexWhere((element) => element.id == item.id);

    if (index >= 0) {
      //   await http.patch(
      //     Uri.parse('$_baseUrl/${item.id}.json'),
      //     body: jsonEncode({
      //       "isBought": !item.isBought,
      //     }),
      //   );

      items[index].isBought = !items[index].isBought;
      items[index] = item;
      notifyListeners();
    }

    if (indexUsuario >= 0) {
      itemsUsuario[indexUsuario] = item;
    }
    notifyListeners();
  }

  Future<void> removeItem(int id) async {
    final index = items.indexWhere((element) => element.id == id);
    final indexUsuario = itemsUsuario.indexWhere((element) => element.id == id);

    if (index >= 0) {
      // await http.delete(
      //   Uri.parse('$_baseUrl/$id.json'),
      // );
      items.removeWhere((item) => id == item.id);
    }

    if (indexUsuario >= 0) {
      itemsUsuario.removeWhere((item) => id == item.id);
    }

    notifyListeners();
  }

  Future<void> removeHistorico(String descricao) async {
    final indexCompras = compras.indexWhere((element) => element == descricao);

    if (indexCompras >= 0) {
      // await http.delete(
      //   Uri.parse('$_baseUrl/$id.json'),
      // );
      compras.removeWhere((item) => descricao == item);
    }

    notifyListeners();
  }

} //class
