import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meteo2/models/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=1ff64c39efa9435ba054d2e67c8171b3&units=metric");

    var resposne = await http.get(endpoint);
    var body = jsonDecode(resposne.body);
    print(Weather.fromJson(body).cityName);

    return Weather.fromJson(body);
  }
}
