import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/item_provider.dart';
import 'package:supermercado/pages/constantes.dart' as constantes;
import 'package:supermercado/pages/historico_page.dart';

class FormPage extends StatefulWidget {
  final String usuario;
  final ItemModel? item;

  const FormPage({super.key, required this.usuario, this.item});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  final TextEditingController _descricaoController = TextEditingController();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      // final arg = ModalRoute.of(context)?.settings.arguments;

      if (widget.item != null) {
        final item = widget.item as ItemModel;
        // if (!constantes.grupos.contains(item.grupo)) {}

        _formData['id'] = item.id;
        _formData['usuario'] = item.usuario;
        _formData['descricao'] = item.descricao;
        _formData['quantidade'] = item.quantidade;
        _formData['grupo'] =
            constantes.grupos.contains(item.grupo) ? item.grupo : 'Outros';
        _formData['isBought'] = item.isbought;
        _descricaoController.text = item.descricao;
      } else {
        _formData['usuario'] = widget.usuario;
        _formData['descricao'] = '';
        _formData['quantidade'] = '';
        _formData['grupo'] = constantes.grupos[4];
        _formData['isBought'] = false;
      }
    }
  }

  onDescricao(String value) {
    setState(() {
      _formData['descricao'] = value;
    });
    print('onDescricao $value - ${_formData['descricao']}');
  }

  Future<bool> onSubmitForm() async {
    _formKey.currentState?.save();

    setState(() => _isLoading = false);

    final response = await Provider.of<ItemProvider>(context, listen: false)
        .saveItem(_formData, widget.usuario);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    //acerto teclado
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Padding(
        //acerto teclado
        padding: mediaQueryData.viewInsets,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.usuario,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                IconButton(
                  onPressed: () async {
                    String? response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const HistoricoPage(),
                      ),
                    );
                    if (response != null) {
                      setState(() {
                        _descricaoController.text = response;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 40,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //descrição
                TextFormField(
                  controller: _descricaoController,
                  onSaved: (descricao) =>
                      _formData['descricao'] = descricao ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                //Quantidade
                TextFormField(
                  initialValue: _formData['quantidade']?.toString(),
                  onSaved: (quantidade) =>
                      _formData['quantidade'] = quantidade ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Quantidade',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                //DropDown - Grupo
                DropdownButton(
                  value: _formData['grupo'].toString(),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      _formData['grupo'] = newValue ?? '';
                    });
                  },
                  items: constantes.grupos.map((itemone) {
                    return DropdownMenuItem(
                        value: itemone, child: Text(itemone));
                  }).toList(),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Sair'),
                          ),
                    ElevatedButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              child: const Text('sdfsdfsf'),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        if (await onSubmitForm() == false) {
                          print('erro false');
                        } else {
                          print('erro true');
                          setState(() => _isLoading = false);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Salvar'),
                    ),

                    /*
                    ElevatedButton(
                      onPressed: () async {
                        if (await onSubmitForm() == false) {
                          // ignore: use_build_context_synchronously
                          showDialog<void>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Erro !'),
                        content: const Text('Ocorreu um erro.'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                setState(() => _isLoading = false);
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'))
                        ],
                      ),
                    );
                          
                        } else {
                          setState(() => _isLoading = false);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                    */
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
