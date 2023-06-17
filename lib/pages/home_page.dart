import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/models/weather_type.dart';
import 'package:weather_app_provider/providers/location_provider.dart';
import 'package:weather_app_provider/widgets/weather_grid.dart';
import 'package:weather_app_provider/widgets/weather_overview_tile.dart';

Future<WeatherType?> getWeather({required Position? location}) async {
  final client = http.Client();
  final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
  final url = Uri.parse(
    "https://api.openweathermap.org/data/3.0/onecall?lat=${location?.latitude}&lon=${location?.longitude}&exclude=minutely,hourly,daily,alerts&appid=$apiKey&units=metric",
  );

  final response = await client.get(url);

  final currentWeatherJSON = json.decode(response.body);

  return WeatherType.fromMap(currentWeatherJSON);
}

String getTimeFromUTC(DateTime dateTime) {
  final hour = dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}';
  final minute = dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}';
  return '$hour:$minute';
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    provider.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, value, child) =>
          !value.isLoading ? displayWeather(value) : showLoadingUI(),
    );
  }
}

Widget showLoadingUI() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget displayWeather(value) {
  return FutureBuilder(
    future: getWeather(location: value.currentLocation),
    builder: (context, snapshot) {
      final currentWeather = snapshot.data;
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          return Scaffold(
            appBar: AppBar(
              title: const Text('Today\'s Weather'),
            ),
            body: Column(
              children: [
                WeatherOverviewTile(currentWeather: currentWeather!),
                WeatherGrid(currentWeather: currentWeather),
              ],
            ),
          );
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    },
  );
}
