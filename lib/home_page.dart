import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_provider/models/weather_type.dart';

class HomePage extends StatefulWidget {
  final Position? location;
  const HomePage({super.key, this.location});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WeatherType?> getWeather() async {
    final location = widget.location;
    final client = http.Client();
    final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    final url = Uri.parse(
      "https://api.openweathermap.org/data/3.0/onecall?lat=${location?.latitude}&lon=${location?.longitude}&exclude=minutely,hourly,daily,alerts&appid=$apiKey&units=metric",
    );

    final response = await client.get(url);

    final currentWeatherJSON = json.decode(response.body);

    log('current weather: $currentWeatherJSON');

    // if (currentWeatherJSON != null) {
    final weather = WeatherType.fromMap(currentWeatherJSON);
    return weather;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather(),
      builder: (context, snapshot) {
        final currentWeather = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            log(currentWeather.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Today\'s Weather'),
              ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    height: 300,
                    width: double.maxFinite,
                    child: Column(children: [
                      Container(
                        height: 200,
                        width: double.maxFinite,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            '${currentWeather?.current.temp} C',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            );

          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
