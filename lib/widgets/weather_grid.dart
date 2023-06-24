import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/pages/home_page.dart';
import 'package:weather_app_provider/providers/location_provider.dart';
import 'package:weather_app_provider/providers/weather_provider.dart';
import 'package:weather_app_provider/widgets/weather_grid_tile.dart';

import '../models/current_weather_grid_item.dart';

class WeatherGrid extends StatefulWidget {
  const WeatherGrid({
    super.key,
  });

  @override
  State<WeatherGrid> createState() => _WeatherGridState();
}

class _WeatherGridState extends State<WeatherGrid> {
  @override
  void initState() {
    super.initState();
    final currentLocation =
        Provider.of<LocationProvider>(context, listen: false).currentLocation;
    Provider.of<WeatherProvider>(context, listen: false)
        .getWeather(location: currentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, value, child) {
      return Flexible(
        child: value.loading
            ? showLoadingUI()
            : GridView.count(
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
                          value.currentWeather!.current.sunrise * 1000,
                        ),
                      ),
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Sunset 🌕",
                      value: getTimeFromUTC(
                        DateTime.fromMillisecondsSinceEpoch(
                          value.currentWeather!.current.sunset * 1000,
                        ),
                      ),
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Pressure",
                      value: '${value.currentWeather!.current.pressure}',
                      // add a unit field (for ex: am,pm,hpa)
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Humidity",
                      value: '${value.currentWeather!.current.humidity}%',
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Dew Point",
                      value:
                          '${value.currentWeather!.current.dewPoint.round()} °C',
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "UV Index 🥵",
                      value: '${value.currentWeather!.current.uvi}',
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Visibility",
                      value: '${value.currentWeather!.current.visibility}m',
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Wind 🌬️",
                      value: '${value.currentWeather!.current.windSpeed}m/s',
                    ),
                  ),
                  WeatherGridTile(
                    item: CurrentWeatherGridItem(
                      label: "Wind Degree",
                      value: '${value.currentWeather!.current.windDeg}',
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
