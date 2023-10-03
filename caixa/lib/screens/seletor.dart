import 'package:flutter/material.dart';

class Seletor extends StatefulWidget {
  const Seletor({super.key});

  @override
  State<Seletor> createState() => _SeletorState();
}

class _SeletorState extends State<Seletor> {
  bool tipo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              tipo = !tipo;
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.red,
                ),
                height: 50,
                width: 150,
              ),
              Positioned(
                left: tipo ? 98 : 0,
                right: tipo ? 0 : 98,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                  ),
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
