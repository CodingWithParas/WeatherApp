
import 'package:flutter/material.dart';
import 'package:weather/Activity/home.dart';
import 'package:weather/Activity/loading.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: Home(), isko run krne ki jarurat nahi hai kyu ki routes mai run kr diya hai Bydefault wala
    routes: {
      "/" : (context) => Loading(), // ye wala
      "/home" : (context) => Home(),
      "/loading" : (context) => Loading(),
    },
  ));
}
