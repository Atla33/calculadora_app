import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  double _result = 0.0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          _result = _evaluateExpression();
        } catch (e) {
          _result = 0.0;
        }
        _input = _result.toString();
      } else if (buttonText == 'C') {
        _input = '';
        _result = 0.0;
      } else {
        _input += buttonText;
      }
    });
  }

  double _evaluateExpression() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _input,
              style: TextStyle(fontSize: 24.0, color: Colors.blueGrey),
            ),
            SizedBox(height: 20),
            Text(
              _result.toString(),
              style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 20),
            CalculatorButtons(onButtonPressed: _onButtonPressed),
          ],
        ),
      ),
    );
  }
}

class CalculatorButtons extends StatelessWidget {
  final Function(String) onButtonPressed;

  const CalculatorButtons({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(text: '7', onPressed: onButtonPressed),
            CalculatorButton(text: '8', onPressed: onButtonPressed),
            CalculatorButton(text: '9', onPressed: onButtonPressed),
            CalculatorButton(text: '/', onPressed: onButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(text: '4', onPressed: onButtonPressed),
            CalculatorButton(text: '5', onPressed: onButtonPressed),
            CalculatorButton(text: '6', onPressed: onButtonPressed),
            CalculatorButton(text: '*', onPressed: onButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(text: '1', onPressed: onButtonPressed),
            CalculatorButton(text: '2', onPressed: onButtonPressed),
            CalculatorButton(text: '3', onPressed: onButtonPressed),
            CalculatorButton(text: '-', onPressed: onButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(text: '0', onPressed: onButtonPressed),
            CalculatorButton(text: '.', onPressed: onButtonPressed),
            CalculatorButton(text: '=', onPressed: onButtonPressed),
            CalculatorButton(text: '+', onPressed: onButtonPressed),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalculatorButton(text: 'C', onPressed: onButtonPressed),
          ],
        ),
      ],
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  const CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
