import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/pages/search_page.dart';
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
          !value.isLoading ? displayWeather(context, value) : showLoadingUI(),
    );
  }
}

Widget showLoadingUI() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white10.withAlpha(10),
    ),
    margin: const EdgeInsets.all(20),
    child: const Center(
      child: CircularProgressIndicator(
        color: Colors.white60,
      ),
    ),
  );
}

Widget displayWeather(BuildContext context, value) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Today\'s Weather'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
          icon: const Icon(Icons.search),
        )
      ],
    ),
    body: const Column(
      children: [
        WeatherOverviewTile(),
        WeatherGrid(),
      ],
    ),
  );
}
