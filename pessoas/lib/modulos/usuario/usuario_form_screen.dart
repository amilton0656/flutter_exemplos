import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pessoas/models/models.dart';
import 'package:pessoas/modulos/usuario/usuario_provider.dart';
import 'package:pessoas/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:pessoas/widgets/custom_pick_image.dart' as open;

import '../../utils/paleta_cores.dart';

class UsuarioFormScreen extends StatefulWidget {
  final UsuarioModel? usuario;

  const UsuarioFormScreen({super.key, this.usuario});

  @override
  State<UsuarioFormScreen> createState() => _UsuarioFormScreenState();
}

class _UsuarioFormScreenState extends State<UsuarioFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;
  String? base64String = '';
  Uint8List? bytesImage;

  pegaImagem() async {
    bytesImage = await open.openImage();
    if (bytesImage != null) {
      setState(() {
        _formData['imagem'] = base64Encode(bytesImage!);
      });
    }
  }

  onSubmitForm() {
    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    Provider.of<UsuarioProvider>(context, listen: false)
        .saveUsuario(_formData)
        .catchError((error) {
      print('error $error');
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

  Widget mostraImagemPerfil(Uint8List? bytesImage) {
    if (bytesImage != null && bytesImage.isNotEmpty) {
      return ClipOval(
        child: Image.memory(bytesImage, width: 120, height: 120),
      );
    } else {
      return ClipOval(
        child: Image.asset(
          'assets/images/perfil.png',
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      // final arg = ModalRoute.of(context)?.settings.arguments;

      if (widget.usuario != null) {
        final usuario = widget.usuario as UsuarioModel;

        _formData['id'] = usuario.id;
        _formData['nome'] = usuario.nome;
        _formData['email'] = usuario.email;
        _formData['senha'] = usuario.senha;
        _formData['imagem'] = usuario.imagem;

        base64String = usuario.imagem;

        bytesImage = base64Decode(base64String!);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                largura > 900 ? Colors.blue.shade300 : Colors.white,
                largura > 900 ? PaletaCores.corNavy : Colors.white,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(largura > 500 ? 10 : 0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(top: largura > 500 ? 20 : 0),
                width: largura > 800 ? 800 : largura,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          mostraImagemPerfil(bytesImage),
                          TextButton(
                            onPressed: () {
                              pegaImagem();
                            },
                            child: const Text('Atualizsar Imagem'),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //Nome
                          CustomTextField(
                            initialValue: _formData['nome']?.toString(),
                            onSaved: (nome) => _formData['nome'] = nome ?? '',
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
                            initialValue: _formData['email']?.toString(),
                            onSaved: (email) =>
                                _formData['email'] = email ?? '',
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
                            initialValue: _formData['senha']?.toString(),
                            onSaved: (senha) =>
                                _formData['senha'] = senha ?? '',
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
                              onPressed: () {
                                onSubmitForm();
                              },
                              //  Navigator.of(context).pop(),
                              child: const Text('Salvar')),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
