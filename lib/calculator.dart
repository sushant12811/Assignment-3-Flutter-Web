import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  // ignore: use_super_parameters
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  String operation = '';
  double num1 = 0;
  double num2 = 0;
  bool isResultDisplayed = false;
  bool isOperationSelected = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        num1 = 0;
        num2 = 0;
        operation = '';
        isResultDisplayed = false;
        isOperationSelected = false;
      } else if (value == '=') {
        if (operation.isNotEmpty) {
          num2 = double.tryParse(display) ?? 0;
          switch (operation) {
            case '+':
              display = (num1 + num2).toString();
              break;
            case '-':
              display = (num1 - num2).toString();
              break;
            case '*':
              display = (num1 * num2).toString();
              break;
            case '/':
              if (num2 != 0) {
                display = (num1 / num2).toString();
              } else {
                display = 'Error';
              }
              break;
          }
          operation = '';
          num1 = double.tryParse(display) ?? 0;
          isResultDisplayed = true;
          isOperationSelected = false;
        }
      } else if (['+', '-', '*', '/'].contains(value)) {
        if (isResultDisplayed) {
          // After displaying result, start new calculation with the last result
          num1 = double.tryParse(display) ?? 0;
          operation = value;
          display = num1.toInt().toString();
          isResultDisplayed = false;
          isOperationSelected = true;
        } else {
          num1 = double.tryParse(display) ?? 0;
          operation = value;
          display = num1.toInt().toString(); 
          isOperationSelected = true;
        }
      } else {
        if (display == '0' || isResultDisplayed) {
          display = value;
          isResultDisplayed = false;
        } else if (isOperationSelected) {
          display = value;
          isOperationSelected = false;
        } else {
          display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  display,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  final List<String> buttons = [
                    '7', '8', '9', '/',
                    '4', '5', '6', '*',
                    '1', '2', '3', '-',
                    'C', '0', '=', '+'
                  ];
                  final String buttonText = buttons[index];
                  return ElevatedButton(
                    onPressed: () => _onButtonPressed(buttonText),
                    // ignore: sort_child_properties_last
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontSize: 24),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(70, 70),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                                            backgroundColor: Colors.blueGrey.shade200,
                      foregroundColor: Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}