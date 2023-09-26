import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:supermercado/app_data.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/item_provider.dart';
import 'package:supermercado/pages/form_page.dart';
import 'package:supermercado/pages/list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color corFundo = Colors.blue.shade900;
  int currentIndex = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
      scheduleMicrotask(() {
        Provider.of<ItemProvider>(context, listen: false).loadItems();
      });
      scheduleMicrotask(() {
        Provider.of<ItemProvider>(context, listen: false).getItems('Todos');
      });

  }

  void _showModalBottomSheet({ItemModel? item}) {
    showModalBottomSheet(
      //acerto teclado
      isScrollControlled: true,
      context: context,
      builder: (_) => FormPage(
        usuario: Usuarios[currentIndex],
        item: item,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compras'),
        backgroundColor: corFundo,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: currentIndex > 0
                  ? () {
                      _showModalBottomSheet();
                    }
                  : null,
              icon: Icon(
                Icons.shopping_cart,
                color: currentIndex > 0
                    ? Colors.white
                    : Colors.white.withAlpha(100),
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          //Todos
          ListPage(
            usuario: Usuarios[0],
            color: Colors.grey.shade500,
            onModal: _showModalBottomSheet,
          ),

          //Amilton
          ListPage(
            usuario: Usuarios[1],
            color: Colors.orange.shade300,
            onModal: _showModalBottomSheet,
          ),

          //Selene
          ListPage(
            usuario: Usuarios[2],
            color: Colors.green,
            onModal: _showModalBottomSheet,
          ),

          //Eduardo
          ListPage(
            usuario: Usuarios[3],
            color: Colors.blue,
            onModal: _showModalBottomSheet,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() => currentIndex = index);
          pageController.jumpToPage(index);
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: corFundo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        items: const [
          BottomNavigationBarItem(
            label: 'Todos',
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            label: 'Amilton',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Selene',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Eduardo',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
