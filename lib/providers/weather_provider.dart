// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app_provider/models/weather_type.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherProvider extends ChangeNotifier {
  bool loading = false;
  late final WeatherType currentWeather;

  Future<void> getWeather({required Position? location}) async {
    loading = true;
    final client = http.Client();
    final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    final url = Uri.parse(
      "https://api.openweathermap.org/data/3.0/onecall?lat=${location?.latitude}&lon=${location?.longitude}&exclude=minutely,hourly,daily,alerts&appid=$apiKey&units=metric",
    );

    final response = await client.get(url);

    final currentWeatherJSON = json.decode(response.body);

    currentWeather = WeatherType.fromMap(currentWeatherJSON);
    loading = false;

    notifyListeners();
  }
}
