import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_provider/models/searched_place.dart';
import 'package:weather_app_provider/utils/debouncer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchedPlace> searchedPlaces = [];

  Future<void> searchPlace(String input) async {
    const url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final response = await http.get(
      Uri.parse(
        '$url?input=$input&types=geocode&key=${dotenv.env['PLACES_API_KEY']}',
      ),
    );
    final responseJson = jsonDecode(response.body);
    log('place: ${responseJson}');
    final places = SearchedPlaceResponse.fromJson(responseJson);
    setState(() {
      searchedPlaces = places.predictions;
    });
  }

  final debouncer = Debouncer(
    delay: const Duration(milliseconds: 350),
  );

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter New Location",
          ),
          onChanged: (value) {
            debouncer.call(() {
              searchPlace(value);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final place = searchedPlaces.elementAt(index);
          return ListTile(
            title: Text(place.structuredFormatting.mainText),
            subtitle: Text(place.structuredFormatting.secondaryText),
          );
        },
        itemCount: searchedPlaces.length,
      ),
    );
  }
}
