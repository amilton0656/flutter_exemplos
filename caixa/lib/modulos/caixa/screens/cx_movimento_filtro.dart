import 'package:caixa/widgets/custom_cx_centro_custos_field.dart';
import 'package:caixa/widgets/custom_date_field.dart';
import 'package:flutter/material.dart';

class CxMovimentoFiltro extends StatefulWidget {
  const CxMovimentoFiltro({super.key});

  @override
  State<CxMovimentoFiltro> createState() => _CxMovimentoFiltroState();
}

class _CxMovimentoFiltroState extends State<CxMovimentoFiltro> {
  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            const CustomCxCentroCustosField(),

            //************************************************************ */
          ],
        ),
      ),
    );
  }
}
