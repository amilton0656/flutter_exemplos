import 'package:flutter/material.dart';
import 'package:pessoas/widgets/custom_text_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            child: Column(
          children: [
            const CustomTextField(
              label: 'Nome',
            ),
            const CustomTextField(
              label: 'Email',
            ),
            const CustomTextField(
              label: 'Senha',
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Salvar'))
          ],
        )),
      ),
    );
  }
}
