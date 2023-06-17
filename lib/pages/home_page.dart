import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_provider/models/current_weather_grid_item.dart';
import 'package:weather_app_provider/models/weather_type.dart';
import 'package:weather_app_provider/widgets/weather_grid_tile.dart';

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

    log(currentWeatherJSON.toString());

    return WeatherType.fromMap(currentWeatherJSON);
  }

  String getTimeFromUTC(DateTime dateTime) {
    final hour = dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}';
    final minute =
        dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}';
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather(),
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
                  SizedBox(
                    height: 200,
                    width: double.maxFinite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/${currentWeather?.current.weather?[0].icon}@4x.png',
                          width: 150,
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${currentWeather?.timezone}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${currentWeather?.current.temp.round()} °C',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Feels like ${currentWeather?.current.feelsLike.round()} °C',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                getTimeFromUTC(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        currentWeather!.current.dt * 1000)),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: GridView.count(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      padding: const EdgeInsets.all(20),
                      crossAxisCount: 2,
                      children: [
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Sunrise ☀️",
                            value: getTimeFromUTC(
                              DateTime.fromMillisecondsSinceEpoch(
                                currentWeather.current.sunrise * 1000,
                              ),
                            ),
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Sunset 🌕",
                            value: getTimeFromUTC(
                              DateTime.fromMillisecondsSinceEpoch(
                                currentWeather.current.sunset * 1000,
                              ),
                            ),
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Pressure",
                            value: '${currentWeather.current.pressure}',
                            // add a unit field (for ex: am,pm,hpa)
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Humidity",
                            value: '${currentWeather.current.humidity}%',
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Dew Point",
                            value:
                                '${currentWeather.current.dewPoint.round()} °C',
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "UV Index",
                            value: '${currentWeather.current.uvi}',
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Visibility",
                            value: '${currentWeather.current.visibility}m',
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Wind Speed",
                            value: '${currentWeather.current.windSpeed}m/s',
                          ),
                        ),
                        WeatherGridTile(
                          item: CurrentWeatherGridItem(
                            label: "Wind Degree",
                            value: '${currentWeather.current.windDeg}',
                          ),
                        ),
                      ],
                    ),
                  )
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
}
