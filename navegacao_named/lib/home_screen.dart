import 'package:flutter/material.dart';
import 'package:navegacao_named/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Home Page',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            height: 300,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.TELA01,
                  arguments: 'Tela 01',
                );
              },
              child: const Text('Go to Tela 01'),
            ),
          ),
        ],
      ),
    );
  }
}
