// Class  -  different, method
// instance - different data;

import 'dart:convert';
import 'package:http/http.dart';

class worker {
  late String location;
  //Constructor
  worker({required this.location}) {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  // method = sari information nikal ke degi
  Future<void> getData() async {
    try {
      Response response = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=bb32c309b041ff49dbfc08a7f5e89124'));
      Map data = jsonDecode(response.body);

      // Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];



      print(data);
      // Getting Temp, Humidity
      Map temp_data = data['main'];
      int getHumidity = temp_data['humidity'];
      double getTemp = temp_data['temp'] - 273.15;

      // Getting air_speed
      Map wind = data['wind'];
      double getAir_speed = wind['speed'] / 0.2778;

      // Assigning Value
      temp = getTemp.toString();
      humidity = getHumidity.toString();
      air_speed = getAir_speed.toString();
      description = getDesc; // they allready in string
      main = getMain_des;
      icon = weather_main_data["icon"];

    } catch (e) {
      temp = "N/A";
      humidity = "N/A";
      air_speed = "N/A";
      description = "Can't Find Data"; // they allready in string
      main = "N/A";
      icon = "03n";
    }
  }
}
