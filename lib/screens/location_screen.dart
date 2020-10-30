import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temp;
  String tempIcon;
  String city;
  String message;
  String climate;
  int minTemp;
  int maxTemp;
  int feelsLike;
  int humidity, pressure;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = widget.weatherData;
    print(data);
    update(data);
  }

  void update(dynamic weatherData) {
    setState(() {
      double t = weatherData['main']['temp'].toDouble();
      temp = t.toInt();
      var cond = weatherData['weather'][0]['id'];
      tempIcon = weatherModel.getWeatherIcon(cond);
      city = weatherData['name'];
      message = weatherModel.getMessage(temp);

      double t1 = weatherData['main']['temp_min'].toDouble();
      minTemp = t1.toInt();
      double t2 = weatherData['main']['temp_max'].toDouble();
      maxTemp = t.toInt();

      climate = weatherData['weather'][0]['main'];
      double fl = weatherData['main']['feels_like'].toDouble();
      feelsLike = fl.toInt();

      humidity = weatherData['main']['humidity'];
      pressure = weatherData['main']['pressure'];
//     print(minTemp);
//     print(maxTemp);
//     print(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.getLocationData();
                        update(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 40.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        String cityName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));
                        if (cityName != null) {
                          var weatherData =
                              await weatherModel.getCityData(cityName);
                          update(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 70.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '$temp°C',
                            //                  temp.toInt().toString(),
                            style: kTempTextStyle,
                          ),
                          Text(
                            tempIcon,
                            style: kConditionTextStyle,
                          ),
                          Text(
                            ',$climate',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '😃 Feels Like:',
                            //                  temp.toInt().toString(),
                            style: kConditionTextStyle,
                          ),
                          Text(
                            '$feelsLike°C',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '💧 Humidity:',
                            //                  temp.toInt().toString(),
                            style: kConditionTextStyle,
                          ),
                          Text(
                            '$humidity%',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Pressure:',
                            //                  temp.toInt().toString(),
                            style: kConditionTextStyle,
                          ),
                          Text(
                            '$pressure mBar',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
//                  "It's 🍦 time in San Francisco!",
                    '$message in $city',

                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Chance of RainRain: 0 %
//HumidityHumidity: 89%
//PressurePressure: 1009 mb
//CloudCloud: 50%
//VisibilityVisibility: 4 km
//😃 Smileys & People
//🐻 Animals & Nature
//🍔 Food & Drink
//⚽ Activity
//🌇 Travel & Places
//💡 Objects
//🔣 Symbols
//🎌 Flags
