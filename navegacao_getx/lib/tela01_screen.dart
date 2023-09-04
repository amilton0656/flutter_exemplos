import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_pages.dart';

class Tela01Screen extends StatefulWidget {
  const Tela01Screen({super.key});

  @override
  State<Tela01Screen> createState() => _Tela01ScreenState();
}

class _Tela01ScreenState extends State<Tela01Screen> {
  String retorno = '';
  var titulo = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
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
                Text(retorno),
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
                    Get.back();
                  },
                  child: const Text('Back to Home Screen'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // não nomeada
                    // final response = await Get.to(() => const Tela02Screen());

                    //Nomeada
                    final response = await Get.toNamed(PagesRoutes.tela02Route);

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
