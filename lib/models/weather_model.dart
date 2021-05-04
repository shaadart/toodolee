import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 1)
class WeatherModel {
  @HiveField(0)
  String user_city;
  @HiveField(1)
  bool celciusMetric;

  

  WeatherModel(
      {this.user_city,
      this.celciusMetric}); //added false, value, if getting errors, remove "false" from here
  // flutter packages pub run build_runner build
}
