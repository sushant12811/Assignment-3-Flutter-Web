import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';

// This is a stateful widget which will generate a QR code
// It will display a text field to enter the text to generate the QR code
// It will display a button to generate the QR code
// It will display the QR code

class QrGenerator extends StatefulWidget {
  const QrGenerator({super.key});

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  // This controller is used to get the text from the text field
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter text to generate QR code',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Generate QR code'),
            ),
            const SizedBox(height: 20),
            // If the text field is not empty, display the QR code
            if (_controller.text.isNotEmpty)
              SizedBox(
                  height: 200,
                  width: 200,
                  child: QRCode(data: _controller.text)),
          ],
        ),
      )),
    );
  }
}
