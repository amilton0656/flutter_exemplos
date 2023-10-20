import 'package:caixa/modulos/caixa/models/cx_movimento_model.dart';
import 'package:caixa/modulos/caixa/providers/cx_movimento_provider.dart';
import 'package:caixa/modulos/caixa/screens/cx_movimento.dart';
import 'package:caixa/utils/formatadores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CxMovimentoList extends StatefulWidget {
  const CxMovimentoList({super.key});

  @override
  State<CxMovimentoList> createState() => _CxMovimentoListState();
}

class _CxMovimentoListState extends State<CxMovimentoList> {
  @override
  Widget build(BuildContext context) {
    List<CxMovimentoModel> cxMovimento = [];
    cxMovimento =
        Provider.of<CxMovimentoProvider>(context).cxMovimento;

    return Scaffold(
      appBar: AppBar(
        title: Text('Caixa - Movimento'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => CxMovimento()));
                  },
                   icon: Icon(Icons.add, size: 30, color: Colors.blue,)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: cxMovimento.length,
          itemBuilder: (ctx, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CxMovimento(
                        cxLancamento: cxMovimento[index],
                      )));
            },
            child: ListTile(
              leading: Text(cxMovimento[index].data),
              title: Text(
                  '${Formatadores.numberToFormatted(cxMovimento[index].valor)}${cxMovimento[index].sinal}'),
              subtitle: Text(cxMovimento[index].historico),
            ),
          ),
        ),
      ),
    );
  }
}
