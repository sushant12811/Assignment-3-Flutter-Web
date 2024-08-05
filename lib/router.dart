import 'package:flutter/material.dart';
import 'greeting.dart';
import 'calculator.dart';
import 'notes.dart';
import 'api.dart';
import 'map.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => GreetingPage());
      case '/calculator':
        return MaterialPageRoute(builder: (_) => CalculatorPage());
      case '/notes':
        return MaterialPageRoute(builder: (_) => NotesPage());
      case '/api':
        return MaterialPageRoute(builder: (_) => ApiPage());
      case '/map':
        return MaterialPageRoute(builder: (_) => MapPage());
      default:
        return MaterialPageRoute(builder: (_) => GreetingPage());
    }
  }
}
