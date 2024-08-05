import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  TempPageState createState() => TempPageState();
}

class TempPageState extends State<TempPage> {
  final String _city = 'London';
  String _temperature = '';
  String _weatherDescription = '';
  String _error = '';

  // Replace this with your actual API key
  final _apiKey = '406873bf744ce97d89ab71327c91d6d1';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'http://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$_apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperature = '${data['main']['temp']}°C';
          _weatherDescription = data['weather'][0]['description'];
          _error = '';
        });
      } else {
        setState(() {
          _error = 'Failed to load data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Weather in $_city',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (_error.isNotEmpty)
                Text(
                  _error,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                )
              else if (_temperature.isNotEmpty)
                Column(
                  children: <Widget>[
                    Text(
                      _temperature,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _weatherDescription,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchData,
                child: const Text('Refresh Data'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
