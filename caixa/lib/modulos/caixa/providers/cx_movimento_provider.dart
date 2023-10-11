import 'dart:convert';
import 'dart:math';
import 'package:caixa/modulos/caixa/models/cx_movimento_model.dart';
import 'package:caixa/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CxMovimentoProvider with ChangeNotifier {
  // final _baseUrl = 'http://amilton.com.br/api';
  final _baseUrl = 'http://192.168.1.81:21276';

  List<CxMovimentoModel> cxMovimento = [];
  CxMovimentoModel? cxLancamento;

  Future<CxMovimentoModel?> getRegistroById(String id) async {
    // CxMovimentoModel centroCustos;
    final url = Uri.parse('$_baseUrl/cxmovimento/id/$id');

    try {
      final response = await http.get(url);
      print(response.body);

      final data = jsonDecode(response.body);

      cxLancamento = CxMovimentoModel(
        id: data['id'],
        data: data['data'],
        sinal: data['sinal'],
        valor: data['valor'],
        historico: data['historico'],
        id_centrocustos: data['id_centrocustos'],
      );
      notifyListeners();
      return cxLancamento;
    } catch (err) {
      print('');
      return null;
    }
  }

  Future<dynamic> getDescricao(String id) async {
    final url = Uri.parse('$_baseUrl/cxmovimento/id/$id');

    try {
      final response = await http.get(url);

      final data = jsonDecode(response.body);
      return data;
    } catch (err) {
      print('');
      return null;
    }
  }

  Future<List<CxMovimentoModel>> loadRegistros() async {
    cxMovimento = [];
    final url = Uri.parse('$_baseUrl/cxmovimento');

    try {
      final response = await http.get(url);

      final dados = jsonDecode(response.body);

      dados.forEach((itemdados) {
        print(itemdados['id']);
        print(itemdados['data']);
        
        cxMovimento.add(
          CxMovimentoModel(
            id: itemdados['id'] as int,
            data: itemdados['data'] as String,
            sinal: itemdados['sinal'] as String,
            valor: itemdados['valor'] as double,
            historico: itemdados['historico'] as String,
            id_centrocustos: itemdados['id_centrocustos'] as int,
          ),
        );
      });
      return cxMovimento;
      // cxMovimento.sort((a, b) {
      //   return a.descricao.compareTo(b.descricao);
      // });
    } catch (err) {
      print('');
      return [];
    }

    notifyListeners();
    // return cxMovimento;
  }

  List<CxMovimentoModel> getRegistros() {
    return cxMovimento;
  }

  Future<bool> saveRegistro(Map<String, Object> registro) {
    var hasId = registro['id'] != null && registro['id'] as int > 0;

    final CxMovimentoModel cxLancamento = CxMovimentoModel(
      id: hasId ? registro['id'] as int : Random().nextInt(5000),
      data: registro['data'] as String,
      sinal: registro['sinal'] as String,
      valor: Validadores.StringToDouble(registro['valor'].toString()),
      historico: registro['historico'] as String,
      id_centrocustos:
          Validadores.StringToInt(registro['id_centrocustos'].toString()),
    );

    if (hasId) {
      return updateRegistro(cxLancamento);
    } else {
      return addRegistro(cxLancamento);
    }
  }

  Future<bool> addRegistro(CxMovimentoModel lancamento) async {
    final url = Uri.parse('$_baseUrl/cxmovimento');

    final envio = {
      "data": Validadores.dateStringToBanco(lancamento.data.toString()),
      "sinal": lancamento.sinal,
      "valor": lancamento.valor.toString(),
      "historico": lancamento.historico,
      "id_centrocustos": lancamento.id_centrocustos.toString(),
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
        final CxMovimentoModel registro = CxMovimentoModel(
          id: id,
          data: lancamento.data,
          sinal: lancamento.sinal,
          valor: lancamento.valor,
          historico: lancamento.historico,
          id_centrocustos: lancamento.id_centrocustos,
        );
        cxMovimento.add(registro);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateRegistro(CxMovimentoModel lancamento) async {
    final index =
        cxMovimento.indexWhere((element) => element.id == lancamento.id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/cxmovimento');
        final response = await http.patch(url, body: {
          "id": lancamento.id.toString(),
          "data": Validadores.dateStringToBanco(lancamento.data.toString()),
          "sinal": lancamento.sinal,
          "valor": lancamento.valor,
          "historico": lancamento.historico,
          "id_centrocustos": lancamento.id_centrocustos,
        });

        if (response.statusCode == 200) {
          cxMovimento[index] = lancamento;
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
    final index = cxMovimento.indexWhere((element) => element.id == id);

    if (index >= 0) {
      try {
        final url = Uri.parse('$_baseUrl/cxmovimento/$id');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          cxMovimento.removeWhere((item) => id == item.id);
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
