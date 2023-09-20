import 'dart:async';

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
  String token = '';
  List<Usuario> usuarios = [];

  // @override
  // void initState() {
  //   super.initState();
  //   scheduleMicrotask(
  //     () {
  //       print('dentro do schedule');
  //       final xxx = Provider.of<AuthProvider>(context).authUsuario;
  //       print(xxx.token);
  //     },
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   scheduleMicrotask(() {
  //     final String xxx = Provider.of<AuthProvider>(context).authUsuario.token;
  //   });
  // }

  // Future(() => token = Provider.of<AuthProvider>(context).authUsuario.token);

  // scheduleMicrotask(() {
  //   setState(() {
  //     print('token 2 - $token');
  //     final xxx = Provider.of<UsuarioProvider>(context).loadUsuarios(token);
  //     print('token 3 - $token');
  //   });
  // });

  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   const String token =
  //       ''; //Provider.of<AuthProvider>(context).authUsuario.token;
  // });

  // print(token);

  @override
  Widget build(BuildContext context) {
    // final usuariosx =
    // Provider.of<UsuarioProvider>(context).loadUsuarios('token');
    // final usuarios = Provider.of<UsuarioProvider>(context).usuarios;

    // final usuarios = [];

    // Provider.of<UsuarioProvider>(context).usuarios;
    final token = Provider.of<AuthProvider>(context).authUsuario.token;
    print('>>>> print do token >>> $token');
    final xxx = Provider.of<UsuarioProvider>(context).loadUsuarios(token);

    setState(() {
      usuarios = Provider.of<UsuarioProvider>(context).usuarios;
    });

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
