import 'package:flutter/material.dart';
import 'package:pessoas/data/app_data.dart' as app_data;
import 'package:pessoas/modulos/usuario/form_screen.dart';
import 'package:pessoas/utils/paleta_cores.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pessoas = app_data.pessoas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: pessoas.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(pessoas[index].nome),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const FormScreen(),
        )),
        backgroundColor: PaletaCores.corFundoBotao,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
