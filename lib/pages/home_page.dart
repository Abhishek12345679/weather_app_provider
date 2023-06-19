import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/providers/location_provider.dart';
import 'package:weather_app_provider/widgets/weather_grid.dart';
import 'package:weather_app_provider/widgets/weather_overview_tile.dart';

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
  return Scaffold(
    appBar: AppBar(
      title: const Text('Today\'s Weather'),
    ),
    body: const Column(
      children: [
        WeatherOverviewTile(),
        WeatherGrid(),
      ],
    ),
  );
}
