import 'package:flutter/material.dart';
import 'package:pessoas/modulos/auth/auth_provider.dart';
import 'package:pessoas/modulos/auth/login_screen.dart';
import 'package:pessoas/modulos/usuario/usuario_email.dart';
import 'package:pessoas/modulos/usuario/usuario_provider.dart';
import 'package:pessoas/pdf/pdf3.dart';
import 'package:pessoas/pdf/pdf_page.dart';
import 'package:pessoas/pdf/pdf_teste.dart';
import 'package:pessoas/teste.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Pessoas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
