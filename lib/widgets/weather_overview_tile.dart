import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/pages/home_page.dart';
import 'package:weather_app_provider/providers/weather_provider.dart';

class WeatherOverviewTile extends StatelessWidget {
  const WeatherOverviewTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${value.currentWeather.current.weather?[0].icon}@4x.png',
              width: 150,
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value.currentWeather.timezone,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${value.currentWeather.current.temp.round()} °C',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Feels like ${value.currentWeather.current.feelsLike.round()} °C',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    getTimeFromUTC(
                      DateTime.fromMillisecondsSinceEpoch(
                        value.currentWeather.current.dt * 1000,
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
      ),
    );
  }
}
