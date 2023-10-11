import 'package:caixa/modulos/caixa/models/cx_movimento_model.dart';
import 'package:flutter/material.dart';

class CxMovimentoList extends StatefulWidget {
  final List<CxMovimentoModel> cxMovimento;
  const CxMovimentoList({super.key, required this.cxMovimento});

  @override
  State<CxMovimentoList> createState() => _CxMovimentoListState();
}

class _CxMovimentoListState extends State<CxMovimentoList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caixa - Movimento'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: widget.cxMovimento.length,
          itemBuilder: (ctx, index) => ListTile(
            leading: Text(widget.cxMovimento[index].data),
            title: Text('${widget.cxMovimento[index].valor}${widget.cxMovimento[index].sinal}'),
          ),
        ),
      ),
    );
  }
}
