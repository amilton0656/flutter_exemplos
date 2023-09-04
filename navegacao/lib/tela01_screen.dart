import 'package:flutter/material.dart';
import 'package:navegacao/tela02_screen.dart';

class Tela01Screen extends StatelessWidget {
  const Tela01Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 01 Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Tela 01',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const Tela02Screen(),
                      ),
                    );
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
