// import 'package:bcrypt/bcrypt.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:pessoas/modulos/usuario/home_screen.dart';

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
  Login login = Login(
    nome: '',
    senha: '',
  );

  _submitForm() {
    print('SUBMIT');
    pegaGet();
    final validado = _formKey.currentState!.validate();
    if (validado) {
      setState(() {
        login = Login(
          nome: _controllerEmail.text,
          senha: _controllerSenha.text,
        );
      });

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      // );
    }
  }

  pegaGet() async {
    print('PEGA');
    // final usu = jsonEncode({"nome": "abcde", "senha": "22222"});
    final url = Uri.parse('http://www.amilton.com.br/api/usuario/login');
    // final response = await http.get(url);
    final response =
        await http.post(url, body: {"nome": "abcde", "senha": "22222"});
    print(response.body);
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
                              CustomTextField(
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
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 16),
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
