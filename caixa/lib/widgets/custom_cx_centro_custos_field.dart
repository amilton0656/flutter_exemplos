import 'package:caixa/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomCxCentroCustosField extends StatefulWidget {
  const CustomCxCentroCustosField({super.key});

  @override
  State<CustomCxCentroCustosField> createState() =>
      _CustomCxCentroCustosFieldState();
}

class _CustomCxCentroCustosFieldState extends State<CustomCxCentroCustosField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          color: Colors.white,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(
                // controller: idCentroCustosController,
                larguraInput: 70,
                maxLength: 4,
                label: '',
                // onSaved: (idCentroCustos) =>
                //     formData['id_centrocustos'] =
                //         idCentroCustos ?? '',
              ),
              Container(
                width: 350,
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 6),
                margin: const EdgeInsets.only(left: 0, bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.grey.shade300,
                ),
                child: const Text('centroCustosDescricao'),
              ),
              IconButton(
                  padding: const EdgeInsets.only(bottom: 5),
                  onPressed: () {},
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
    );
  }
}
