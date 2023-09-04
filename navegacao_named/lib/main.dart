import 'package:flutter/material.dart';
import 'package:navegacao_named/home_screen.dart';
import 'package:navegacao_named/tela01_screen.dart';
import 'package:navegacao_named/tela02_screen.dart';

import 'app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      // home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HOME,
      routes: {
        AppRoutes.HOME: (ctx) => const HomeScreen(),
        AppRoutes.TELA01: (ctx) => const Tela01Screen(),
        AppRoutes.TELA02: (ctx) => const Tela02Screen(),
      },
    );
  }
}

/* 
Rotas nomeadas

A tela home envia arguments (titulo) para tela 01.
A tela 01 recebe arqs (retorno da tela 02) da tela 02.

*/
