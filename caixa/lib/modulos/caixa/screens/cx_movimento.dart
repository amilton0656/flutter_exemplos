import 'dart:async';

import 'package:caixa/modulos/caixa/models/cx_centrocustos_model.dart';
import 'package:caixa/modulos/caixa/models/cx_movimento_model.dart';
import 'package:caixa/modulos/caixa/providers/cx_centro_custos_provider.dart';
import 'package:caixa/modulos/caixa/providers/cx_movimento_provider.dart';
import 'package:caixa/modulos/caixa/screens/cx_centro_custos_list.dart';
import 'package:caixa/utils/formatadores.dart';
import 'package:caixa/utils/validadores.dart';
import 'package:caixa/widgets/custom_date_field.dart';
import 'package:caixa/widgets/custom_search_field.dart';
import 'package:caixa/widgets/custom_text_field.dart';
import 'package:caixa/widgets/max_Lines_Input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CxMovimento extends StatefulWidget {
  final CxMovimentoModel? cxLancamento;
  const CxMovimento({super.key, this.cxLancamento});

  @override
  State<CxMovimento> createState() => _CxMovimentoState();
}

class _CxMovimentoState extends State<CxMovimento> {
  TextEditingController dataController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController historicoController = TextEditingController();
  TextEditingController idCentroCustosController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  String ccSelected = '';
  String centroCustosDescricao = '';
  List<CxCentroCustosModel> centrosCustos = [];

  bool sinalSeletor = false;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      Provider.of<CxCentroCustosProvider>(context, listen: false)
          .loadRegistros();
    });
  }

  final dataFormarter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  Future<dynamic> _buscarRegistros() async {
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

  Future<dynamic> getDescricao(String id) async {
    dynamic descricao = '';
    descricao =
        await Provider.of<CxCentroCustosProvider>(context, listen: false)
            .getDescricao(id);
    return descricao;
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() != null) {
      _formKey.currentState?.save();
      _formData['sinal'] = sinalSeletor ? '+' : '-';
      setState(() => isLoading = true);
      final response =
          await Provider.of<CxMovimentoProvider>(context, listen: false)
              .saveRegistro(_formData);
      setState(() => isLoading = false);
      if (response) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      if (widget.cxLancamento != null) {
        final item = widget.cxLancamento as CxMovimentoModel;
        final desc =await getDescricao(item.id_centrocustos.toString());
        setState(() {
          _formData['id'] = item.id;
          _formData['data'] = item.data;
          _formData['valor'] = Formatadores.numberToFormatted(item.valor);
          _formData['sinal'] = item.sinal;
          _formData['historico'] = item.historico;
          _formData['id_centrocustos'] = item.id_centrocustos;
          dataController.text = item.data;
          valorController.text = Formatadores.numberToFormatted(item.valor);
          sinalSeletor = item.sinal == "+" ? true : false;
          historicoController.text = item.historico;
          idCentroCustosController.text = item.id_centrocustos.toString();
          descricaoController.text = desc['descricao'].toString();
        });

        print(_formData);
      } else {
        _formData['id'] = 0;
        _formData['data'] = '';
        _formData['valor'] = '';
        _formData['historico'] = '';
        _formData['id_centrocustos'] = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    centrosCustos = Provider.of<CxCentroCustosProvider>(context).getRegistros();
    double larguraScreen = MediaQuery.of(context).size.width;
    Color corFundo = sinalSeletor ? Colors.blue : Colors.red;
    Icon iconBotao = Icon(sinalSeletor ? Icons.add : Icons.remove, size: 30);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimento'),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (ctx) => CxMovimentoFiltro(
              //           onGetDescricao: getDescricao,
              //         )));
            },
            icon: const Icon(Icons.search),
            label: const Text('Movimento'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: larguraScreen > 500 ? 500 : larguraScreen,
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /** Data ******************************************************* */
                CustomDateField(
                  label: 'Data Inicial',
                  controller: dataController,
                  onSaved: (data) => _formData['data'] = data ?? '',
                ),
                const SizedBox(
                  height: 20,
                ),

                /** Linha - Valor e Sinal ******************************************************* */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /** Valor ******************************************************* */
                    CustomTextField(
                      controller: valorController,
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Insira um valor.';
                        }

                        double val = Validadores.StringToDouble(valor);
                        if (!(val > 0)) {
                          return 'Valor inválido.';
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
                      onSaved: (valor) => _formData['valor'] = valor ?? '',
                    ),

                    /** Sinal ******************************************************* */
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sinalSeletor = !sinalSeletor;
                          _formData['sinal'] = sinalSeletor;
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
                            right: sinalSeletor ? 34 : 0,
                            left: sinalSeletor ? 0 : 34,
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

                /** Histórico ******************************************************* */
                CustomTextField(
                  controller: historicoController,
                  validator: (historico) {
                    if (historico == null || historico.isEmpty) {
                      return 'Insira um historico.';
                    }

                    return null;
                  },
                  label: 'Histórico',
                  minLines: 2,
                  maxLines: 2,
                  inputFormatters: [MaxLinesInputFormatter(2)],
                  onSaved: (historico) =>
                      _formData['historico'] = historico ?? '',
                ),
                const SizedBox(
                  height: 20,
                ),

                //** Centro Custos ********************************************************** */
                CustomSearchField(
                  descricaoController: descricaoController,
                  onGetDescricao: getDescricao,
                  controller: idCentroCustosController,
                  label: 'Centro de Custos',
                  onBuscar: _buscarRegistros,
                  onSaved: (idCentroCustos) =>
                      _formData['id_centrocustos'] = idCentroCustos ?? '',
                ),

                const SizedBox(
                  height: 20,
                ),

                /** botao salvar ******************************************************* */
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
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
