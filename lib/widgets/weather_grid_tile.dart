// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_app_provider/models/current_weather_grid_item.dart';

class WeatherGridTile extends StatefulWidget {
  final CurrentWeatherGridItem item;
  const WeatherGridTile({super.key, required this.item});

  @override
  State<WeatherGridTile> createState() => _WeatherGridTileState();
}

class _WeatherGridTileState extends State<WeatherGridTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white70.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.label,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              widget.item.value.toString(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
