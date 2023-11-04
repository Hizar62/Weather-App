import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // api key
  final _WeatherServices = WeatherService('0e1bfece6d6c691aa78ab9f3009c68ce');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    String cityName = await _WeatherServices.getCurrentCity();

    try {
      final weather = await _WeatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animation

  @override
  void initState() {
    super.initState();
    // on Start Fetching Weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City
            Text(_weather?.cityName ?? "Loading City .."),

            // Temperatre
            Text('${_weather?.temperature.round()}C')
          ],
        ),
      ),
    );
  }
}
