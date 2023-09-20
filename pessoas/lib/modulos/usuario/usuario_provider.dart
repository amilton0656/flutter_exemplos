import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../auth/auth_provider.dart';
import 'usuario_model.dart';

class UsuarioProvider with ChangeNotifier {
  final _url = Uri.parse(Constantes.urlBase);

  List<UsuarioModel> usuarios = [];

  //loadUsuarios
  Future<List<UsuarioModel>> loadUsuarios() async {
    final token = AuthProvider.authUsuario.token;
    usuarios = [];
    final response = await http.get(
      _url,
      headers: <String, String>{'Authorization': token},
    );

    if (jsonDecode(response.body) == null) {
      return [];
    }

    final data = jsonDecode(response.body);

    data.forEach((itemData) {
      usuarios.add(
        UsuarioModel(
          id: itemData['id'] ?? 0,
          nome: itemData['nome'] ?? '',
          email: itemData['email'] ?? '',
          senha: itemData['senha'] ?? '',
        ),
      );
    });

    notifyListeners();
    return usuarios;
  }

  Future<void> saveUsuario(Map<String, Object> registro) {
    final hasId = registro['id'] != null;

    final UsuarioModel usuario = UsuarioModel(
      id: hasId ? registro['id'] as int : Random().nextInt(10000),
      nome: registro['nome'] as String,
      email: registro['email'] as String,
      senha: registro['senha'] as String,
    );

    if (hasId) {
      return updateItem(usuario);
    } else {
      return addItem(usuario);
    }
  }

  //Add
  Future<void> addItem(UsuarioModel usuario) async {
    final envio = {
      "nome": usuario.nome,
      "email": usuario.email,
      "senha": usuario.senha,
    };
    final token = AuthProvider.authUsuario.token;
    final response = await http.post(
      _url,
      headers: <String, String>{'Authorization': token},
      body: envio,
    );
    final id = jsonDecode(response.body)['id'];
    final UsuarioModel registro = UsuarioModel(
      id: id,
      nome: usuario.nome,
      email: usuario.email,
      senha: usuario.senha,
    );
    usuarios.add(registro);
    notifyListeners();
  }

  //Update
  Future<void> updateItem(UsuarioModel usuario) async {
    final token = AuthProvider.authUsuario.token;
    final index = usuarios.indexWhere((element) => element.id == usuario.id);

    final Map<String, dynamic> envio = {
      "id": usuario.id.toString(),
      "nome": usuario.nome,
      "email": usuario.email,
      "senha": usuario.senha,
    };

    print('envio : $envio - $index');

    if (index >= 0) {
      final response = await http.put(
        _url,
        headers: <String, String>{'Authorization': token},
        body: envio,
      );

      print(response.statusCode);

      usuarios[index] = usuario;
      notifyListeners();
    }
  }

  //Remove
  Future<void> removeItem(int id) async {
    print('dentro do reove');
    final token = AuthProvider.authUsuario.token;
    final index = usuarios.indexWhere((element) => element.id == id);
    final _urld = Uri.parse('${Constantes.urlBase}/$id');

    print(_urld);

    if (index >= 0) {
      await http.delete(
        _urld,
        headers: <String, String>{'Authorization': token},
      );
      usuarios.removeWhere((item) => id == item.id);
    }

    notifyListeners();
  }
}
