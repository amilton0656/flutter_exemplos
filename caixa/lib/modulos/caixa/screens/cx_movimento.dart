import 'dart:async';

import 'package:caixa/modulos/caixa/models/centrocustos_model.dart';
import 'package:caixa/modulos/caixa/providers/cx_centro_custos_provider.dart';
import 'package:caixa/modulos/caixa/screens/cx_centro_custos_list.dart';
import 'package:caixa/modulos/caixa/screens/cx_movimento_filtro.dart';
import 'package:caixa/utils/validadores.dart';
import 'package:caixa/widgets/custom_text_field.dart';
import 'package:caixa/widgets/max_Lines_Input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CxMovimento extends StatefulWidget {
  const CxMovimento({super.key});

  @override
  State<CxMovimento> createState() => _CxMovimentoState();
}

class _CxMovimentoState extends State<CxMovimento> {
  TextEditingController dataController = TextEditingController();
  TextEditingController idCentroCustosController = TextEditingController();
  String ccSelected = '';
  String centroCustosDescricao = '';
  List<CentroCustosModel> centrosCustos = [];

  bool sinalSeletor = false;

  final formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      Provider.of<CentroCustosProvider>(context, listen: false).loadRegistros();
    });
  }

  final dataFormarter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  void _getCentroCustosDescricao(int id) {
    print('id >>> $id');
    final cc = centrosCustos.firstWhere((element) => element.id == id);
    setState(() {
      centroCustosDescricao = cc.descricao;
      formData['id_centroCustos'] = cc.id;
      idCentroCustosController.text = cc.id.toString();
    });
  }

  void _buscaCentroCustos() async {
    final CentroCustosModel? res = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CxCentroCustosList(),
      ),
    );
    if (res != null) {
      _getCentroCustosDescricao(res.id);
    }
  }

  void _showModalBottomSheet() async {
    final result = await showModalBottomSheet(
      //acerto teclado
      isScrollControlled: true,
      context: context,
      builder: (_) => const CxCentroCustosList(),
    );
    print(result.descricao);
    _getCentroCustosDescricao(result.id);
  }

  onSubmit() {
    formKey.currentState?.validate();
    formKey.currentState?.save();
    print(formData);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    formData['id'] = 0;
    formData['data'] = '01102023';
    formData['valor'] = '';
    formData['historico'] = '';
    formData['id_centrocustos'] = 0;
  }

  @override
  Widget build(BuildContext context) {
    centrosCustos =
        Provider.of<CentroCustosProvider>(context).getRegistros();

    // if (ccSelected.isEmpty) {
    //   ccSelected = centrosCustos[0].descricao;
    // }

    Color corFundo = sinalSeletor ? Colors.red : Colors.blue;
    Icon iconBotao = Icon(sinalSeletor ? Icons.remove : Icons.add, size: 30);

    return Scaffold(
      // drawer: ,
      appBar: AppBar(
        title: const Text('Movimento'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => CxMovimentoFiltro()));
            },
            icon: const Icon(Icons.search),
            label: const Text('Movimento'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Data
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: dataController,
                      larguraInput: 150,
                      label: 'Data',
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Insira uma data.';
                        }

                        if (!Validadores.isValidDate(data)) {
                          return 'Data Inválida.';
                        }

                        return null;
                      },
                      inputFormatters: [dataFormarter],
                      // [
                      //   MaskTextInputFormatter(
                      //       mask: "##/##/####", initialText: dataController.text),
                      // ],
                      onSaved: (data) => formData['data'] = data ?? '',
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(top: 0, bottom: 2),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2024),
                        );
                        String data = newDate.toString();

                        setState(() {
                          String datax =
                              '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)}';
                          dataController.text = datax;
                        });
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        size: 38,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                //Valor
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Insira uma valor.';
                        }

                        if (!Validadores.isValidDate(valor)) {
                          return 'valor Inválida.';
                        }

                        return null;
                      },
                      larguraInput: 150,
                      label: 'Valor',
                      maxLength: 14,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'pt-BR',
                          decimalDigits: 2,
                          symbol: '',
                        ),
                      ],
                      onSaved: (valor) => formData['valor'] = valor ?? '',
                    ),

                    //Sinal
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sinalSeletor = !sinalSeletor;
                          formData['sinal'] = sinalSeletor;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: corFundo,
                            ),
                            height: 36,
                            width: 70,
                          ),
                          Positioned(
                            left: sinalSeletor ? 34 : 0,
                            right: sinalSeletor ? 0 : 34,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green.shade300,
                              ),
                              height: 35,
                              width: 35,
                              child: iconBotao,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                //Historico
                CustomTextField(
                  validator: (historico) {
                    if (historico == null || historico.isEmpty) {
                      return 'Insira uma historico.';
                    }

                    if (!Validadores.isValidDate(historico)) {
                      return 'historico Inválida.';
                    }

                    return null;
                  },
                  // controller: historicoController,
                  label: 'Histórico',
                  minLines: 2,
                  maxLines: 2,
                  inputFormatters: [MaxLinesInputFormatter(2)],
                  onSaved: (historico) =>
                      formData['historico'] = historico ?? '',
                ),
                const SizedBox(
                  height: 20,
                ),

                //Centro Custos
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      color: Colors.white,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: idCentroCustosController,
                            larguraInput: 70,
                            maxLength: 4,
                            label: '',
                            onSaved: (idCentroCustos) =>
                                formData['id_centrocustos'] =
                                    idCentroCustos ?? '',
                          ),
                          Container(
                            width: 350,
                            padding: const EdgeInsets.only(
                                left: 8, top: 8, bottom: 6),
                            margin: const EdgeInsets.only(left: 0, bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey.shade300,
                            ),
                            child: Text(centroCustosDescricao),
                          ),
                          IconButton(
                              padding: const EdgeInsets.only(bottom: 5),
                              onPressed: _buscaCentroCustos,
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                    Positioned(
                      left: 8,
                      top: 1,
                      child: Container(
                          color: Colors.white,
                          child: const Text(
                            ' Centro de Custos ',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                //botao salvar
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text('Salvar'),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       bottom: MediaQuery.of(context).viewInsets.bottom),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}