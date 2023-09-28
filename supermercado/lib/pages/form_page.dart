import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supermercado/item_historico.dart';
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
  }

  Future<bool> onSubmitForm() async {
    _formKey.currentState?.save();

    setState(() => _isLoading = false);

    final response = await Provider.of<ItemProvider>(context, listen: false)
        .saveItem(_formData, widget.usuario);

    return response;
  }

  _mostraMensagem() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          child: const Text('Ocorreu um erro!'),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //acerto teclado
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return SingleChildScrollView(
      reverse: true,
      child: Container(
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
                      HistoricoModel? response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HistoricoPage(),
                        ),
                      );
                      if (response != null) {
                        setState(() {
                          _descricaoController.text = response.descricao;
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
                  DropdownButton(
                    value: _formData['grupo'].toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
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
                  const SizedBox(
                    height: 30,
                  ),

                  //descrição
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (descricao) {
                      if (descricao == null || descricao.isEmpty) {
                        return 'Insira o nome de um produto.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (quantidade) {
                      if (quantidade == null || quantidade.isEmpty) {
                        return 'Insira uma quantidade.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) async {
                      if (_formKey.currentState!.validate()) {
                        if (await onSubmitForm() == false) {
                          _mostraMensagem();
                          print('erro false');
                        } else {
                          print('erro true');
                          setState(() => _isLoading = false);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    maxLength: 8,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                  

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _isLoading
                          ? const CircularProgressIndicator()
                          : TextButton.icon(
                              icon: const Icon(Icons.exit_to_app),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              label: const Text('Sair'),
                            ),
                      TextButton.icon(
                        icon: const Icon(Icons.save),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (await onSubmitForm() == false) {
                              _mostraMensagem();
                              print('erro false');
                            } else {
                              print('erro true');
                              setState(() => _isLoading = false);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        label: const Text('Salvar'),
                      ),
                    ],
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
      ),
    );
  }
}

/*
>> para posicionar acima quando abrir teclado
1. Scaffold(
      resizeToAvoidBottomInset: false,

2. body: SingleChildScrollView(
        reverse: true,

ultimo item da coluna

3. Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),

>> para fechar teclado
GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

>> BCrypt

final aaa = BCrypt.hashpw(_controllerSenha.text, BCrypt.gensalt())
final result = BCrypt.checkpw(_controllerSenha.text, aaa);


*/

