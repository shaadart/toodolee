import 'dart:convert';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:hive/hive.dart';
import 'package:toodo/models/Weather Models/weatherDataService.dart';
import 'package:flutter/material.dart';
import 'package:toodo/models/Weather Models/weatherFromJson.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:toodo/models/weather_model.dart';
import 'package:toodo/pages/more.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flip_card/flip_card.dart';
//import 'package:http/http.dart' as http;

// lib
String user_units = "metric";
//String user_location;
Box<WeatherModel> weatherBox;
final TextEditingController getinitialweatherofLocation =
    TextEditingController();
String cityName = (getinitialweatherofLocation.text).toString();

class Weathercard extends StatefulWidget {
  const Weathercard({
    Key key,
  }) : super(key: key);

  @override
  _WeathercardState createState() => _WeathercardState();
}

class _WeathercardState extends State<Weathercard> {
  WeatherModel weather;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  double text_temperature = 0;

  String text_location = "Weather Card";
  String text_description = "Tap and Set your Location";
  DataService _dataService = DataService();
  final TextEditingController getweatherofLocation = TextEditingController();

  //String user_location = getweatherofLocation.text.toString();
  WeatherResponse _response;

  Future getWeather() async {
    // WeatherModel weatherUser =
    //     WeatherModel(user_city: response.cityName, celciusMetric: true);
    // weatherBox.add(weatherUser);
  }

  List<String> _thunderstorm = [
    "thunderstorm with light rain",
    "thunderstorm with rain",
    "thunderstorm with heavy rain",
    "light thunderstorm",
    "thunderstorm",
    "heavy thunderstorm",
    "ragged thunderstorm",
    "thunderstorm with light drizzle",
    "thunderstorm with drizzle",
    "thunderstorm with heavy drizzle"
  ];

  List<String> _rain = [
    "light rain",
    "moderate rain",
    "heavy intensity rain",
    "very heavy rain",
    "extreme rain",
    "freezing rain",
    "light intensity shower rain",
    "shower rain",
    "heavy intensity shower rain",
    "ragged shower rain"
  ];

  List<String> _snow = [
    "light snow",
    "Snow",
    "Heavy snow",
    "Sleet",
    "Light shower",
    "Shower sleet",
    "Light rain and snow",
    "Rain and snow",
    "Light shower",
    "Shower snow",
    "Heavy shower snow",
  ];

  List<String> _dizzle = [
    "light intensity drizzle",
    "drizzle",
    "heavy intensity drizzle",
    "light intensity drizzle rain",
    "drizzle rain",
    "heavy intensity drizzle rain",
    "shower rain and drizzle",
    "heavy shower rain and drizzle",
  ];
  List<String> _clouds = [
    "few clouds",
    "scattered clouds",
    'broken clouds',
    'overcast clouds'
  ];
  List<String> _atmosphere = [
    "mist",
    "smoke",
    "haze",
    "sand/ dust whirls",
    "sand",
    "dust",
    "volcanic",
    "squalls",
    "tornado",
  ];

