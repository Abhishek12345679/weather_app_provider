import 'package:flutter/material.dart';
import 'package:weather_app_provider/models/weather_type.dart';
import 'package:weather_app_provider/pages/home_page.dart';

class WeatherOverviewTile extends StatefulWidget {
  final WeatherType currentWeather;
  const WeatherOverviewTile({
    super.key,
    required this.currentWeather,
  });

  @override
  State<WeatherOverviewTile> createState() => _WeatherOverviewTileState();
}

class _WeatherOverviewTileState extends State<WeatherOverviewTile> {
  @override
  Widget build(BuildContext context) {
    final currentWeather = widget.currentWeather;
    return SizedBox(
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
                  currentWeather.timezone,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${currentWeather.current.temp.round()} °C',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Feels like ${currentWeather.current.feelsLike.round()} °C',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  getTimeFromUTC(
                    DateTime.fromMillisecondsSinceEpoch(
                      currentWeather.current.dt * 1000,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
