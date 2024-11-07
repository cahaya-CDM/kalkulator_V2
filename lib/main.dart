import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String jumlah = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        output = '0';
        jumlah = '';
      } else if (buttonText == '=') {
        try {
          final parsedExpression = Expression.parse(jumlah);
          final evaluator = ExpressionEvaluator();
          final result = evaluator.eval(parsedExpression, {});
          output = result.toString();
        } catch (e) {
          output = 'error';
        }
      } else{
        jumlah += buttonText;
      }
    });
  }

  Widget _buildButton(String text, Color color, {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 0
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 28, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24, right: 24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    jumlah,
                    style: TextStyle(fontSize: 28, color: Colors.grey),
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('C', Colors.grey),
                  _buildButton('-/+', Colors.grey),
                  _buildButton('%', Colors.grey),
                  _buildButton('/', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('7', Colors.white),
                  _buildButton('8', Colors.white),
                  _buildButton('9', Colors.white),
                  _buildButton('*', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', Colors.white),
                  _buildButton('5', Colors.white),
                  _buildButton('6', Colors.white),
                  _buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', Colors.white),
                  _buildButton('2', Colors.white),
                  _buildButton('3', Colors.white),
                  _buildButton('+', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', widthFactor: 2.0, Colors.white),
                  _buildButton('.', Colors.white),
                  _buildButton('=', Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
