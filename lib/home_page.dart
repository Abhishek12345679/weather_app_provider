import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final Position? location;
  const HomePage({super.key, this.location});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic> getWeather() async {
    final location = widget.location;
    final client = http.Client();
    final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    final url = Uri.parse(
        "https://api.openweathermap.org/data/3.0/onecall?lat=${location?.latitude}&lon=${location?.longitude}&exclude={part}&appid=$apiKey");

    final response = await client.get(url);

    final currentWeatherJSON = json.decode(response.body);

    log('current weather: $currentWeatherJSON');

    return currentWeatherJSON;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Today\'s Weather'),
          ),
          body: Text(
              'lat: ${widget.location != null ? widget.location?.timestamp : ""}'),
        );
      },
    );
  }
}
