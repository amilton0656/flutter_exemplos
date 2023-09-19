import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pessoas/modulos/auth/auth_provider.dart';
import 'package:pessoas/modulos/usuario/usuario_lista_screen.dart';
import 'package:pessoas/utils/paleta_cores.dart';
import 'package:pessoas/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  bool isLoading = false;

  _submitForm(BuildContext context) async {
    () => FocusManager.instance.primaryFocus?.unfocus();
    final validado = _formKey.currentState!.validate();

    if (validado) {
      setState(() {
        isLoading = true;
      });

      final statusCode = await Provider.of<AuthProvider>(context, listen: false)
          .checkAuth(_controllerEmail.text, _controllerSenha.text);

      setState(() {
        isLoading = false;
      });

      if (statusCode >= 200 && statusCode < 300) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const UsuarioListaScreen()),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        if (statusCode == 408) {
          _openDialog('Sem conexão!', 'Verifique seu sinal de internet.');
        } else {
          _openDialog();
        }
      }
    }
  }

  _openDialog([String? aaa, String? bbb]) {
    String titulo = aaa ?? 'Acesso negado!';
    String conteudo = bbb ?? 'Email e/ou senha inválidos';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(conteudo),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade300,
            PaletaCores.corNavy,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                width: largura > 500 ? 500 : largura,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //Email
                              CustomTextField(
                                controller: _controllerEmail,
                                icon: Icons.email,
                                label: 'Email',
                                validator: (email) {
                                  if (email == null || email.isEmpty) {
                                    return 'Digite seu email.';
                                  }
                                  if (!email.contains('@')) {
                                    return 'Digite um email válido!';
                                  }
                                  return null;
                                },
                              ),

                              //Senha
                              CustomTextField(
                                onFieldSubmitted: (_) => _submitForm(context),
                                controller: _controllerSenha,
                                icon: Icons.lock,
                                label: 'Senha',
                                isSecret: true,
                                validator: (senha) {
                                  if (senha == null || senha.isEmpty) {
                                    return 'Digite sua senha.';
                                  }
                                  if (senha.length < 6) {
                                    return 'Senha deve conter pelo menos 6 caracteres!';
                                  }
                                  return null;
                                },
                              ),

                              //Botao entrar
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => _submitForm(context),
                                  child: Text(
                                    isLoading ? 'Verificando...' : 'Entrar',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Novo Cadastro'),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Esqueci a senha'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class Login {
  final String nome;
  final String senha;

  Login({
    required this.nome,
    required this.senha,
  });
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
