import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // api key
  final _WeatherServices = WeatherService('a4e43d4f2bc0faee001890b41974872f');
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
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/sun&rain.json';
      case 'thunderstrom':
        return 'assets/rain.json';

      case 'clear':
        return 'assets/sun.json';

      default:
        return 'assets/sun.json';
    }
  }

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

            Lottie.asset(getWeatherAnimation(_weather?.condition ?? "")),

            // Temperatre
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