  @override
  Widget build(BuildContext context) {
    return
        // FutureBuilder(
        //     future: getWeather(),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       // if (!snapshot.hasData) {
        //       //   return Container(
        //       //     child: Center(
        //       //       child: SizedBox(
        //       //         child: CircularProgressIndicator(),
        //       //         height: 60.0,
        //       //         width: 60.0,
        //       //       ),
        //       //     ),
        //       //   ); // I understand it will be empty for now
        //       // } else {
        //       child:
        FlipCard(
      direction: FlipDirection.VERTICAL,
      key: cardKey,
      front: Card(
        // color: Colors.transparent,
        child: GradientCard(
          gradient: Gradients.buildGradient(
              Alignment.topLeft, Alignment.bottomRight, [
            Colors.yellowAccent[100],
            Colors.amberAccent[100],
            Colors.amber[300]
          ]),
          semanticContainer: false,
          child: Wrap(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (_response != null)
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 20)),
                    Container(child: FadeInDown(
                      child: Icon((() {
                        if (text_description == "clear sky") {
                          return CarbonIcons.sun;
                          // } else if (text_description == "heavy intensity rain") {
                          //   return CarbonIcons.rain_scattered;
                        } else if (_clouds.contains(text_description)) {
                          return CarbonIcons.partly_cloudy;
                          // } else if (text_description == "scattered clouds") {
                          //   return CarbonIcons.cloud;
                          // } else if (text_description == "broken clouds") {
                          //   return CarbonIcons.cloudy;
                        } else if (_rain.contains(text_description)) {
                          return CarbonIcons.rain_heavy;
                        } else if (_rain.contains(text_description)) {
                          return CarbonIcons.rain_scattered;
                        } else if (_thunderstorm.contains(text_description)) {
                          return CarbonIcons.lightning;
                        } else if (_snow.contains(text_description)) {
                          return CarbonIcons.snowflake;
                        } else if (_atmosphere.contains(text_description)) {
                          return CarbonIcons.fog;
                        }

                        // your code here
                      })()),
                    )),
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 70)),
                    Container(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width / 50,
                                0,
                                MediaQuery.of(context).size.width / 50,
                                0),
                            child: Container(
                                padding: EdgeInsets.all(2),
                                child: Container(
                                  child: FadeIn(
                                    duration: Duration(milliseconds: 2000),
                                    child: Text("${text_temperature.toInt()}°",
                                        style: TextStyle(fontSize: 35)),
                                  ),
                                )))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlipInX(
                          child: Card(
                            child: ListTile(
                              title: Text(
                                "${text_location}",
                                //  "${text_location}",
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                "${text_description}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ButtonBar(
                    //   children: [
                    //     Align(
                    //         alignment: Alignment.bottomRight,
                    //         child: ListTile(
                    //             trailing: IconButton(
                    //                 onPressed: () {
                    //                   print("object");
                    //                 },
                    //                 icon: Icon(
                    //                   CarbonIcons.overflow_menu_horizontal,
                    //                 ))))
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      back: Card(
        // color: Colors.transparent,
        child: GradientCard(
          gradient: Gradients.buildGradient(
              Alignment.bottomLeft, Alignment.topRight, [
            Colors.yellowAccent[100],
            Colors.amberAccent[100],
            Colors.amber[300]
          ]),
          semanticContainer: false,
          child: Wrap(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 20)),
                    Container(
                      child: TextFormField(
                        autocorrect: true,
                        controller: getweatherofLocation,
                        decoration: InputDecoration(
                            hoverColor: Colors.amber,
                            border: InputBorder.none,
                            // prefixIcon: Icon(CarbonIcons.pen),
                            hintText: "City Name",
                            hintStyle: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w200),
                            contentPadding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 20)),
                      ),
                    ),
                    Container(
                      child: FlatButton.icon(
                        label: Text("Add City"),
                        color: Colors.white60,
                        icon: Icon(CarbonIcons.add),
                        onPressed: () async {
                          final response = await _dataService
                              .getWeather(getweatherofLocation.text);
                          // print(response);
                          print(response.cityName);
                          print(response.tempInfo.temperature);
                          print(response.weatherInfo.description);
                          // print(response.weatherInfo.description);
                          setState(() {
                            _response = response;
                            text_location = response.cityName;
                            text_description = response.weatherInfo.description;
                            text_temperature = response.tempInfo.temperature;
                            print(response.cityName);
                            print(response.tempInfo.temperature);
                            print(response.weatherInfo.description);

                            print(text_location);
                            print(text_description);
                            print(text_temperature);
                          });
                          // WeatherModel weatherinDb = WeatherModel(
                          //   user_city: getweatherofLocation.text,
                          //   celciusMetric: true,
                          // );
                          // weatherBox.add(weatherinDb);
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              color: (user_units == "metric")
                                  ? Colors.white70
                                  : Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  user_units = "metric";
                                });
                              },
                              child: Text("°C"),
                            ),
                          ),
                          VerticalDivider(color: Colors.black54),
                          Expanded(
                            child: FlatButton(
                              color: (user_units == "imperial")
                                  ? Colors.white70
                                  : Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  user_units = "imperial";
                                });
                              },
                              child: Text("°F"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //     else if (weatherBox.length > 0) {
      //   return Card(
      //     // color: Colors.transparent,
      //     child: GradientCard(
      //       gradient: Gradients.buildGradient(
      //           Alignment.bottomLeft, Alignment.topRight, [
      //         Colors.yellow[100],
      //         Colors.deepOrangeAccent[100],
      //         Colors.deepOrange[200]
      //       ]),
      //       semanticContainer: false,
      //       child: Wrap(
      //         children: [
      //           Center(
      //             child: Column(
      //               children: [
      //                 Padding(
      //                     padding: EdgeInsets.all(
      //                         MediaQuery.of(context).size.width / 20)),
      //                 Container(
      //                   child: TextFormField(
      //                     autocorrect: true,
      //                     controller: getinitialweatherofLocation,
      //                     decoration: InputDecoration(
      //                         hoverColor: Colors.amber,
      //                         border: InputBorder.none,
      //                         // prefixIcon: Icon(CarbonIcons.pen),
      //                         hintText: "City Name",
      //                         hintStyle: TextStyle(
      //                             color: Colors.black54,
      //                             fontWeight: FontWeight.w200),
      //                         contentPadding: EdgeInsets.all(
      //                             MediaQuery.of(context).size.width / 20)),
      //                   ),
      //                 ),
      //                 Container(
      //                   child: IntrinsicHeight(
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Expanded(
      //                           child: FlatButton(
      //                             onPressed: () {},
      //                             child: Text("°C"),
      //                           ),
      //                         ),
      //                         VerticalDivider(
      //                           color: Colors.black54,
      //                         ),
      //                         Expanded(
      //                           child: FlatButton(
      //                             onPressed: () {},
      //                             child: Text("°F"),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   child: FlatButton.icon(
      //                       label: Text("Add City"),
      //                       color: Colors.white60,
      //                       icon: Icon(CarbonIcons.add),
      //                       onPressed: () async {
      //                         // cardKey.currentState.toggleCard();
      //                         final response = await _dataService
      //                             .getWeather(getinitialweatherofLocation.text);
      //                         print(response);
      //                         print(response.cityName);
      //                         print(response.tempInfo.temperature);
      //                         print(response.weatherInfo.description);
      //                         // print(response.weatherInfo.description);
      //                         setState(() {
      //                           _response = response;
      //                         });
      //                         setState(() async {
      //                           text_temperature =
      //                               await _response.tempInfo.temperature;
      //                           user_city = await _response.cityName;
      //                           text_description =
      //                               await _response.weatherInfo.description;
      //                         });

      //                         WeatherModel weather = WeatherModel(
      //                           user_city: user_city,
      //                           celciusMetric: true,
      //                         );
      //                         await weatherBox.add(weather);
      //                       }),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // }
    );
  } //);
}
//}
