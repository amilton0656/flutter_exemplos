import 'package:caixa/modulos/caixa/models/cx_movimento_model.dart';
import 'package:caixa/modulos/caixa/providers/cx_centro_custos_provider.dart';
import 'package:caixa/modulos/caixa/providers/cx_movimento_provider.dart';
import 'package:caixa/modulos/caixa/screens/cx_centro_custos_list.dart';
import 'package:caixa/modulos/caixa/screens/cx_movimento_list.dart';
import 'package:caixa/widgets/custom_date_field.dart';
import 'package:caixa/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caixa/utils/validadores.dart';

class CxMovimentoFiltro extends StatefulWidget {
  final Future<dynamic> Function(String) onGetDescricao;
  const CxMovimentoFiltro({super.key, required this.onGetDescricao});

  @override
  State<CxMovimentoFiltro> createState() => _CxMovimentoFiltroState();
}

class _CxMovimentoFiltroState extends State<CxMovimentoFiltro> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();
  TextEditingController idController = TextEditingController();

  List<CxMovimentoModel> cxMovimento = [];
  bool isLoading = false;

  Future<String> getDescricao(String id) async {
    String descricao = '';
    descricao =
        await Provider.of<CxCentroCustosProvider>(context, listen: false)
            .getDescricao(id);
    return descricao;
  }

  onSubmit() async {
    print(Validadores.dateIsAfter(
        dataInicialController.text, dataFinalController.text));

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // print(_formData);
      setState(() => isLoading = true);
      final response =
          await Provider.of<CxMovimentoProvider>(context, listen: false)
              .loadRegistros();

      setState(() {
        cxMovimento = response;
      });

      print(response);

      setState(() => isLoading = false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => CxMovimentoList(cxMovimento: cxMovimento)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> buscarRegistros() async {
      final res = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const CxCentroCustosList(),
        ),
      );
      if (res != null) {
        return res;
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimento por período'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //** Data Inicial ********************************************************** */
                  CustomDateField(
                    dateLarguraMenor: true,
                    label: 'Data Inicial',
                    controller: dataInicialController,
                  ),

                  //** Data Final ********************************************************** */
                  CustomDateField(
                    dateLarguraMenor: true,
                    label: 'Data Final',
                    controller: dataFinalController,
                    validator: (data) {
                      if (data == null || data.isEmpty) {
                        return 'Insira uma data.';
                      }

                      if (!Validadores.isValidDate(data)) {
                        return 'Data Inválida.';
                      }

                      if (!Validadores.dateIsAfter(dataInicialController.text,
                          dataFinalController.text)) {
                        return 'Data menor.';
                      }

                      return null;
                    },
                    //Validadores.dateIsAfter(dataInicialController.text, dataFinalController.text)
                  ),
                ],
              ),

              //** Centro Custos ********************************************************** */
              CustomSearchField(
                onGetDescricao: widget.onGetDescricao,
                controller: idController,
                label: 'Centro de Custos',
                onBuscar: buscarRegistros,
              ),

              /** botao buscar ******************************************************* */
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text('Buscar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
