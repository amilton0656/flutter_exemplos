import 'package:flutter/material.dart';
import 'package:navegacao_named/app_routes.dart';

class Tela01Screen extends StatefulWidget {
  const Tela01Screen({super.key});

  @override
  State<Tela01Screen> createState() => _Tela01ScreenState();
}

class _Tela01ScreenState extends State<Tela01Screen> {
  String retorno = '';
  @override
  Widget build(BuildContext context) {
    final titulo = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 35,
                  ),
                ),
                Text(retorno != '' ? retorno : ''),
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to Home Screen'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final response = await Navigator.of(context).pushNamed(
                      AppRoutes.TELA02,
                    ) as String;
                    setState(() {
                      retorno = response;
                    });
                  },
                  child: const Text('Go to Tela 02'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
