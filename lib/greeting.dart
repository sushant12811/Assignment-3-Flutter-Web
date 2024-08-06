import 'package:flutter/material.dart';

// Define the GreetingPage widget as a StatelessWidget
class GreetingPage extends StatelessWidget {
  // ignore: use_super_parameters
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/1.avif",
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Center(
                child: Text(
                  'Image failed to load',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            },
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to the Flutter App!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/flutter.webp",
                    height: 150,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text(
                        'Image could not be loaded-error',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Experience features on our flutter app!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
