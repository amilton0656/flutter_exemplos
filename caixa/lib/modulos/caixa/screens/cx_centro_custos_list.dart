import 'dart:async';

import 'package:caixa/modulos/caixa/providers/cx_centro_custos_provider.dart';
import 'package:caixa/modulos/caixa/screens/cx_centro_custos_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CxCentroCustosList extends StatefulWidget {
  const CxCentroCustosList({super.key});

  @override
  State<CxCentroCustosList> createState() => _CxCentroCustosListState();
}

class _CxCentroCustosListState extends State<CxCentroCustosList> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      Provider.of<CentroCustosProvider>(context, listen: false).loadRegistros();
    });
  }

  @override
  Widget build(BuildContext context) {
    final centrosCustos =
        Provider.of<CentroCustosProvider>(context).getRegistros();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centros de Custos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CxCentroCustosForm()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: centrosCustos.length,
          itemBuilder: (ctx, index) => ListTile(
            leading: Text(centrosCustos[index].id.toString()),
            title: GestureDetector(
              onLongPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CxCentroCustosForm(centroCusto: centrosCustos[index]),
                  ),
                );
              },
              onTap: () {
                Navigator.of(context).pop(centrosCustos[index]);
              },
              child: Text(centrosCustos[index].descricao),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
