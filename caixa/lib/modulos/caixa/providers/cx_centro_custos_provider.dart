import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:caixa/modulos/caixa/models/cx_centrocustos_model.dart';

class CxCentroCustosProvider with ChangeNotifier {
  final _baseUrl = 'http://amilton.com.br/api';
  // final _baseUrl = 'http://192.168.1.81:21276';

  List<CxCentroCustosModel> centrosCustos = [];
  CxCentroCustosModel? centroCustos;

  Future<CxCentroCustosModel?> getRegistroById(String id) async {
    // CxCentroCustosModel centroCustos;
    final url = Uri.parse('$_baseUrl/centrocustos/id/$id');

    try {
      final response = await http.get(url);
      print(response.body);

      final data = jsonDecode(response.body);

      centroCustos = CxCentroCustosModel(
        id: data['id'],
        descricao: data['descricao'] ?? '',
      );
      notifyListeners();
      return centroCustos;
    } catch (err) {
      print('');
      return null;
    }
  }

  Future<dynamic> getDescricao(String id) async {
    final url = Uri.parse('$_baseUrl/centrocustos/id/$id');

    try {
      final response = await http.get(url);

      final data = jsonDecode(response.body);
      return data;
    } catch (err) {
      print('');
      return null;
    }
  }

  void loadRegistros() async {
    centrosCustos = [];
    final url = Uri.parse('$_baseUrl/centrocustos');

    try {
      final response = await http.get(url);

      final data = jsonDecode(response.body);

      data.forEach((itemData) {
        centrosCustos.add(
          CxCentroCustosModel(
            id: itemData['id'],
            descricao: itemData['descricao'] ?? '',
          ),
        );
      });
      centrosCustos.sort((a, b) {
        return a.descricao.compareTo(b.descricao);
      });
    } catch (err) {
      print('');
    }

    notifyListeners();
    // return centrosCustos;
  }

  List<CxCentroCustosModel> getRegistros() {
    return centrosCustos;
  }

  Future<bool> saveRegistro(Map<String, Object> registro) {
    var hasId = registro['id'] != null;

    final CxCentroCustosModel centroCustos = CxCentroCustosModel(
      id: hasId ? registro['id'] as int : Random().nextInt(5000),
      descricao: registro['descricao'] as String,
    );

    if (hasId) {
      return updateRegistro(centroCustos);
    } else {
      return addRegistro(centroCustos);
    }
  }

  Future<bool> addRegistro(CxCentroCustosModel centroCustos) async {
    final url = Uri.parse('$_baseUrl/centrocustos');

    final envio = {
      "descricao": centroCustos.descricao,
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
        final CxCentroCustosModel registro = CxCentroCustosModel(
          id: id,
          descricao: centroCustos.descricao,
        );
        centrosCustos.add(registro);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateRegistro(CxCentroCustosModel centroCustos) async {
    final index =
        centrosCustos.indexWhere((element) => element.id == centroCustos.id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/centrocustos');
        final response = await http.patch(url, body: {
          "id": centroCustos.id.toString(),
          "descricao": centroCustos.descricao,
        });

        if (response.statusCode == 200) {
          centrosCustos[index] = centroCustos;
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

  Future<bool> removeRegistro(int id) async {
    final index = centrosCustos.indexWhere((element) => element.id == id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/centrocustos/$id');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          centrosCustos.removeWhere((item) => id == item.id);
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
}
