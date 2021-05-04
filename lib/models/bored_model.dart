import 'package:hive/hive.dart';


part 'bored_model.g.dart';
@HiveType(typeId: 2)
class BoredModel {
  @HiveField(0)
  String boringActivity;
  @HiveField(1)
  String boringType;
  @HiveField(2)
  String boringLink;

  BoredModel({this.boringActivity, this.boringType, this.boringLink});
}


// 

// part 'weather_model.g.dart';

// @HiveType(typeId: 1)
// class WeatherModel {
//   @HiveField(0)
//   String user_city;
//   @HiveField(1)
//   bool celciusMetric;

  

//   WeatherModel(
//       {this.user_city,
//       this.celciusMetric}); //added false, value, if getting errors, remove "false" from here
//   // flutter packages pub run build_runner build
// }
