import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supermercado/item_historico.dart';
import 'package:supermercado/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:supermercado/app_data.dart' as app_data;

class ItemProvider with ChangeNotifier {
  final _baseUrl = 'http://amilton.com.br/api';
  // final _baseUrl = 'http://192.168.1.81:21276';

  List<HistoricoModel> compras = [
    HistoricoModel(id: 1, descricao: 'Arroz'),
    HistoricoModel(id: 1, descricao: 'Feijão'),
    HistoricoModel(id: 1, descricao: 'Café'),
    HistoricoModel(id: 1, descricao: 'Leite em pó'),
    HistoricoModel(id: 1, descricao: 'Pão de trigo'),
  ];
  List<ItemModel> items = app_data.items;
  List<ItemModel> itemsUsuario = [];

  Future<void> sortCompras() async {
    compras.sort((a, b) {
      return a.descricao.compareTo(b.descricao);
    });
  }

  Future<List<ItemModel>> loadItems() async {
    items = []; //app_data.items;

    final url = Uri.parse('$_baseUrl/mktitem');

    try {
      final response = await http.get(url);
      // print(response.body);

      final data = jsonDecode(response.body);

      data.forEach((itemData) {
        items.add(
          ItemModel(
            id: itemData['id'],
            usuario: itemData['usuario'] ?? '',
            descricao: itemData['descricao'] ?? '',
            quantidade: itemData['quantidade'] ?? '',
            grupo: itemData['grupo'] ?? '',
            isbought: itemData['isbought'] == 0 ? false : true,
          ),
        );
      });
      items.sort((a, b) {
        // Primeiro, comparar pelo campo nome
        int comparacao = a.grupo.compareTo(b.grupo);
        if (comparacao != 0) {
          return comparacao;
        }
        // Se os nomes forem iguais, comparar pelo campo idade
        return a.descricao.compareTo(b.descricao);
      });
    } catch (err) {
      print('');
    }

    items.sort((a, b) {
      // Primeiro, comparar pelo campo nome
      int comparacao = a.grupo.compareTo(b.grupo);
      if (comparacao != 0) {
        return comparacao;
      }
      // Se os nomes forem iguais, comparar pelo campo idade
      return a.descricao.compareTo(b.descricao);
    });
    notifyListeners();
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

  Future<bool> saveItem(Map<String, Object> registro, String usuario) {
    var hasId = registro['id'] != null;

    final ItemModel item = ItemModel(
      id: hasId ? registro['id'] as int : Random().nextInt(5000),
      usuario: registro['usuario'] as String,
      descricao: registro['descricao'] as String,
      quantidade: registro['quantidade'] as String,
      grupo: registro['grupo'] as String,
      isbought: registro['isBought'] as bool,
    );

    if (hasId) {
      return updateItem(item);
    } else {
      return addItem(item, usuario);
    }
  }

  Future<bool> addItem(ItemModel item, String usuario) async {
    final url = Uri.parse('$_baseUrl/mktitem');

    final envio = {
      "usuario": item.usuario.toString(),
      "descricao": item.descricao,
      "quantidade": item.quantidade,
      "grupo": item.grupo,
      "isbought": "false"
    };

    try {
      final response = await http
          .post(
        url,
        body: envio,
      )
          .timeout(const Duration(seconds: 2), onTimeout: () {
        return http.Response('Error', 408);
      });
      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['id'];
        final ItemModel registro = ItemModel(
          id: id,
          usuario: item.usuario,
          descricao: item.descricao,
          quantidade: item.quantidade,
          grupo: item.grupo,
          isbought: false,
        );
        items.add(registro);
        itemsUsuario.add(registro);
        final indexCompras = compras
            .indexWhere((element) => element.descricao == item.descricao);
        if (indexCompras < 0) {
          addHistorico(item.descricao);
          notifyListeners();
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateItem(ItemModel item) async {
    final index = items.indexWhere((element) => element.id == item.id);

    final indexUsuario =
        itemsUsuario.indexWhere((element) => element.id == item.id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/mktitem');
        final response = await http.patch(url, body: {
          "id": item.id.toString(),
          "usuario": item.usuario,
          "descricao": item.descricao,
          "quantidade": item.quantidade,
          "grupo": item.grupo,
          "isbought": item.isbought.toString()
        });

        if (response.statusCode == 200) {
          items[index] = item;
          if (indexUsuario >= 0) {
            itemsUsuario[indexUsuario] = item;
          }

          // if (!compras.contains(item.descricao)) {
          //   compras.add(item.descricao);
          // }
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    }
    return false;
  }

  Future<bool> removeItem(int id) async {
    final index = items.indexWhere((element) => element.id == id);
    final indexUsuario = itemsUsuario.indexWhere((element) => element.id == id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/mktitem/$id');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          items.removeWhere((item) => id == item.id);
          if (indexUsuario >= 0) {
            itemsUsuario.removeWhere((item) => id == item.id);
          }
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> limpaLista(String usuario) async {
    try {
      final url = Uri.parse('$_baseUrl/mktitem/limpalista/$usuario');
      final response = await http.post(url, body: {"usuario": usuario});

      if (response.statusCode == 200) {
        items.removeWhere((item) => usuario == item.usuario);
        itemsUsuario.removeWhere((item) => usuario == item.usuario);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> itemBought(ItemModel item) async {
    final index = items.indexWhere((element) => element.id == item.id);
    final indexUsuario =
        itemsUsuario.indexWhere((element) => element.id == item.id);

    item.isbought = !item.isbought;

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/mktitem');
        final response = await http.patch(url, body: {
          "id": item.id.toString(),
          "isbought": item.isbought.toString()
        });

        if (response.statusCode == 200) {
          items[index] = item;
          if (indexUsuario >= 0) {
            itemsUsuario[indexUsuario] = item;
          }

          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    }
    return false;
  }

  Future<List<HistoricoModel>> loadHistorico() async {
    compras = []; //app_data.items;

    final url = Uri.parse('$_baseUrl/mkthistorico');

    try {
      final response = await http.get(url);
      // print(response.body);

      final data = jsonDecode(response.body);

      data.forEach((itemData) {
        compras.add(
          HistoricoModel(
            id: itemData['id'],
            descricao: itemData['descricao'] ?? '',
          ),
        );
      });
      items.sort((a, b) {
        return a.descricao.compareTo(b.descricao);
      });
    } catch (err) {
      print('');
    }

    notifyListeners();
    return compras;
  } //load

  Future<bool> addHistorico(String descricao) async {
    final url = Uri.parse('$_baseUrl/mkthistorico');

    final envio = {
      "descricao": descricao,
    };

    try {
      final response = await http
          .post(
        url,
        body: envio,
      )
          .timeout(const Duration(seconds: 2), onTimeout: () {
        return http.Response('Error', 408);
      });
      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['id'];
        final HistoricoModel registro = HistoricoModel(
          id: id,
          descricao: descricao,
        );
        compras.add(registro);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> removeHistorico(int id) async {
    final index = compras.indexWhere((element) => element.id == id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/mkthistorico/$id');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          compras.removeWhere((item) => id == item.id);
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    } else {
      return false;
    }
  }
} //class
