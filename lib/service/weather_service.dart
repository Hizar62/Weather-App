import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather_model.dart';

class WeatherService {
  static const BASE_URL =
      'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={apikey}';
  final String apikey;

  WeatherService(this.apikey);

  // Get Weather
  Future<Weather> getWeather(String cityName) async {
    final Response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));

    if (Response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(Response.body));
    } else {
      throw Exception("Unable to Load Weather");
    }
  }

  // Getting Current City
  Future<String> getCurrentCity() async {
    // Permission from the user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // getting current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // convert location into list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
