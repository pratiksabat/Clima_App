import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apiKeys='ae2f9b5092d7de19df73efde24b4202c';
const weatherAPIURL='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {

  Future<dynamic> getCityData(String cityName) async
  {
    var url='$weatherAPIURL?q=$cityName&appid=$apiKeys&units=metric';
    NetworkHelper networkHelper= NetworkHelper(url);
    var weatherData=await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationData() async
  {
    Location location= new Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = new NetworkHelper('$weatherAPIURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKeys&units=metric');
    var weatherData=await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
//const a='⛅
//🌀	🌁	🌅
//🌂	🌈	🌃
//'