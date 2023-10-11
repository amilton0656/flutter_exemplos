import 'package:flutter/material.dart';

import 'package:caixa/widgets/custom_text_field.dart';
import 'package:caixa/utils/formatadores.dart';
import 'package:caixa/utils/validadores.dart';

class CustomDateField extends StatefulWidget {
  final String label;
  final bool dateLarguraMenor;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;

  const CustomDateField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.dateLarguraMenor = false,
    this.onSaved,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double larguraScreen = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Data Inicial
        CustomTextField(
          controller: widget.controller,
          larguraInput: larguraScreen < 500 && widget.dateLarguraMenor ? 120 : 150,
          label: widget.label,
          onSaved: widget.onSaved,
          validator: widget.validator ?? (data) {
            if (data == null || data.isEmpty) {
              return 'Insira uma data.';
            }

            if (!Validadores.isValidDate(data)) {
              return 'Data Inválida.';
            }

            return null;
          },
          inputFormatters: [Formatadores.dataFormarter],
        ),
        const SizedBox(
          width: 5,
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
              widget.controller.text = datax;
            });
          },
          icon: const Icon(
            Icons.calendar_month,
            size: 38,
          ),
        ),
      ],
    );
  }
}
