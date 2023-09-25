import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pessoas/modulos/usuario/usuario_lista_screen.dart';
import 'package:pessoas/modulos/usuario/usuario_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool internet = false;

  @override
  Widget build(BuildContext context) {
    final List<String> modulos = [
      'Usuarios',
      'Compras',
      'Caixa',
      'Empreendimentos',
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              bool result = await InternetConnectionChecker().hasConnection;
              // bool result =
              //     await Provider.of<UsuarioProvider>(context, listen: false)
              //         .ping();
              setState(() {
                internet = result;
              });
            },
            icon: Icon(internet ? Icons.signal_wifi_statusbar_4_bar_sharp : Icons.signal_wifi_statusbar_null),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Wrap(
                spacing: 20,
                children: [
                  Container(
                    height: 80,
                    width: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const UsuarioListaScreen())
                      ),
                      child: Card(
                        elevation: 5,
                        color: Colors.blue,
                        child: Center(
                          child: Text(modulos[0]),
                        )),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 150,
                    child: Card(
                      elevation: 5,
                      color: Colors.blue,
                      child: Center(
                        child: Text(modulos[0]),
                      )),
                  ),
                  SizedBox(
                    height: 80,
                    width: 150,
                    child: Card(
                      elevation: 5,
                      color: Colors.blue,
                      child: Center(
                        child: Text(modulos[0]),
                      )),
                  ),
                  SizedBox(
                    height: 80,
                    width: 150,
                    child: Card(
                      elevation: 5,
                      color: Colors.blue,
                      child: Center(
                        child: Text(modulos[0]),
                      )),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
