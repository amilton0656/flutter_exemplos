import 'package:calculadora2/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle =
      TextStyle(fontSize: 30, color: Colors.deepPurple.shade900);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemCount: buttons.length,
              itemBuilder: (ctx, index) {
                //botao clear
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                      });
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                  );

                  //botao delete
                } else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                  );
                }

                //botao equal
                else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: equalPressed,
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                  );
                } else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple.shade50,
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                    buttonText: buttons[index],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'X' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      userAnswer = eval.toString();
    });
  }
}
