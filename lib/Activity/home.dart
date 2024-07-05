import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("set state called.");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }


  @override
  Widget build(BuildContext context) {

    var city_name = ["Agra", "Mumbai", "Delhi", "Gujarat", "Goa", "Chennai"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    var info = ModalRoute.of(context)!.settings.arguments as Map;

    String  _temp = ((info["temp_value"]).toString());
    String _wind = ((info["air_speed_value"]).toString());
    if(_temp  == "N/A"){
      print("Check Name");
    }else{
      _temp = ((info["temp_value"]).toString()).substring(0,4);
      _wind = ((info["air_speed_value"]).toString()).substring(0,4);
    }
    String icon = info["icon_value"];
    String getcity = info["city_value"];
    String hum = info["hum_value"];
    String des = info["des_value"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(

          backgroundColor: Colors.lightBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue, Colors.blueAccent],
              ),
            ),
            child: Column(
              children: [
                Container(
                  // search wala container
                  padding:  EdgeInsets.symmetric(horizontal: 8),
                  margin:
                       EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "")== ""){
                            print("Blank Space");
                          }else{
                            Navigator.pushNamed(context, "/loading", arguments: {
                              "searchText" : searchController.text,
                            });
                          }
                        },
                        child: Container(
                          margin:  EdgeInsets.fromLTRB(3, 0, 10, 0),
                          child:  Icon(
                            Icons.search,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                       Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (searchController){
                              print(searchController);

                            },
                              controller: searchController,
                            decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search your City Name Here!! And Click On Search Icon"),
                            style: TextStyle(fontSize: 14),
                          ),
                       ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin:  EdgeInsets.symmetric(horizontal: 25),
                        padding:  EdgeInsets.all(25),
                        child:  Row(
                          children: [
                            Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text("In $getcity",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin:  EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        padding:  EdgeInsets.all(26),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              WeatherIcons.thermometer,
                              size: 35,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 92),
                              child: Text(
                                "Temperature",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$_temp",
                                    style: TextStyle(fontSize: 70),
                                  ),
                                  Text(
                                    "C",
                                    style: TextStyle(fontSize: 30),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: const EdgeInsets.all(26),
                        height: 200,
                        child:  Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  WeatherIcons.day_cloudy_windy,
                                  size: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Wind",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$_wind",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Km/hr",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: const EdgeInsets.all(26),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 6),
                                  child: Text("Humidity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("$hum",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text("Percent", style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Created By: Paras Sharma",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
