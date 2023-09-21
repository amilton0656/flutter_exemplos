import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pessoas/modulos/usuario/usuario_form_screen.dart';
import 'package:pessoas/utils/paleta_cores.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import 'usuario_provider.dart';

class UsuarioListaScreen extends StatefulWidget {
  const UsuarioListaScreen({super.key});

  @override
  State<UsuarioListaScreen> createState() => _UsuarioListaScreenState();
}

class _UsuarioListaScreenState extends State<UsuarioListaScreen> {
  List<UsuarioModel> usuarios = [];

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(
      () {
        Provider.of<UsuarioProvider>(context, listen: false)
            .loadUsuarios()
            .then((value) {
          setState(() {
            usuarios =
                Provider.of<UsuarioProvider>(context, listen: false).usuarios;
          });
        });
      },
    );
  }

  Future<void> refreshItems(BuildContext context) async {
    setState(() {
      usuarios = Provider.of<UsuarioProvider>(context, listen: false).usuarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, value, child) => RefreshIndicator(
          onRefresh: () => refreshItems(context),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue.shade300,
                  PaletaCores.corNavy,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(largura > 500 ? 10 : 0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: largura > 500 ? 20 : 0),
                  width: largura > 800 ? 800 : largura,
                  child: ListView.builder(
                      itemCount: usuarios.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onLongPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    UsuarioFormScreen(usuario: usuarios[index]),
                              ),
                            );
                          },
                          child: largura < 900
                              ? Dismissible(
                                  key: ValueKey(usuarios[index].id),
                                  onDismissed: (_) {
                                    Provider.of<UsuarioProvider>(context,
                                            listen: false)
                                        .removeItem(usuarios[index].id);
                                  },
                                  child: ListTile(
                                    leading: largura > 900
                                        ? Text(usuarios[index].id.toString())
                                        : null,
                                    title: Text(usuarios[index].nome),
                                    subtitle: Text(usuarios[index].email),
                                  ),
                                )
                              : ListTile(
                                  leading: largura > 900
                                      ? Text(usuarios[index].id.toString())
                                      : null,
                                  title: Text(usuarios[index].nome),
                                  subtitle: Text(usuarios[index].email),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Provider.of<UsuarioProvider>(context,
                                              listen: false)
                                          .removeItem(usuarios[index].id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ),
                        );
                      }),
                ),
              ),
              
            ],
          ),
        ),
      ),
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
