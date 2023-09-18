import 'package:flutter/material.dart';

import 'package:pessoas/data/app_data.dart' as app_data;

class UsuarioListaScreen extends StatelessWidget {
  const UsuarioListaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarios = app_data.usuarios;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(usuarios[index].nome),
        ),
      ),
    );
  }
}
