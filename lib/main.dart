import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expressionText = 'expression';
  String resultText = 'result';

  String inputExpression = '';
  evaluateExpression(String inputExpression) {
    //print('expresssion entered is $inputExpression');
    Parser parser = Parser();
    Expression expression = parser.parse(inputExpression);
    double resultValue =
        expression.evaluate(EvaluationType.REAL, ContextModel());
    //print('RESULT IS ************* $resultValue');
    resultText = '$resultValue';
  }

  readInputs(buttonText) {
    if (buttonText == 'AC') {
      inputExpression = '';
      resultText = '';
    } else if (buttonText == '<-') {
      inputExpression =
          inputExpression.substring(0, inputExpression.length - 1);
    } else if (buttonText == '=') {
      // evaluation of Expression
      evaluateExpression(inputExpression);
      //reset the expression String after evaluation
      inputExpression = '';
    } else if (buttonText == 'x') {
      inputExpression += '*';
    } else {
      inputExpression += buttonText;
    }
    print('expresssion entered is $inputExpression');
    expressionText = inputExpression;
  }

  Widget createButton({
    buttonText = "Text",
    Color buttonTextColor = Colors.white,
    buttonBgColor,
  }) {
    buttonBgColor ??= Colors.grey[800];

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBgColor,
          shadowColor: Colors.grey[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        ),
        onPressed: () {
          setState(() {
            setState(() {
              readInputs(buttonText);
            });
          });
          // print(buttonText);
          // print(temp);
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: const Text('Calculator'),
      ),
      body: Container(
        child: Column(
          children: [
            //1. for text display
            SizedBox(
              width: 480,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  //I. Expression entered
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //1. expression text
                    Container(
                      color: Colors.blueAccent,
                      margin: const EdgeInsets.only(bottom: 25.0),
                      child: Text(
                        expressionText,
                        style: const TextStyle(
                            fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                    //2. Result Text
                    Text(
                      resultText,
                      style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            //2. buttons layout
            Expanded(
              child: Container(
                color: Colors.grey[900],
                margin: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //1. row of buttons
                        children: [
                          createButton(
                              buttonText: "AC", buttonBgColor: Colors.orange),
                          createButton(buttonText: "<-"),
                          createButton(
                              buttonText: "%", buttonTextColor: Colors.orange),
                          createButton(
                              buttonText: "/", buttonTextColor: Colors.orange),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //2. row of 7 8 9 x
                          children: [
                            createButton(buttonText: "7"),
                            createButton(buttonText: "8"),
                            createButton(buttonText: "9"),
                            createButton(
                                buttonText: "x",
                                buttonTextColor: Colors.orange),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //3. row of 4 5 6 -
                          children: [
                            createButton(buttonText: "4"),
                            createButton(buttonText: "5"),
                            createButton(buttonText: "6"),
                            createButton(
                                buttonText: "-",
                                buttonTextColor: Colors.orange),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //3. row of 4 5 6 -
                          children: [
                            createButton(buttonText: "1"),
                            createButton(buttonText: "2"),
                            createButton(buttonText: "3"),
                            createButton(
                                buttonText: "+",
                                buttonTextColor: Colors.orange),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //3. row of 4 5 6 -
                          children: [
                            createButton(buttonText: "."),
                            createButton(buttonText: "0"),
                            const Expanded(child: SizedBox()),
                            createButton(
                                buttonText: "=",
                                buttonTextColor: Colors.orange),
                          ]),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
