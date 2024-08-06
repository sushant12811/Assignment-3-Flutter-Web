import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TempPage extends StatefulWidget {
  // ignore: use_super_parameters
  const TempPage({Key? key}) : super(key: key);

  @override
  TempPageState createState() => TempPageState();
}

class TempPageState extends State<TempPage> {
  final String city = 'Barrie';
  String temperature = '';
  String weatherDescription = '';
  String error = '';

  // API key
  final apiKey = '406873bf744ce97d89ab71327c91d6d1';

  @override
  void initState() {
    super.initState();
    fetchData();
  }


//Url with integrated API key and city name
  Future<void> fetchData() async {
    final url = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = '${data['main']['temp']}°C';
          weatherDescription = data['weather'][0]['description'];
          error = '';
        });
      } else {
        setState(() {
          error = 'Failed to load data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'An error occurred: $e';
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
                'Weather in $city',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (error.isNotEmpty)
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                )
              else if (temperature.isNotEmpty)
                Column(
                  children: <Widget>[
                    Text(
                      temperature,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      weatherDescription,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchData,
                // ignore: sort_child_properties_last
                child: const Text('Refresh'),
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
