import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navegacao_getx/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Navegação Getx',
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
      initialRoute: PagesRoutes.homeRoute,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}

/* 
Rotas trocar para GetMaterialApp no main

A tela home envia arguments (titulo) para tela 01.
A tela 01 recebe arqs (retorno da tela 02) da tela 02.

*/
