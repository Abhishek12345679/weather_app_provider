// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherType {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;

  const WeatherType({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'timezoneOffset': timezoneOffset,
      'current': current.toMap(),
    };
  }

  factory WeatherType.fromMap(Map<String, dynamic> map) {
    return WeatherType(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      timezone: map['timezone'] as String,
      timezoneOffset: map['timezone_offset'] as int,
      current: CurrentWeather.fromMap(map['current'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherType.fromJson(String source) =>
      WeatherType.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CurrentWeather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  // final double? windGust;
  final List<WeatherList>? weather;

  const CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    // this.windGust,
    required this.weather,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'feelsLike': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'dewPoint': dewPoint,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'windSpeed': windSpeed,
      'windDeg': windDeg,
      'weather': weather,
    };
  }

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      dt: map['dt'] as int,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
      temp: map['temp'] as double,
      feelsLike: map['feels_like'] as double,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      dewPoint: map['dew_point'] * 1.0
          as double, // dew_point * 1.0 converts int to double
      uvi: map['uvi'] * 1.0 as double,
      clouds: map['clouds'] as int,
      visibility: map['visibility'] as int,
      windSpeed: map['wind_speed'] * 1.0 as double,
      windDeg: map['wind_deg'] as int,
      weather: map['weather'] != null
          ? List<WeatherList>.from(
              (map['weather']).map<WeatherList?>(
                (x) => WeatherList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromJson(String source) =>
      CurrentWeather.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WeatherList {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherList({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherList.fromMap(Map<String, dynamic> map) {
    return WeatherList(
      id: map['id'] != null ? map['id'] as int : null,
      main: map['main'] != null ? map['main'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherList.fromJson(String source) =>
      WeatherList.fromMap(json.decode(source) as Map<String, dynamic>);
}
