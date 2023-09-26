import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado/item_provider.dart';
import 'package:supermercado/pages/home_page.dart';

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
          create: (_) => ItemProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
