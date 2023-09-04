import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tela02Screen extends StatelessWidget {
  const Tela02Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 02 Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Tela 02',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            alignment: Alignment.center,
            height: 300,
            child: ElevatedButton(
              onPressed: () {
                Get.back(result: 'retorno da tela 02');
              },
              child: const Text('Back to Tela 01'),
            ),
          ),
        ],
      ),
    );
  }
}
