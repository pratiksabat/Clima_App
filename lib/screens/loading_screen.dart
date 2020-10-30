import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationData();
    //print(weatherData['main']['temp']);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                weatherData: weatherData,
              )),
    );
    // getWeatherData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
