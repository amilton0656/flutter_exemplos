import 'package:flutter/material.dart';
import 'package:pessoas/modulos/usuario/usuario_form_screen.dart';
import 'package:pessoas/utils/paleta_cores.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../auth/auth_provider.dart';
import 'usuario_provider.dart';

class UsuarioListaScreen extends StatefulWidget {
  const UsuarioListaScreen({super.key});

  @override
  State<UsuarioListaScreen> createState() => _UsuarioListaScreenState();
}

class _UsuarioListaScreenState extends State<UsuarioListaScreen> {

  @override
  Widget build(BuildContext context) {
    final String token = Provider.of<AuthProvider>(context).authUsuario.token;
    print(token);
    final usuariosx = Provider.of<UsuarioProvider>(context).loadUsuarios(token);


    final usuarios = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(usuarios[index].nome),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const UsuarioFormScreen(),
        )),
        backgroundColor: PaletaCores.corFundoBotao,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
