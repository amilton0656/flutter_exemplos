import 'package:caixa/modulos/caixa/providers/cx_centro_custos_provider.dart';
import 'package:caixa/modulos/caixa/screens/cx_centro_custos_list.dart';
import 'package:caixa/widgets/custom_date_field.dart';
import 'package:caixa/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CxMovimentoFiltro extends StatefulWidget {
  final Future<dynamic> Function(String) onGetDescricao;
  const CxMovimentoFiltro({super.key, required this.onGetDescricao});

  @override
  State<CxMovimentoFiltro> createState() => _CxMovimentoFiltroState();
}

class _CxMovimentoFiltroState extends State<CxMovimentoFiltro> {
  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();
  TextEditingController idController = TextEditingController();

  Future<String> getDescricao(String id) async {
    String descricao = '';
    descricao = await Provider.of<CentroCustosProvider>(context, listen: false)
        .getDescricao(id);
    return descricao;
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> _buscarRegistros() async {
      final res = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CxCentroCustosList(),
        ),
      );
      if (res != null) {
        return res;
      }
      return null;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //** Data Inicial ********************************************************** */
                CustomDateField(
                  // validator: ,
                  label: 'Data Inicial',
                  controller: dataInicialController,
                ),
                const SizedBox(
                  width: 80,
                ),

                //** Data Final ********************************************************** */
                CustomDateField(
                  label: 'Data Final',
                  controller: dataFinalController,
                ),
              ],
            ),

            //** Centro Custos ********************************************************** */
            CustomSearchField(
              onGetDescricao: widget.onGetDescricao,
              controller: idController,
              label: 'Centro de Custos',
              onBuscar: _buscarRegistros,
            ),

            //************************************************************ */
          ],
        ),
      ),
    );
  }
}
