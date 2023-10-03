import 'package:caixa/models/centrocustos_model.dart';
import 'package:flutter/material.dart';

class CxCentroCustosList extends StatelessWidget {
  final List<CentroCustosModel> centroCustos;
  const CxCentroCustosList({super.key, required this.centroCustos});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: ListView.builder(
              itemCount: centroCustos.length,
              itemBuilder: (ctx, index) => ListTile(
                leading: Text(centroCustos[index].id.toString(),
                ),
                title: Text(centroCustos[index].descricao),
              ),
              ),
          ),
        ],
      ),
    );
  }
}