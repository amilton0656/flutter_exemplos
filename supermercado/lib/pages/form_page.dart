import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/item_provider.dart';

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

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      // final arg = ModalRoute.of(context)?.settings.arguments;

      if (widget.item != null) {
        final item = widget.item as ItemModel;

        _formData['id'] = item.id;
        _formData['descricao'] = item.descricao;
        _formData['quantidade'] = item.quantidade;
        _formData['usuario'] = item.usuario;
        _formData['isBought'] = item.isBought;
      } else {
        _formData['usuario'] = widget.usuario;
        _formData['isBought'] = false;
      }
    }
  }

  onSubmitForm() {
    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    Provider.of<ItemProvider>(context, listen: false)
        .saveItem(_formData, widget.usuario)
        .catchError((error) {
      return showDialog<void>(
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
    }).then((value) {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    });
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
                TextFormField(
                  initialValue: _formData['descricao']?.toString(),
                  onSaved: (descricao) =>
                      _formData['descricao'] = descricao ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  initialValue: _formData['quantidade']?.toString(),
                  onSaved: (quantidade) =>
                      _formData['quantidade'] = double.parse(quantidade ?? '0'),
                  decoration: const InputDecoration(
                    labelText: 'Quantidade',
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                      onPressed: () {
                        onSubmitForm();
                      },
                      child: const Text('Salvar'),
                    ),
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
