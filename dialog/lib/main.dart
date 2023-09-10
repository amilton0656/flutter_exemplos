import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool retornoDialog = false;

  _openDialog(context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Título'),
        content: const Text('Conteúdo'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => retornoDialog = false);
              Navigator.pop(context);
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              setState(() => retornoDialog = true);
              Navigator.pop(context);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(retornoDialog.toString()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _openDialog(context),
              child: const Text('Abrir Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
