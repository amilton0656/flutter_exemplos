import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pessoas/utils/constants.dart';

class AuthProvider with ChangeNotifier {
  final _url = Uri.parse('${Constantes.urlBase}/login');

  static AuthUsuario authUsuario = AuthUsuario(
    id: 0,
    nome: '',
    auth: false,
    token: '',
  );

  Future<int> checkAuth(String email, String senha) async {
    try {
      final response =
          await http.post(_url, body: {"email": email, "senha": senha}).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

      if (response.statusCode == 408) {
        return 408;
      }

      if (jsonDecode(response.body) == null) {
        return 0;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data['auth']) {
          authUsuario = AuthUsuario(
            id: data['id'] as int,
            nome: data['usuario'] as String,
            auth: data['auth'] as bool,
            token: data['token'] as String,
          );
          return response.statusCode;
        } else {
          return 0;
        }
      }
    } catch (err) {
          print('dentro do catch...$err');
      return 0;
    }
  }
}

class AuthUsuario {
  final int id;
  final String nome;
  final bool auth;
  final String token;

  AuthUsuario({
    required this.id,
    required this.nome,
    required this.auth,
    required this.token,
  });

  void set id(int id) {
    id = id;
  }
}
