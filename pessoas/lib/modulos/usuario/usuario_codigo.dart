import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';

class UsuarioCodigo extends StatelessWidget {
  const UsuarioCodigo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Digite abaixo o código enviado para o seu email.'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Seu email',
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: () {}, child: Text('Enviar código')),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Seu email',
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: () {}, child: Text('Confirmar')),
            ],
          ),
        ));
  }
}
