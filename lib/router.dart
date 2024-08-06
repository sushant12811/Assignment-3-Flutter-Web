import 'package:assignment3/qr_generator.dart';
import 'package:flutter/material.dart';
import 'greeting.dart';
import 'calculator.dart';
import 'temp.dart';



//Route to different page
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) 
    {
      case '/':
        return MaterialPageRoute(builder: (_) => GreetingPage());
      case '/calculator':
        return MaterialPageRoute(builder: (_) => CalculatorPage());
      case '/temp':
        return MaterialPageRoute(builder: (_) => TempPage());
      case '/qr':
        return MaterialPageRoute(builder: (_) => QrGenerator());
      default:
        return MaterialPageRoute(builder: (_) => GreetingPage());
    }
  }
}
