


class WeatherInfo {
  final String description;
  WeatherInfo({this.description});

  factory WeatherInfo.fromJSON(Map<String, dynamic> json) {
    final description = json['description'];
    return WeatherInfo(description: description);
  }
}

class TemperatureInfo {
  final double temperature;
  TemperatureInfo({this.temperature});

  factory TemperatureInfo.fromJSON(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class WeatherResponse {
  final String cityName;
  // final Temperature temperature;
  final WeatherInfo weatherInfo;
  final TemperatureInfo tempInfo;

  WeatherResponse(
      {this.cityName, this.tempInfo, this.weatherInfo}); // this.temperature

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    final cityName = json['name'];
    final temperatureInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJSON(temperatureInfoJson);
    final weatherInfojson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJSON(weatherInfojson);
    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo); //, weatherInfo: weatherInfo
  }
}
