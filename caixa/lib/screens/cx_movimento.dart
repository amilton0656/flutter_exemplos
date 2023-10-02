import 'package:caixa/models/centrocustos_model.dart';
import 'package:caixa/utils/validadores.dart';
import 'package:caixa/widgets/custom_text_field.dart';
import 'package:caixa/widgets/max_Lines_Input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class CxMovimento extends StatefulWidget {
  const CxMovimento({super.key});

  @override
  State<CxMovimento> createState() => _CxMovimentoState();
}

class _CxMovimentoState extends State<CxMovimento> {
  TextEditingController dataController = TextEditingController();
  String isSwitched = '+';

  final formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};

  final List<CentroCustosModel> centroCustos = [
    CentroCustosModel(id: 1, descricao: 'Bliss'),
    CentroCustosModel(id: 1, descricao: 'Cota Office'),
  ];

  final dataFormarter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  onSubmit() {
    formKey.currentState?.validate();
    // formKey.currentState?.save();
    print(formData);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    formData['id'] = 0;
    formData['data'] = '01102023';
    formData['valor'] = '';
    formData['historico'] = '';
    formData['id_centrocustos'] = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimento'),
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
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      child: IconButton(
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
                          size: 40,
                        ),
                      ),
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
                    ),

                    //Sinal
                    GestureDetector(
                      onTap: () {
                        String sig = isSwitched == '+' ? '-' : '+';
                        setState(() {
                          isSwitched = sig;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, top: 2),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: isSwitched == '+' ? Colors.green : Colors.red,
                        ),
                        child: isSwitched == '+'
                            ? const Icon(
                                Icons.add,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
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
                ),
                const SizedBox(
                  height: 20,
                ),

                //Centro Custos
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Centro de Custos: '),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                        value: 'Cota Office',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        items: centroCustos.map((itemone) {
                          return DropdownMenuItem(
                              value: itemone.descricao,
                              child: Text(itemone.descricao));
                        }).toList(),
                        onChanged: (_) {}),
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
