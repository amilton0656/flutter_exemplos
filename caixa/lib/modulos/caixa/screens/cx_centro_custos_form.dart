import 'package:caixa/modulos/caixa/models/centrocustos_model.dart';
import 'package:caixa/modulos/caixa/providers/cx_centro_custos_provider.dart';
import 'package:caixa/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CxCentroCustosForm extends StatefulWidget {
  final CentroCustosModel? centroCusto;
  const CxCentroCustosForm({
    super.key,
    this.centroCusto,
  });

  @override
  State<CxCentroCustosForm> createState() => _CxCentroCustosFormState();
}

class _CxCentroCustosFormState extends State<CxCentroCustosForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool isLoading = false;

  void _onSubmit() async {
    if (_formKey.currentState?.validate() != null) {
      _formKey.currentState?.save();
      setState(() => isLoading = true);
      final response =
          await Provider.of<CentroCustosProvider>(context, listen: false)
              .saveRegistro(_formData);
      setState(() => isLoading = false);
      if (response) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
    }
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      // final arg = ModalRoute.of(context)?.settings.arguments;

      if (widget.centroCusto != null) {
        final centroCusto = widget.centroCusto as CentroCustosModel;

        _formData['id'] = centroCusto.id;
        _formData['descricao'] = centroCusto.descricao;
      } else {
        _formData['descricao'] = '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Custos'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Descrição',
                initialValue: _formData['descricao'].toString(),
                validator: (descricao) {
                  if (descricao == null || descricao.isEmpty) {
                    return 'Insira a descrição.';
                  }
                  return null;
                },
                onSaved: (descricao) =>
                    _formData['descricao'] = descricao ?? '',
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  _onSubmit();
                },
                icon: isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.save),
                label: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//um setTimeout para testar
//final tempo = await Timer(Duration(seconds: 5), () =>  setState(() => isLoading = false));
