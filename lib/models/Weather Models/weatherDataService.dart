import 'dart:convert';
import 'package:toodo/pages/weatherCard.dart';
import 'package:http/http.dart' as http;
import 'package:toodo/models/Weather Models/weatherFromJson.dart';
// lib
class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    String apiKey = '59e6a8f324d53d9d9e6b22d35774321d';
    //"api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}";
    final queryParameteres = {'q': city, 'appid': apiKey, 'units': 'metric'};
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameteres);

    final response = await http.get(uri);
    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJSON(json);
  }
}
