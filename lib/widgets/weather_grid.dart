import 'package:flutter/material.dart';
import 'package:weather_app_provider/models/weather_type.dart';
import 'package:weather_app_provider/widgets/weather_grid_tile.dart';

import '../models/current_weather_grid_item.dart';

class WeatherGrid extends StatefulWidget {
  final WeatherType currentWeather;
  const WeatherGrid({super.key, required this.currentWeather});

  @override
  State<WeatherGrid> createState() => _WeatherGridState();
}

class _WeatherGridState extends State<WeatherGrid> {
  String getTimeFromUTC(DateTime dateTime) {
    final hour = dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}';
    final minute =
        dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}';
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = widget.currentWeather;
    return Flexible(
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
              value: '${currentWeather.current.dewPoint.round()} °C',
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
    );
  }
}
