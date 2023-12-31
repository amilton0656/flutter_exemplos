import 'package:flutter/material.dart';
import 'package:caixa/widgets/custom_text_field.dart';

class CustomSearchField extends StatefulWidget {
  final String label;
  final Function onBuscar;
  final TextEditingController? controller;
  final TextEditingController? descricaoController;
  final String? Function(String?)? onSaved;
  final FocusNode? focusNode;
  final Future<dynamic> Function(String) onGetDescricao;

  const CustomSearchField({
    super.key,
    required this.label,
    required this.onBuscar,
    required this.onGetDescricao,
    this.controller,
    this.descricaoController,
    this.onSaved,
    this.focusNode,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  FocusNode focusNode = FocusNode();
  // TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        widget.onGetDescricao(widget.controller!.text).then((value) {
          if (value == null) {
            widget.controller!.text = '';
            setState(() {
              if (widget.descricaoController != null) {
                widget.descricaoController!.text = '';
              }
            });
          } else {
            setState(() {
              if (widget.descricaoController != null) {
                widget.descricaoController!.text =
                    value['descricao'].toString();
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();

    super.dispose();
  }

  void _getDescricao(int id, String descri) {
    setState(() {
      widget.controller!.text = id.toString();
      if (widget.descricaoController != null) {
        widget.descricaoController!.text = descri;
      }
    });
  }

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
              /** Código ******************************************************** */
              CustomTextField(
                focusNode: focusNode,
                controller: widget.controller,
                larguraInput: 70,
                maxLength: 4,
                label: '',
                onSaved: widget.onSaved,
                // validator: (id) {
                //   if (id == null || id.isEmpty) {
                //     return 'Insira um valor.';
                //   }

                //   int val = int.tryParse(id) ?? 0;
                //   if (!(val > 0)) {
                //     return 'Valor inválido.';
                //   }

                //   return null;
                // },
              ),

              /** Display ******************************************************** */
              Expanded(
                child: CustomTextField(
                  label: '',
                  controller: widget.descricaoController,
                  readOnly: true,
                  // larguraInput: 300,
                  validator: (value) {
                    if (widget.controller == null) {
                      return 'Insira um valor.';
                    }
                    if (widget.controller!.text.isEmpty) {
                      return 'Insira uma informação válida.';
                    }

                    return null;
                  },
                ),
              ),
              // Container(
              //   width: 350,
              //   padding: const EdgeInsets.only(left: 8, top: 8, bottom: 6),
              //   margin: const EdgeInsets.only(left: 0, bottom: 20),
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: Colors.grey.shade500),
              //     borderRadius: BorderRadius.circular(10),
              //     // color: Colors.grey.shade300,
              //   ),
              //   child: Text(descricao),
              // ),

              /** Search icon ******************************************************** */
              IconButton(
                  padding: const EdgeInsets.only(bottom: 5),
                  onPressed: () async {
                    final res = await widget.onBuscar();
                    if (res != null) {
                      _getDescricao(res["id"], res["descricao"]);
                    }
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ))
            ],
          ),
        ),

        /** Label ******************************************************** */
        Positioned(
          left: 8,
          top: 1,
          child: Container(
              color: Colors.white,
              child: Text(
                ' ${widget.label} ',
                style: const TextStyle(fontSize: 12),
              )),
        ),
      ],
    );
  }
}

/*

lose focus

FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
      print('Perdeu foco 1:  ${focusNode.hasFocus}');

      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();

    super.dispose();
  }


  e dentro do textField

  focusNode: focusNode,



*/
