import 'package:flutter/material.dart';

@immutable
class CurrentWeatherGridItem {
  final String label;
  final String value;

  const CurrentWeatherGridItem({
    required this.label,
    required this.value,
  });

  @override
  String toString() => 'CurrentWeatherGridItem(label: $label, value: $value)';
}
