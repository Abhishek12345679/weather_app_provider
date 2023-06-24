// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocCoord {
  final double latitude;
  final double longitude;

  const LocCoord({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocCoord.fromMap(Map<String, dynamic> map) {
    return LocCoord(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocCoord.fromJson(String source) =>
      LocCoord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocCoord(latitude: $latitude, longitude: $longitude)';
}

class LocationProvider extends ChangeNotifier {
  late LocCoord? currentLocation;
  bool isLoading = true;

  Future<void> getCurrentLocation() async {
    isLoading = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final curLoc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    final curLocJson = curLoc.toJson();
    currentLocation = LocCoord.fromMap(curLocJson);
    isLoading = false;
    notifyListeners();
  }

  void setLocation(LocCoord xy) {
    currentLocation = xy;
    notifyListeners();
  }
}
