//import 'dart:convert';
//import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cron/cron.dart';
import 'package:hive/hive.dart';
import 'package:toodo/main.dart';
import 'package:toodo/models/Weather Models/weatherDataService.dart';
import 'package:flutter/material.dart';
import 'package:toodo/models/Weather Models/weatherFromJson.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'dart:async';
import 'package:toodo/pages/more.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:toodo/processes.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:http/http.dart' as http;

// lib
// Box<WeatherModel> weatherinDb;
String user_units = "metric";
//Box<WeatherModel> userWeatherBox;
// WeatherModel weatherinDb;
//String user_location;
String city;
final TextEditingController getinitialweatherofLocation =
    TextEditingController();

bool celciusMetric = true;
var weatherBox = Hive.box(weatherBoxname);

class Weathercard extends StatefulWidget {
  const Weathercard({
    Key key,
  }) : super(key: key);

  @override
  _WeathercardState createState() => _WeathercardState();
}

class _WeathercardState extends State<Weathercard> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  // String initial_text_location = "";
  // String initial_text_description = "...";
  // double initial_text_temperature;

  double text_temperature;
  String text_location;
  String text_description;
  DataService _dataService = DataService();
  TextEditingController getweatherofLocation = TextEditingController();

  //String user_location = getweatherofLocation.text.toString();
  WeatherResponse _response;
  WeatherResponse _initialresponse;

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
    'overcast clouds',
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
    final player = AudioCache();
    // print(weatherBox.keys);
    // print(weatherBox.values);
    print("${weatherBox.values} = are values");
    print("${weatherBox.keys} = are keys");
    print('${weatherBox.get("location")} is the value of location');

    //print((weatherinDb.user_city));
    return ValueListenableBuilder(
        valueListenable: Hive.box(weatherBoxname).listenable(),
        builder: (context, userWeatherBox, child) => userWeatherBox
                    .get("location") ==
                null
            ? Card(
                // color: Colors.transparent,
                child: GradientCard(
                  gradient: Gradients.buildGradient(
                      Alignment.bottomLeft, Alignment.topRight, [
                    Colors.orange[100],
                    Colors.amberAccent[100],
                    Colors.teal[300],
                  ]),
                  //semanticContainer: false,
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
                                controller: getinitialweatherofLocation,
                                decoration: InputDecoration(
                                    hoverColor: Colors.amber,
                                    border: InputBorder.none,
                                    // prefixIcon: Icon(CarbonIcons.pen),
                                    hintText: "Type City Name",
                                    hintStyle: TextStyle(
                                        //color: Colors.black54,
                                        fontWeight: FontWeight.w200),
                                    contentPadding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width /
                                            20)),
                              ),
                            ),
                            Container(
                                child: FlatButton.icon(
                                    label: Text("Add City"),
                                    color: Colors.white60,
                                    icon: Icon(CarbonIcons.add),
                                    onPressed: () async {
                                      player.play(
                                        'sounds/navigation_forward-selection-minimal.wav',
                                        stayAwake: false,
                                        // mode: PlayerMode.LOW_LATENCY,
                                      );

                                      String user_city;
                                      user_city =
                                          getinitialweatherofLocation.text;

                                      weatherBox.put("location",
                                          [user_city, celciusMetric]);

                                      // print(
                                      //     "${getWeatherData(weatherBox.get("location")[0])} is the you know that current getweatherData");

                                      // print(
                                      //     "${getWeatherData()} is the you know that current getweatherData");
                                      final response = await _dataService
                                          .getWeather(user_city);
                                      setState(() {
                                        _response = response;
                                        text_location =
                                            weatherBox.get("location")[0];
                                        text_description =
                                            response.weatherInfo.description;
                                        text_temperature =
                                            response.tempInfo.temperature;
                                        print(response.cityName);
                                        print(response.tempInfo.temperature);
                                        print(response.weatherInfo.description);

                                        print(text_location);
                                        print(text_description);
                                        print(text_temperature);
                                      });

                                      await weatherBox.put("weatherofuser", [
                                        text_temperature,
                                        text_description,
                                      ]);
                                    })),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                      color: (user_units == "metric")
                                          ? Colors.white70
                                          : Colors.transparent,
                                      onPressed: () {
                                        player.play(
                                          'sounds/navigation_forward-selection-minimal.wav',
                                          stayAwake: false,
                                          // mode: PlayerMode.LOW_LATENCY,
                                        );
                                        setState(() {
                                          user_units = "metric";
                                          celciusMetric = true;
                                        });
                                      },
                                      child: Text("°C"),
                                    ),
                                  ),
                                  VerticalDivider(
                                      //color: Colors.black54
                                      ),
                                  Expanded(
                                    child: FlatButton(
                                      color: (user_units == "imperial")
                                          ? Colors.white70
                                          : Colors.transparent,
                                      onPressed: () {
                                        player.play(
                                          'sounds/navigation_forward-selection-minimal.wav',
                                          stayAwake: false,
                                          // mode: PlayerMode.LOW_LATENCY,
                                        );
                                        setState(() {
                                          user_units = "imperial";
                                          celciusMetric = false;
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
              )
            // print(
            //     "${} is the you know that current getweatherData");

            : FutureBuilder(
                future: getWeatherData(weatherBox.get("location")[0]),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (text_description == null &&
                      weatherBox.get("weatherofuser") == null) {
                    player.play(
                      'sounds/ui_loading.wav',
                      stayAwake: false,
                      // mode: PlayerMode.LOW_LATENCY,
                    );
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                                height: 60.0,
                                width: 60.0,
                              ),
                            ),
                          ),
                          FlatButton.icon(
                              label: Text("Reset City"),
                              color: Colors.white60,
                              icon: Icon(CarbonIcons.add),
                              onPressed: () async {
                                player.play(
                                  'sounds/navigation_forward-selection-minimal.wav',
                                  stayAwake: false,
                                  // mode: PlayerMode.LOW_LATENCY,
                                );
                                weatherBox.delete("location");
                              })
                        ],
                      ),
                    );
                  } else {
                    return FlipCard(
                      direction: FlipDirection.VERTICAL,
                      key: cardKey,
                      front: Card(
                        // color: Colors.transparent,
                        child: GradientCard(
                          semanticContainer: false,
                          gradient: (() {
                            if (weatherBox.get("weatherofuser")[1] ==
                                "clear sky") {
                              return Gradients.buildGradient(
                                  Alignment.topLeft, Alignment.bottomRight, [
                                Colors.yellowAccent[100],
                                Colors.amberAccent[100],
                                Colors.amber[300]
                              ]);
                            } else if (_clouds
                                .contains(weatherBox.get("weatherofuser")[1])) {
                              return Gradients.buildGradient(
                                  Alignment.topRight, Alignment.topLeft, [
                                //Colors.blueAccent[400],
                                // Colors.blueAccent,
                                Colors.blue[100],
                                Colors.blue[100],
                                Colors.blue[50],
                                Colors.blue[100],
                                Colors.blue[50],
                              ]);
                            } else if (_rain
                                .contains(weatherBox.get("weatherofuser")[1])) {
                              return Gradients.buildGradient(
                                  Alignment.topLeft, Alignment.topRight, [
                                //Colors.blueAccent[400],
                                Colors.blueAccent[100],
                                Colors.blue[100],
                                Colors.blue[300],
                                Colors.blue[200],
                                Colors.blue[100]
                              ]);
                            } else if (_thunderstorm
                                .contains(weatherBox.get("weatherofuser")[1])) {
                              return Gradients.buildGradient(
                                  Alignment.topLeft, Alignment.topRight, [
                                //Colors.blueAccent[400],
                                Colors.indigo[600],
                                Colors.indigo[400],
                                Colors.indigo[100],
                                Colors.indigo[200],
                              ]);
                            } else if (_snow
                                .contains(weatherBox.get("weatherofuser")[1])) {
                              return Gradients.buildGradient(
                                  Alignment.topLeft, Alignment.topRight, [
                                //Colors.blueAccent[400],

                                Colors.yellow[50],
                                Colors.yellow[50],
                                Colors.yellow[50],
                                Colors.yellow[50],
                                Colors.yellow[50],
                                Colors.yellow[50],
                                Colors.amber[50],

                                Colors.white,
                              ]);
                            } else if (_atmosphere
                                .contains(weatherBox.get("weatherofuser")[1])) {
                              return Gradients.buildGradient(
                                  Alignment.topLeft, Alignment.topRight, [
                                //Colors.blueAccent[400],

                                Colors.green, Colors.amber,
                                Colors.deepPurple,
                                Colors.indigo,
                                Colors.pink,
                              ]);
                            }
                          }()),
                          child: Wrap(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (_response != null)
                                      Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20)),
                                    Container(
                                      child: Icon((() {
                                        if (weatherBox
                                                .get("weatherofuser")[1] ==
                                            "clear sky") {
                                          return CarbonIcons.sun;
                                          // } else if (weatherBox.get("location")[1] == "heavy intensity rain") {
                                          //   return CarbonIcons.rain_scattered;
                                        } else if (_clouds.contains(weatherBox
                                            .get("weatherofuser")[1])) {
                                          return CarbonIcons.partly_cloudy;
                                          // } else if (weatherBox.get("location")[1] == "scattered clouds") {
                                          //   return CarbonIcons.cloud;
                                          // } else if (weatherBox.get("location")[1] == "broken clouds") {
                                          //   return CarbonIcons.cloudy;
                                        } else if (_rain.contains(weatherBox
                                            .get("weatherofuser")[1])) {
                                          return CarbonIcons.rain_heavy;
                                        } else if (_rain.contains(weatherBox
                                            .get("weatherofuser")[1])) {
                                          return CarbonIcons.rain_scattered;
                                        } else if (_thunderstorm.contains(
                                            weatherBox
                                                .get("weatherofuser")[1])) {
                                          return CarbonIcons.lightning;
                                        } else if (_snow.contains(weatherBox
                                            .get("weatherofuser")[1])) {
                                          return CarbonIcons.snowflake;
                                        } else if (_atmosphere.contains(
                                            weatherBox
                                                .get("weatherofuser")[1])) {
                                          return CarbonIcons.fog;
                                        }

                                        // your code here
                                      })()),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width /
                                                70)),
                                    Container(
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                                0,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                                0),
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              child: Container(
                                                child: Text(
                                                    "${weatherBox.get("weatherofuser")[0].toInt()}°",
                                                    style: TextStyle(
                                                        fontSize: 35)),
                                              ),
                                            ))),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Card(
                                          child: ListTile(
                                            title: Text(
                                              "${weatherBox.get("location")[0]}",
                                              //  "${text_location}",
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Text(
                                              "${weatherBox.get("weatherofuser")[1]}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[300],
                            Colors.yellow[100],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[200],
                            Colors.yellow[300],
                            Colors.yellow[300],
                          ]),
                          //semanticContainer: false,
                          child: Wrap(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width /
                                                20)),
                                    Container(
                                      child: TextFormField(
                                        autocorrect: true,
                                        controller: getweatherofLocation,
                                        decoration: InputDecoration(
                                            hoverColor: Colors.amber,
                                            border: InputBorder.none,
                                            // prefixIcon: Icon(CarbonIcons.pen),
                                            hintText: "Write City Name",
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontWeight: FontWeight.w200),
                                            contentPadding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20)),
                                      ),
                                    ),
                                    Container(
                                      child: FlatButton.icon(
                                        label: Text("Add City"),
                                        color: Theme.of(context).primaryColor,
                                        icon: Icon(CarbonIcons.add),
                                        onPressed: () async {
                                          //Temporary
                                          player.play(
                                            'sounds/navigation_forward-selection-minimal.wav',
                                            stayAwake: false,
                                            // mode: PlayerMode.LOW_LATENCY,
                                          );
                                          String user_city;

                                          user_city = getweatherofLocation.text;

                                          await weatherBox.put("location",
                                              [user_city, celciusMetric]);

                                          await weatherBox.put(
                                              "weatherofuser", [
                                            text_temperature,
                                            text_description
                                          ]);
                                          getWeatherData(
                                              weatherBox.get("location")[0]);

                                          cardKey.currentState.toggleCard();
                                          // getWeatherData(weatherBox
                                          //     .get("location")[0]
                                          //     .toString());
                                          // userWeatherBox.put(
                                          //     "location", null);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FlatButton(
                                              color: (user_units == "metric")
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.transparent,
                                              onPressed: () {
                                                player.play(
                                                  'sounds/navigation_forward-selection-minimal.wav',
                                                  stayAwake: false,
                                                  // mode: PlayerMode.LOW_LATENCY,
                                                );

                                                setState(() {
                                                  user_units = "metric";
                                                });
                                              },
                                              child: Text("°C"),
                                            ),
                                          ),
                                          VerticalDivider(
                                              //   color: Colors.black54
                                              ),
                                          Expanded(
                                            child: FlatButton(
                                              color: (user_units == "imperial")
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.transparent,
                                              onPressed: () {
                                                player.play(
                                                  'sounds/navigation_forward-selection-minimal.wav',
                                                  stayAwake: false,
                                                  // mode: PlayerMode.LOW_LATENCY,
                                                );
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
                    );
                  }
                }));
  }

  Future getWeatherData(city) async {
    final response =
        await _dataService.getWeather(weatherBox.get("location")[0]);
    // print(response);
    print(response.cityName);
    print(response.tempInfo.temperature);
    print(response.weatherInfo.description);
    // print(response.weatherInfo.description);

    _response = response;
    text_location = response.cityName;
    text_description = response.weatherInfo.description;
    text_temperature = response.tempInfo.temperature;

    // print(response.cityName);
    // print(response.tempInfo.temperature);
    // print(response.weatherInfo.description);

    // print(text_location);
    // print(text_description);
    // print(text_temperature);

    weatherBox.put("weatherofuser", [text_temperature, text_description]);
    // userWeatherBox.put(
    //     "location", weather);
  }
}
