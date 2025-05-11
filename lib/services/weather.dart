import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '43bafc3ecb8dd6e80af39f2338df7307';
const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    // Get the current position
    Location location = Location();
    await location.getCurrentLocation();

    // Get weather data
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
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

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getBackgroundImage(int? temperature) {
    if (temperature == null) return 'images/location_background.jpg';

    if (temperature > 25) {
      return 'images/hot.jpeg'; // Hot weather background
    } else if (temperature > 20) {
      return 'images/warm.jpeg'; // Warm weather background
    } else if (temperature < 10) {
      return 'images/cold.jpeg'; // Cold weather background
    } else {
      return 'images/mild.jpeg'; // Mild weather background
    }
  }
}
