import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  String _operation = '';
  double _num1 = 0;
  double _num2 = 0;
  bool _isResultDisplayed = false;
  bool _isOperationSelected = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
        _isResultDisplayed = false;
        _isOperationSelected = false;
      } else if (value == '=') {
        if (_operation.isNotEmpty) {
          _num2 = double.tryParse(_display) ?? 0;
          switch (_operation) {
            case '+':
              _display = (_num1 + _num2).toString();
              break;
            case '-':
              _display = (_num1 - _num2).toString();
              break;
            case '*':
              _display = (_num1 * _num2).toString();
              break;
            case '/':
              if (_num2 != 0) {
                _display = (_num1 / _num2).toString();
              } else {
                _display = 'Error';
              }
              break;
          }
          _operation = '';
          _num1 = double.tryParse(_display) ?? 0;
          _isResultDisplayed = true;
          _isOperationSelected = false;
        }
      } else if (['+', '-', '*', '/'].contains(value)) {
        if (_isResultDisplayed) {
          // After displaying result, start new calculation with the last result
          _num1 = double.tryParse(_display) ?? 0;
          _operation = value;
          _display = _num1.toInt().toString(); // Display the previous number without decimal
          _isResultDisplayed = false;
          _isOperationSelected = true;
        } else {
          _num1 = double.tryParse(_display) ?? 0;
          _operation = value;
          _display = _num1.toInt().toString(); // Display the previous number without decimal
          _isOperationSelected = true;
        }
      } else {
        if (_display == '0' || _isResultDisplayed) {
          _display = value;
          _isResultDisplayed = false;
        } else if (_isOperationSelected) {
          _display = value;
          _isOperationSelected = false;
        } else {
          _display += value;
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
                  _display,
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