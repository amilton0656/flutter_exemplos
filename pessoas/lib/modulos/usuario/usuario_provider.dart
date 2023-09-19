import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:pessoas/data/app_data.dart' as app_data;
import 'package:pessoas/modulos/auth/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'usuario_model.dart';

class UsuarioProvider with ChangeNotifier {
  final _url = Uri.parse(Constantes.urlBase);

  List<Usuario> usuarios = [];

  Future<List<Usuario>> loadUsuarios(String token) async {
    usuarios = [];

    final response = await http.post(
      _url,
      headers: <String, String>{'Authorization': token},

    );

    print('>>>  status code ${response.statusCode}');

    if (jsonDecode(response.body) == null) {
      return [];
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((itemId, itemData) {
      usuarios.add(
        Usuario(
          id: 0,
          nome: itemData['nome'] as String,
          email: itemData['email'] as String,
          senha: itemData['senha'] as String,
        ),
      );
    });

    notifyListeners();
    return usuarios;
  }
}