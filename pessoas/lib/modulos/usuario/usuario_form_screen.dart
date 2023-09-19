import 'package:flutter/material.dart';
import 'package:pessoas/widgets/custom_text_field.dart';

class UsuarioFormScreen extends StatefulWidget {
  const UsuarioFormScreen({super.key});

  @override
  State<UsuarioFormScreen> createState() => _UsuarioFormScreenState();
}

class _UsuarioFormScreenState extends State<UsuarioFormScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              //Nome
              CustomTextField(
                controller: _nomeController,
                // icon: Icons.email,
                label: 'Nome',
                validator: (nome) {
                  if (nome == null || nome.isEmpty) {
                    return 'Digite seu nome.';
                  }
                  if (nome.length < 3) {
                    return 'Nome deve ter pelo menos 3 letras.';
                  }
                  return null;
                },
              ),

              //Email
              CustomTextField(
                controller: _emailController,
                // icon: Icons.email,
                label: 'Email',
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Digite seu email.';
                  }
                  if (!email.contains('@')) {
                    return 'Digite um email válido.';
                  }
                  return null;
                },
              ),

              //Senha
              CustomTextField(
                controller: _senhaController,
                // icon: Icons.email,
                label: 'Senha',
                validator: (senha) {
                  if (senha == null || senha.isEmpty) {
                    return 'Digite uma senha.';
                  }
                  if (senha.length < 3) {
                    return 'Senha deve ter pelo menos 3 letras.';
                  }
                  return null;
                },
              ),

              //Botao Salvar
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
