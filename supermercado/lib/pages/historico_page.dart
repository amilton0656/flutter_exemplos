import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado/item_historico.dart';
import 'package:supermercado/item_provider.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  List<HistoricoModel> compras = [];

  @override
  void initState() {
    super.initState();

    // scheduleMicrotask(() async {
    //   setState(() {
    //     Provider.of<ItemProvider>(context, listen: false).sortCompras();
    //   });
    // });
    scheduleMicrotask(() async {
      final xx = await Provider.of<ItemProvider>(context, listen: false).loadHistorico();
      setState(() {
        compras = xx;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final onDescricao = ModalRoute.of(context)!.settings.arguments as Function;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<ItemProvider>(
            builder: (ctx, getCompras, child) => Container(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
                itemCount: compras.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onLongPress: () {
                      Navigator.pop(context, compras[index]);
                    },
                    child: ListTile(
                      title: Text(
                        compras[index].descricao,
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Provider.of<ItemProvider>(context, listen: false)
                                .removeHistorico(compras[index].id);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                })),
      ),
    );
  }
}
