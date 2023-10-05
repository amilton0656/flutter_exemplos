import 'package:flutter/material.dart';

class CxMovimentoList extends StatefulWidget {
  const CxMovimentoList({super.key});

  @override
  State<CxMovimentoList> createState() => _CxMovimentoListState();
}

class _CxMovimentoListState extends State<CxMovimentoList> {
  final cxMovimento = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Caixa - Movimento'),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: cxMovimento.length,
          itemBuilder: (ctx, index) => ListTile(
            title: Text('xxxxx'),
          ),
          ),
      ),
    );
  }
}