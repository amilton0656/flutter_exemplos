import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:compras/models/items_provider.dart';

import 'pages/home_page.dart';

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
          create: (_) => ItemsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Compras',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          listTileTheme: const ListTileThemeData(
            leadingAndTrailingTextStyle: TextStyle(fontSize: 20),
            titleTextStyle: TextStyle(fontSize: 20),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

//flutter build apk --split-per-abi
